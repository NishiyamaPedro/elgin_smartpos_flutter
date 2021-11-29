package com.nishiyama.smartpos_flutter

import android.app.AlertDialog
import android.content.Context
import android.content.DialogInterface
import br.com.setis.interfaceautomacao.Confirmacoes
import br.com.setis.interfaceautomacao.Transacoes
import com.elgin.e1.Impressora.Termica

object ElginPay {
    var transacoes: Transacoes? = null
    var confirmacoes: Confirmacoes = Confirmacoes()

    fun showDialog(
            context: Context,
            positiveOnClick: DialogInterface.OnClickListener? = null,
            negativeOnClick: DialogInterface.OnClickListener? = null
    ) {
        val builder = AlertDialog.Builder(context)

        builder.setTitle("Nota Estabelecimento")

        builder.setMessage("Imprimir Via do estabelecimento?")
        builder.setPositiveButton(
                "Sim",
                positiveOnClick
        )

        if (negativeOnClick != null)
            builder.setNegativeButton(
                    "Não",
                    negativeOnClick
            )

        val alertDialog: AlertDialog = builder.create()
        alertDialog.setCanceledOnTouchOutside(false)
        alertDialog.setCancelable(false)
        alertDialog.show()
    }

    fun imprimeLista(a: List<String>) {
        for (b in a.indices) {
            Termica.ImpressaoTexto(a[b], 0, 0, 0)
            Termica.AvancaPapel(1)
        }
    }
}