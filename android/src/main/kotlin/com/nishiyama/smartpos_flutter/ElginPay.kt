package com.nishiyama.smartpos_flutter

import androidx.annotation.NonNull
import android.content.Context
import android.os.Handler
import android.os.Looper
import android.os.Message
import android.app.AlertDialog
import android.content.DialogInterface
import android.view.ContextThemeWrapper

import br.com.setis.interfaceautomacao.*
import br.com.setis.interfaceautomacao.Personalizacao
import br.com.setis.interfaceautomacao.StatusTransacao
import br.com.setis.interfaceautomacao.ViasImpressao

import com.elgin.e1.Impressora.Termica
import br.com.setis.interfaceautomacao.Confirmacoes

import br.com.setis.interfaceautomacao.Transacoes
import io.flutter.embedding.android.FlutterActivity

enum class Status {
    OPERACAO_EXECUTADA,
    TRANSACAO_PENDENTE,
    OPERACAO_CONFIRMADA,
    OPERACAO_FINALIZADA
}

class ElginPay(
    @NonNull val entradaTransacao: EntradaTransacao,
    @NonNull val handler: Handler,
    @NonNull val context: Context,
    @NonNull val activity: FlutterActivity
) : Thread() {
    companion object {
        lateinit var dadosAutomacao: DadosAutomacao
        var personalizacaoCliente: Personalizacao? = null

        fun init(
            empresaAutomacao: String,
            nomeAutomacao: String,
            versaoAutomacao: String,
            suportaTroco: Boolean,
            suportaDesconto: Boolean,
            suportaViasDiferenciadas: Boolean,
            suportaViaReduzida: Boolean,
            suportaAbatimentoSaldoVoucher: Boolean
        ) {
            val pb = Personalizacao.Builder()
            personalizacaoCliente = pb.build()
            dadosAutomacao = DadosAutomacao(
                empresaAutomacao,
                nomeAutomacao,
                versaoAutomacao,
                suportaTroco,
                suportaDesconto,
                suportaViasDiferenciadas,
                suportaViaReduzida,
                suportaAbatimentoSaldoVoucher,
                personalizacaoCliente
            )
        }

        fun configTema(
            corFonte: String? = "#000000",
            corFonteTeclado: String?,
            corFundoToolbar: String?,
            corFundoTela: String?,
            corTeclaLiberadaTeclado: String?,
            corFundoTeclado: String?,
            corTextoCaixaEdicao: String?,
            corSeparadorMenu: String?
        ) {
            val pb = Personalizacao.Builder()

            if (corFonte!!.isNotBlank()) {
                pb.informaCorFonte(corFonte)
            }
            if (corFonteTeclado!!.isNotBlank()) {
                pb.informaCorFonteTeclado(corFonteTeclado)
            }
            if (corFundoToolbar!!.isNotBlank()) {
                pb.informaCorFundoToolbar(corFundoToolbar)
            }
            if (corFundoTela!!.isNotBlank()) {
                pb.informaCorFundoTela(corFundoTela)
            }
            if (corTeclaLiberadaTeclado!!.isNotBlank()) {
                pb.informaCorTeclaLiberadaTeclado(corTeclaLiberadaTeclado)
            }
            if (corFundoTeclado!!.isNotBlank()) {
                pb.informaCorFundoTeclado(corFundoTeclado)
            }
            if (corTextoCaixaEdicao!!.isNotBlank()) {
                pb.informaCorTextoCaixaEdicao(corTextoCaixaEdicao)
            }
            if (corSeparadorMenu!!.isNotBlank()) {
                pb.informaCorSeparadorMenu(corSeparadorMenu)
            }

            personalizacaoCliente = pb.build()
        }

        fun imprimeLista(a: List<String>) {
            for (b in a.indices) {
                Termica.ImpressaoTexto(a[b], 0, 0, 0)
                Termica.AvancaPapel(1)
            }
        }

        private fun showDialog(
            activity: FlutterActivity,
            dialogGroup: DialogGroup,
            saidaTransacao: SaidaTransacao? = null,
            positiveOnClick: DialogInterface.OnClickListener? = null,
            negativeOnClick: DialogInterface.OnClickListener? = null
        ) {
            val builder = AlertDialog.Builder(ContextThemeWrapper(activity, R.style.Theme_AppCompat_DayNight))

            builder.setTitle(DialogText.strings[dialogGroup.ordinal]["title"])

            var msg = DialogText.strings[dialogGroup.ordinal]["message"]

            if (dialogGroup != DialogGroup.ERRO_IMPRESSAO)
                msg =
                    saidaTransacao!!.obtemMensagemResultado() + "\n\n" + DialogText.strings[dialogGroup.ordinal]["message"]

            builder.setMessage(msg)
            builder.setPositiveButton(
                DialogText.strings[dialogGroup.ordinal]["positiveButton"],
                positiveOnClick
            )

            if (negativeOnClick != null)
                builder.setNegativeButton(
                    DialogText.strings[dialogGroup.ordinal]["negativeButton"],
                    negativeOnClick
                )

            val alertDialog: AlertDialog = builder.create()
            alertDialog.setCanceledOnTouchOutside(false)
            alertDialog.setCancelable(false)
            alertDialog.show()
        }
    }

    private var saidaTransacao: SaidaTransacao? = null
    private var transacoes: Transacoes? = null
    private var message: Message? = null
    private var confirmacoes: Confirmacoes? = null

    private val lHandler: Handler = object : Handler(Looper.getMainLooper()) {
        override fun handleMessage(msg: Message) {
            when (msg.what) {
                Status.OPERACAO_EXECUTADA.ordinal -> confirmarOperacao()
                Status.TRANSACAO_PENDENTE.ordinal -> resolveTransacaoPendente()
                Status.OPERACAO_CONFIRMADA.ordinal -> imprimeComprovante()
                else -> finalizarOperacao()
            }
        }
    }

    private fun confirmarOperacao() {
        if (saidaTransacao!!.obtemInformacaoConfirmacao()
            && saidaTransacao!!.obtemResultadoTransacao() == 0
        ) {
            confirmacoes!!.informaIdentificadorConfirmacaoTransacao(saidaTransacao!!.obtemIdentificadorConfirmacaoTransacao())
            confirmacoes!!.informaStatusTransacao(StatusTransacao.CONFIRMADO_AUTOMATICO)
            transacoes!!.confirmaTransacao(confirmacoes!!)
        }

        message = Message()
        message!!.what = Status.OPERACAO_CONFIRMADA.ordinal
        lHandler.sendMessage(message!!)
    }

    private fun resolveTransacaoPendente() {
        message = Message()

        fun positiveClick() =
            DialogInterface.OnClickListener { dialog, id ->
                confirmacoes!!.informaStatusTransacao(StatusTransacao.CONFIRMADO_AUTOMATICO)
                transacoes!!.resolvePendencia(
                    saidaTransacao!!.obtemDadosTransacaoPendente()!!,
                    confirmacoes!!
                )
                message!!.what = Status.OPERACAO_FINALIZADA.ordinal
                lHandler.sendMessage(message!!)
                dialog.dismiss()
            }

        fun negativeClick() =
            DialogInterface.OnClickListener { dialog, id ->
                confirmacoes!!.informaStatusTransacao(StatusTransacao.DESFEITO_MANUAL)
                transacoes!!.resolvePendencia(
                    saidaTransacao!!.obtemDadosTransacaoPendente()!!,
                    confirmacoes!!
                )
                message!!.what = Status.OPERACAO_FINALIZADA.ordinal
                lHandler.sendMessage(message!!)
                dialog.dismiss()
            }

        showDialog(
            activity,
            DialogGroup.ERRO_OPERACAO,
            saidaTransacao,
            positiveClick(),
            negativeClick()
        )
    }

    private fun imprimeComprovante() {
        message = Message()
        val v = saidaTransacao!!.obtemViasImprimir()

        if (v == ViasImpressao.VIA_NENHUMA) {
            message!!.what = Status.OPERACAO_FINALIZADA.ordinal
            lHandler.sendMessage(message!!)
            return
        }

        Termica.setContext(context)
        Termica.AbreConexaoImpressora(5, "SMARTPOS", "", 0)

        val ret: Int = Termica.StatusImpressora(0)

        fun positiveClick() =
            DialogInterface.OnClickListener { dialog, id ->
                Termica.FechaConexaoImpressora()
                imprimeComprovante()
                dialog.dismiss()
            }

        fun negativeClick() =
            DialogInterface.OnClickListener { dialog, id ->
                Termica.FechaConexaoImpressora()
                message!!.what = Status.OPERACAO_FINALIZADA.ordinal
                lHandler.sendMessage(message!!)
                dialog.dismiss()
            }

        if (ret != 5) {
            showDialog(
                activity,
                DialogGroup.ERRO_IMPRESSAO,
                positiveOnClick = positiveClick(),
                negativeOnClick = negativeClick()
            )
        } else {
            when (v) {
                ViasImpressao.VIA_CLIENTE_E_ESTABELECIMENTO -> {
                    var comprovante = saidaTransacao!!.obtemComprovanteDiferenciadoLoja()
                    if (comprovante == null || comprovante.size <= 1) {
                        comprovante = saidaTransacao!!.obtemComprovanteCompleto()
                    }
                    imprimeLista(comprovante)

                    Termica.AvancaPapel(4)
                    Termica.FechaConexaoImpressora()

                    fun positiveClick() =
                        DialogInterface.OnClickListener { dialog, id ->
                            saidaTransacao!!.informaViasImprimir(ViasImpressao.VIA_CLIENTE)
                            imprimeComprovante()
                            dialog.dismiss()
                        }

                    fun negativeClick() =
                        DialogInterface.OnClickListener { dialog, id ->
                            message!!.what = Status.OPERACAO_FINALIZADA.ordinal
                            lHandler.sendMessage(message!!)
                            dialog.dismiss()
                        }

                    showDialog(
                        activity,
                        DialogGroup.IMPRESSAO_CLIENTE,
                        saidaTransacao,
                        positiveClick(),
                        negativeClick()
                    )
                }
                ViasImpressao.VIA_CLIENTE -> {
                    var comprovante = saidaTransacao!!.obtemComprovanteDiferenciadoPortador()
                    if (comprovante == null || comprovante.size <= 1) {
                        comprovante = saidaTransacao!!.obtemComprovanteCompleto()
                    }
                    imprimeLista(comprovante)

                    Termica.AvancaPapel(4)
                    Termica.FechaConexaoImpressora()

                    message!!.what = Status.OPERACAO_FINALIZADA.ordinal
                    lHandler.sendMessage(message!!)
                }
                ViasImpressao.VIA_ESTABELECIMENTO -> {
                    var comprovante = saidaTransacao!!.obtemComprovanteDiferenciadoLoja()
                    if (comprovante == null || comprovante.size <= 1) {
                        comprovante = saidaTransacao!!.obtemComprovanteCompleto()
                    }
                    imprimeLista(comprovante)

                    Termica.AvancaPapel(4)
                    Termica.FechaConexaoImpressora()

                    message!!.what = Status.OPERACAO_FINALIZADA.ordinal
                    lHandler.sendMessage(message!!)
                }
                else -> {
                    Termica.FechaConexaoImpressora()

                    message!!.what = Status.OPERACAO_FINALIZADA.ordinal
                    lHandler.sendMessage(message!!)
                }
            }
        }
    }

    private fun finalizarOperacao() {
        fun positiveClick() =
            DialogInterface.OnClickListener { dialog, id ->
                dialog.dismiss()
            }
        showDialog(
            activity,
            DialogGroup.RETORNO,
            saidaTransacao,
            positiveClick()
        )

        message = Message()
        message!!.obj = saidaTransacao
        handler.sendMessage(message!!)
    }

    override fun run() {
        transacoes = Transacoes.obtemInstancia(dadosAutomacao, context)
        confirmacoes = Confirmacoes()
        message = Message()
        try {
            saidaTransacao = transacoes!!.realizaTransacao(entradaTransacao)

            if (saidaTransacao!!.existeTransacaoPendente()) message!!.what =
                Status.TRANSACAO_PENDENTE.ordinal
            else message!!.what = Status.OPERACAO_EXECUTADA.ordinal

            lHandler.sendMessage(message!!)
        } catch (e: Exception) {
            message!!.what = Status.OPERACAO_FINALIZADA.ordinal
            lHandler.sendMessage(message!!)
        }
    }
}