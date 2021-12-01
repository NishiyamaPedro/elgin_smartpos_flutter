package com.nishiyama.smartpos_flutter

import com.elgin.e1.Comunicacao.Conexao
import com.elgin.e1.Impressora.Config.dsImpressora
import com.elgin.e1.Impressora.Impressoras.*
import com.elgin.e1.Impressora.Termica
import com.elgin.e1.Impressora.Utilidades.Utilidades
import com.elgin.e1.Impressora.XML.ImplementacaoOBJXMLNFCE
import com.elgin.e1.Servico.ServicoE1
import java.lang.reflect.Field
import java.nio.charset.Charset
import java.util.*
import android.app.AlertDialog
import android.content.Context

import android.content.DialogInterface




class NFCeSAT{
    companion object {
        fun Print(viacliente: Boolean, dados: String, indexcsc: Int, csc: String, param: Int): Int {
            val impHack = Termica::class.java.getDeclaredField("imp")
            impHack.isAccessible = true
            val imp = impHack.get(ImplementacaoTermica::class.java) as ImplementacaoTermica

            var result = 0

            val spHack = imp::class.java.getDeclaredField("sp")
            spHack.isAccessible = true

            val conHack = imp::class.java.getDeclaredField("con")
            conHack.isAccessible = true

            return if (Conexao.getTipo() == 10) {
                -403
            } else {
                BitSet(16)
                val p = Utilidades.intToBits(param)
                val objNfce = ImplementacaoOBJXMLNFCE(dados.toByteArray())
                var `val` = -9999
                if (Conexao.getTipo() == 0) {
                    -4
                } else if (param in 0..65535) {
                    objNfce.ConstroiOBJ()
                    var variavel = objNfce.getProp("nfeProc|NFe|infNFe|versao")
                    if (variavel == "") {
                        -102
                    } else {
                        result = -101

                        var id: Int

                        if (variavel == "4.00") {
                            result = 0
                        }

                        if (result != 0) {
                            result
                        } else {
                            variavel = objNfce.GetTpEmis()
                            if (variavel.isEmpty()) {
                                -103
                            } else {
                                id = Utilidades.getInt(variavel)
                                if (id == 0) {
                                    -103
                                } else {
                                    if (id > 1) {
                                        if (Conexao.getTipo() == 5) {
                                            val implementacaoSmartPOS = ImplementacaoSmartPOS(conHack.get(imp) as Conexao, imp)

                                            val sepHack = ImplementacaoAndroid::class.java.getDeclaredField("sepCont")
                                            sepHack.isAccessible = true
                                            sepHack.set(implementacaoSmartPOS, "")

                                            val controleNFCeHack = ImplementacaoAndroid::class.java.getDeclaredField("controleNFCe")
                                            controleNFCeHack.isAccessible = true

                                            if (viacliente) {
                                                controleNFCeHack.set(null, false)
                                            } else {
                                                controleNFCeHack.set(null, true)
                                            }

                                            spHack.set(imp, implementacaoSmartPOS)

                                            `val` = (spHack.get(imp) as ImplementacaoSmartPOS).EnviaDadosNFCeImpressao(objNfce, indexcsc, csc, id, param)
                                        }
                                        if (`val` != 0) {
                                            return `val`
                                        }

                                        if (viacliente) {
                                            Termica.AvancaPapel(4)
                                        }
                                    }

                                    `val`
                                }
                            }
                        }
                    }
                } else {
                    -104
                }
            }
        }
    }
}