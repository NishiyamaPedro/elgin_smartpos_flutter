import 'dart:async';
import 'dart:convert';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/services.dart';
import 'package:smartpos_flutter/models/confirmacoes.dart';
import 'package:smartpos_flutter/models/dados_automacao.dart';
import 'package:smartpos_flutter/models/entrada_transacao.dart';
import 'package:smartpos_flutter/models/saida_transacao.dart';
import 'package:smartpos_flutter/models/transacao_pendente_dados.dart';

export 'package:smartpos_flutter/enums.dart';

class ElginPAY {
  static const MethodChannel _channel = const MethodChannel('smartpos_flutter');

  static Future<void> init(DadosAutomacao dadosAutomacao) async {
    try {
      return _channel.invokeMethod('init', jsonEncode(dadosAutomacao));
    } on PlatformException catch (e) {
      throw '${e.message}';
    }
  }

  static Future<SaidaTransacao> iniciarTransacao(
      EntradaTransacao entradaTransacao) async {
    try {
      var saidaTransacao = await _channel.invokeMethod(
          'iniciarTransacao', jsonEncode(entradaTransacao));
      return SaidaTransacao.fromJson(jsonDecode(saidaTransacao));
    } on PlatformException catch (e) {
      throw '${e.message}';
    }
  }

  static Future<void> confirmaTransacao(Confirmacoes confirmacoes) async {
    try {
      return await _channel.invokeMethod(
          'confirmaTransacao', jsonEncode(confirmacoes));
    } on PlatformException catch (e) {
      throw '${e.message}';
    }
  }

  static Future<void> resolvePendencia(
      TransacaoPendenteDados transacaoPendenteDados,
      Confirmacoes confirmacoes) async {
    try {
      return await _channel.invokeMethod('resolvePendencia',
          [jsonEncode(transacaoPendenteDados), jsonEncode(confirmacoes)]);
    } on PlatformException catch (e) {
      throw '${e.message}';
    }
  }

  static Future<void> imprimirNFCe(
      {required String xml,
      required int indexCSC,
      required String csc,
      int viaCliente = 0,
      int param = 4}) async {
    try {
      return await _channel.invokeMethod('imprimirNFCe', <String, dynamic>{
        'xml': xml,
        'indexcsc': indexCSC,
        'csc': csc,
        'param': param,
        'via': viaCliente
      });
    } on PlatformException catch (e) {
      throw '${e.message}';
    }
  }

  static Future<bool> imprimirStrings(List<String> strings) async {
    try {
      return await _channel.invokeMethod('imprimir', <String, dynamic>{
        'strings': strings,
      });
    } on PlatformException catch (e) {
      throw '${e.message}';
    }
  }

  static Future<bool> imprimirImagem(String bitmap) async {
    try {
      return await _channel.invokeMethod('imprimirImagem', bitmap);
    } on PlatformException catch (e) {
      throw '${e.message}';
    }
  }

  static Future<bool> isElginPOS() async {
    if (kIsWeb || Platform.isIOS || Platform.isWindows) return false;

    try {
      return await _channel.invokeMethod('isElginPOS');
    } on PlatformException catch (e) {
      throw '${e.message}';
    }
  }
}
