package com.nishiyama.smartpos_flutter

import android.app.Activity
import android.content.Context
import android.graphics.Bitmap
import android.graphics.BitmapFactory
import android.os.Build
import android.os.Handler
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import android.os.Looper
import android.os.Message
import br.com.setis.interfaceautomacao.*
import com.elgin.e1.Impressora.Termica
import com.google.gson.Gson
import com.google.gson.GsonBuilder
import android.util.Base64
import java.util.*
import kotlin.concurrent.thread

internal class Handlers(var context: Context, var activity: Activity) : MethodChannel.MethodCallHandler {
    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        when (call.method) {
            "init" -> {
                try {
                    val dadosAutomacao = Gson().fromJson(call.arguments as String, DadosAutomacao::class.java)
                    ElginPay.transacoes = Transacoes.obtemInstancia(dadosAutomacao, context)

                    result.success(true)
                } catch (e: Exception) {
                    result.error("Init error", e.message, null)
                }
            }
            "iniciarTransacao" -> {
                val gson = GsonBuilder()
                    .registerTypeAdapter(Date::class.java, DateAdapter())
                    .setDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS")
                    .create()

                val handler: Handler = object : Handler(Looper.getMainLooper()) {
                    override fun handleMessage(msg: Message) {
                        result.success(gson.toJson(msg.obj as SaidaTransacao))
                    }
                }

                val entradaTransacao = gson.fromJson(call.arguments as String, EntradaTransacao::class.java)

                thread {
                    val saidaTransacao = ElginPay.transacoes!!.realizaTransacao(entradaTransacao)
                    val message = Message()
                    message!!.obj = saidaTransacao
                    handler.sendMessage(message!!)
                }
            }
            "confirmaTransacao" -> {
                val handler: Handler = object : Handler(Looper.getMainLooper()) {
                    override fun handleMessage(msg: Message) {
                        result.success(true)
                    }
                }

                val confirmacoes = Gson().fromJson(call.arguments as String, Confirmacoes::class.java)

                thread {
                    ElginPay.transacoes!!.confirmaTransacao(confirmacoes)
                    handler.sendMessage(Message())
                }
            }
            "resolvePendencia" -> {
                val transacoesPendenteDados =  Gson().fromJson((call.arguments as ArrayList<String>)[0], TransacaoPendenteDados::class.java)
                val confirmacoes = Gson().fromJson((call.arguments as ArrayList<String>)[1], Confirmacoes::class.java)

                thread {
                    ElginPay.transacoes!!.resolvePendencia(transacoesPendenteDados, confirmacoes)
                }
            }
            "imprimir" -> {
                try {
                    Termica.setActivity(activity)
                    Termica.AbreConexaoImpressora(5, "", "", 0)

                    ElginPay.imprimeLista(call.argument<List<String>>("strings")!!)

                    Termica.AvancaPapel(4)
                    Termica.FechaConexaoImpressora()

                    result.success(true)
                } catch (e: Exception) {
                    result.success(false)
                }
            }
            "imprimirImagem" -> {
                try {
                    if ((call.arguments as String).isNullOrEmpty()){
                        return result.success(false)
                    }

                    var data = Base64.decode(call.arguments as String, Base64.DEFAULT)
                    var bitmapImage: Bitmap = BitmapFactory.decodeByteArray(data, 0, data.size);

                    Termica.setActivity(activity)
                    Termica.AbreConexaoImpressora(5, "", "", 0)

                    Termica.ImprimeBitmap(bitmapImage)

                    Termica.AvancaPapel(4)
                    Termica.FechaConexaoImpressora()

                    result.success(true)
                } catch (e: Exception) {
                    result.success(false)
                }
            }
            "isElginPOS" -> {
                try {
                    val devices = listOf("EP5855","MiniPDV M8", "MiniPDV M10")
                    val model = Build.MODEL

                    if (devices.contains(model))
                        result.success(true)
                    else
                        result.success(false)
                } catch (e: Exception) {
                    result.success(false)
                }
            }
            "imprimirNFCe" -> {
                try {
                    Termica.setActivity(activity)
                    Termica.AbreConexaoImpressora(5, "", "", 0)

                    val viaCliente = (call.argument<Int>("via") == 1)

                    NFCeSAT.Print(viaCliente, call.argument<String>("xml") as String,call.argument<Int>("indexcsc")!!,call.argument<String>("csc") as String, call.argument<Int>("param")!!)

                    Termica.AvancaPapel(4)
                    Termica.FechaConexaoImpressora()

                    result.success(true)
                } catch (e: Exception) {
                    result.success(false)
                }

            }
            else -> result.notImplemented()
        }
    }
}