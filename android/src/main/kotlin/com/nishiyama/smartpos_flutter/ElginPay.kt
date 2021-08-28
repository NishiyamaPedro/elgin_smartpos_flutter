package com.nishiyama.smartpos_flutter

import androidx.annotation.NonNull
import android.content.Context
import android.os.Handler
import android.os.Looper
import android.os.Message;
import android.app.AlertDialog
import android.content.DialogInterface
import android.graphics.BitmapFactory
import android.util.Base64

import br.com.setis.interfaceautomacao.*
import br.com.setis.interfaceautomacao.Personalizacao
import br.com.setis.interfaceautomacao.StatusTransacao
import br.com.setis.interfaceautomacao.ViasImpressao

import com.elgin.e1.Impressora.Termica
import com.elgin.e1.Impressora.Utilidades.CodigoErro

enum class Status {
    OPERACAO_EXECUTADA,
    TRANSACAO_PENDENTE,
    OPERACAO_CONFIRMADA,
    OPERACAO_FINALIZADA
}

class ElginPay(
    @NonNull val entradaTransacao: EntradaTransacao,
    @NonNull val handler: Handler,
    @NonNull val context: Context
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
            corFonte: String?,
            corFonteTeclado: String?,
            corFundoToolbar: String?,
            corFundoTela: String?,
            corTeclaLiberadaTeclado: String?,
            corFundoTeclado: String?,
            corTextoCaixaEdicao: String?,
            corSeparadorMenu: String?
        ) {
            val pb = Personalizacao.Builder()

            if (corFonte != null) {
                pb.informaCorFonte(corFonte)
            };
            if (corFonteTeclado != null) {
                pb.informaCorFonteTeclado(corFonteTeclado)
            };
            if (corFundoToolbar != null) {
                pb.informaCorFundoToolbar(corFundoToolbar)
            };
            if (corFundoTela != null) {
                pb.informaCorFundoTela(corFundoTela)
            };
            if (corTeclaLiberadaTeclado != null) {
                pb.informaCorTeclaLiberadaTeclado(corTeclaLiberadaTeclado)
            };
            if (corFundoTeclado != null) {
                pb.informaCorFundoTeclado(corFundoTeclado)
            };
            if (corTextoCaixaEdicao != null) {
                pb.informaCorTextoCaixaEdicao(corTextoCaixaEdicao)
            };
            if (corSeparadorMenu != null) {
                pb.informaCorSeparadorMenu(corSeparadorMenu)
            };

            personalizacaoCliente = pb.build()
        }

        fun imprimeLista(a: List<String>) {
            for (b in a.indices) {
                Termica.ImpressaoTexto(a[b], 0, 1, 0)
            }
        }

        private fun showDialog(
            context: Context,
            dialogGroup: DialogGroup,
            saidaTransacao: SaidaTransacao? = null,
            positiveOnClick: DialogInterface.OnClickListener? = null,
            negativeOnClick: DialogInterface.OnClickListener? = null
        ) {
            val builder = AlertDialog.Builder(context)

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
    private val transacoes: Transacoes? = null
    private var message: Message? = null
    private val confirmacoes: Confirmacoes? = null

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
        handler.sendMessage(message!!)
    }

    private fun resolveTransacaoPendente() {
        message = Message()

        showDialog(
            context,
            DialogGroup.ERRO_OPERACAO,
            positiveOnClick = DialogInterface.OnClickListener
            { _: DialogInterface, _: Int ->
                confirmacoes!!.informaStatusTransacao(StatusTransacao.CONFIRMADO_AUTOMATICO)
                transacoes!!.resolvePendencia(
                    saidaTransacao!!.obtemDadosTransacaoPendente()!!,
                    confirmacoes!!
                )
                message!!.what = Status.OPERACAO_FINALIZADA.ordinal
                handler.sendMessage(message!!)
            },
            negativeOnClick = DialogInterface.OnClickListener
            { _: DialogInterface, _: Int -> /* Code */
                confirmacoes!!.informaStatusTransacao(StatusTransacao.DESFEITO_MANUAL)
                transacoes!!.resolvePendencia(
                    saidaTransacao!!.obtemDadosTransacaoPendente()!!,
                    confirmacoes!!
                )
                message!!.what = Status.OPERACAO_FINALIZADA.ordinal
                handler.sendMessage(message!!)
            }
        )
    }

    private fun imprimeComprovante() {
        message = Message()
        val v = saidaTransacao!!.obtemViasImprimir()

        if (v == ViasImpressao.VIA_NENHUMA) {
            message!!.what = Status.OPERACAO_FINALIZADA.ordinal
            handler.sendMessage(message!!)
            return
        }

        Termica.setContext(context)
        Termica.AbreConexaoImpressora(5, "SMARTPOS", "", 0)

        val ret: Int = Termica.StatusImpressora(0)
        if (ret != 5) {
            showDialog(
                context,
                DialogGroup.ERRO_IMPRESSAO,
                positiveOnClick = DialogInterface.OnClickListener
                { _: DialogInterface, _: Int ->
                    Termica.FechaConexaoImpressora()
                    imprimeComprovante()
                },
                negativeOnClick = DialogInterface.OnClickListener
                { _: DialogInterface, _: Int -> /* Code */
                    Termica.FechaConexaoImpressora();
                    message!!.what = Status.OPERACAO_FINALIZADA.ordinal;
                    handler.sendMessage(message!!);
                }
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

                    showDialog(
                        context,
                        DialogGroup.IMPRESSAO_CLIENTE,
                        positiveOnClick = DialogInterface.OnClickListener
                        { _: DialogInterface, _: Int ->
                            saidaTransacao!!.informaViasImprimir(ViasImpressao.VIA_CLIENTE)
                            imprimeComprovante()
                        },
                        negativeOnClick = DialogInterface.OnClickListener
                        { _: DialogInterface, _: Int -> /* Code */
                            message!!.what = Status.OPERACAO_FINALIZADA.ordinal
                            handler.sendMessage(message!!)
                        }
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
                    handler.sendMessage(message!!)
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
                    handler.sendMessage(message!!)
                }
            }
        }
    }

    private fun finalizarOperacao() {
        showDialog(
            context,
            DialogGroup.RETORNO
        )

        message = Message()
        message!!.obj = saidaTransacao
        handler.sendMessage(message!!)
    }

    override fun run() {
        message = Message()
        try {
            saidaTransacao = transacoes!!.realizaTransacao(entradaTransacao!!)

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