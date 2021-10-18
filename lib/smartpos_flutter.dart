import 'dart:async';
import 'dart:convert';

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

  static Future<bool> imprimirStrings(List<String> strings) async {
    try {
      return await _channel.invokeMethod('imprimir', <String, dynamic>{
        'strings': strings,
      });
    } on PlatformException catch (e) {
      throw '${e.message}';
    }
  }
}
