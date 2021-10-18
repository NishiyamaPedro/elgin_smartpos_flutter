package com.nishiyama.smartpos_flutter

import br.com.setis.interfaceautomacao.Confirmacoes
import br.com.setis.interfaceautomacao.Transacoes
import com.elgin.e1.Impressora.Termica

object ElginPay {
    var transacoes: Transacoes? = null
    var confirmacoes: Confirmacoes = Confirmacoes()

    fun imprimeLista(a: List<String>) {
        for (b in a.indices) {
            Termica.ImpressaoTexto(a[b], 0, 0, 0)
            Termica.AvancaPapel(1)
        }
    }
}