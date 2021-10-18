package com.nishiyama.smartpos_flutter

import android.content.Context
import android.os.Handler
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import android.os.Looper
import android.os.Message
import br.com.setis.interfaceautomacao.*
import com.elgin.e1.Impressora.Termica
import com.google.gson.Gson
import com.google.gson.GsonBuilder
import io.flutter.embedding.android.FlutterActivity
import java.util.*
import com.google.gson.JsonPrimitive

import com.google.gson.JsonSerializationContext

import com.google.gson.JsonElement

import com.google.gson.JsonSyntaxException

import com.google.gson.JsonParseException

import com.google.gson.JsonDeserializationContext

import com.google.gson.JsonDeserializer

import com.google.gson.JsonSerializer
import java.lang.IllegalArgumentException
import java.lang.reflect.Type
import java.security.Timestamp
import java.text.DateFormat
import java.text.ParseException
import java.text.SimpleDateFormat
import kotlin.concurrent.thread


internal class Handlers(var context: Context, val activity: FlutterActivity) : MethodChannel.MethodCallHandler {
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
                val handler: Handler = object : Handler(Looper.getMainLooper()) {
                    override fun handleMessage(msg: Message) {
                        result.success(Gson().toJson(msg.obj as SaidaTransacao))
                    }
                }

                val gson = GsonBuilder()
                    .registerTypeAdapter(Date::class.java, DateAdapter())
                    .setDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS")
                    .create()

                val entradaTransacao = gson.fromJson(call.arguments as String, EntradaTransacao::class.java)

                thread {
                    val saidaTransacao = ElginPay.transacoes!!.realizaTransacao(entradaTransacao)
                    val message = Message()
                    message!!.obj = saidaTransacao
                    handler.sendMessage(message!!)
                }
            }
            "confirmaTransacao" -> {
               val confirmacoes = Gson().fromJson(call.arguments as String, Confirmacoes::class.java)

                thread {
                    ElginPay.transacoes!!.confirmaTransacao(confirmacoes)
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
                    Termica.setContext(context)
                    Termica.AbreConexaoImpressora(5, "SMARTPOS", "", 0)

                    ElginPay.imprimeLista(call.argument<List<String>>("strings")!!)

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