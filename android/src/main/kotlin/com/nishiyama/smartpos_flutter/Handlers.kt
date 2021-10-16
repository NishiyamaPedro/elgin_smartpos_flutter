package com.nishiyama.smartpos_flutter

import android.content.Context
import android.os.Handler
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import br.com.setis.interfaceautomacao.EntradaTransacao
import br.com.setis.interfaceautomacao.SaidaTransacao
import android.os.Looper
import android.os.Message
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


internal class Handlers(var context: Context, val activity: FlutterActivity) : MethodChannel.MethodCallHandler {
    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        when (call.method) {
            "init" -> {
                try {
                    ElginPay.init(
                        call.argument<String>("empresaAutomacao")!!,
                        call.argument<String>("nomeAutomacao")!!,
                        call.argument<String>("versaoAutomacao")!!,
                        call.argument<Boolean>("suportaTroco")!!,
                        call.argument<Boolean>("suportaDesconto")!!,
                        call.argument<Boolean>("suportaViasDiferenciadas")!!,
                        call.argument<Boolean>("suportaViaReduzida")!!,
                        call.argument<Boolean>("suportaAbatimentoSaldoVoucher")!!
                    )
                    result.success("Initialized")
                } catch (e: Exception) {
                    result.error("Init error", e.message, null)
                }
            }
            "configTema" -> {
                try {
                    ElginPay.configTema(
                        call.argument<String>("corFonte"),
                        call.argument<String>("corFonteTeclado"),
                        call.argument<String>("corFundoToolbar"),
                        call.argument<String>("corFundoTela"),
                        call.argument<String>("corTeclaLiberadaTeclado"),
                        call.argument<String>("corFundoTeclado"),
                        call.argument<String>("corTextoCaixaEdicao"),
                        call.argument<String>("corSeparadorMenu")
                    )
                    result.success("Config Tema Done")
                } catch (e: Exception) {
                    result.error("Config Tema error", e.message, null)
                }
            }
            "transactionCall" -> {
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

                val elginPAY = ElginPay(entradaTransacao, handler, context, activity)
                elginPAY.start()
            }
            "configurarTexto" -> {
                try {
                    DialogText.editString(
                        DialogGroup.valueOf(call.argument<String>("dialog")!!),
                        call.argument<String>("title"),
                        call.argument<String>("message"),
                        call.argument<String>("positiveButton"),
                        call.argument<String>("negativeButton")
                    )
                    result.success(true)
                } catch (e: Exception) {
                    result.success(false)
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