import 'dart:async';
import 'dart:math';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'package:smartpos_flutter/constants.dart';
import 'package:smartpos_flutter/utils.dart';

export 'package:smartpos_flutter/constants.dart';

class ElginPAY {
  static const MethodChannel _channel = const MethodChannel('smartpos_flutter');

  static Future<void> init({
    required String empresaAutomacao,
    required String nomeAutomacao,
    required String versaoAutomacao,
    bool suportaTroco = false,
    bool suportaDesconto = false,
    bool suportaViasDiferenciadas = false,
    bool suportaViaReduzida = false,
    bool suportaAbatimentoSaldoVoucher = false,
  }) async {
    try {
      return _channel.invokeMethod('init', <String, dynamic>{
        'empresaAutomacao': empresaAutomacao,
        'nomeAutomacao': nomeAutomacao,
        'versaoAutomacao': versaoAutomacao,
        'suportaTroco': suportaTroco,
        'suportaDesconto': suportaDesconto,
        'suportaViasDiferenciadas': suportaViasDiferenciadas,
        'suportaViaReduzida': suportaViaReduzida,
        'suportaAbatimentoSaldoVoucher': suportaAbatimentoSaldoVoucher,
      });
    } on PlatformException catch (e) {
      throw '${e.message}';
    }
  }

  static Future<void> configTema({
    Color? corFonte,
    Color? corFonteTeclado,
    Color? corFundoToolbar,
    Color? corFundoTela,
    Color? corTeclaLiberadaTeclado,
    Color? corFundoTeclado,
    Color? corTextoCaixaEdicao,
    Color? corSeparadorMenu,
  }) async {
    try {
      return _channel.invokeMethod('configTema', <String, dynamic>{
        'corFonte': corFonte?.toHex() ?? '',
        'corFonteTeclado': corFonteTeclado?.toHex() ?? '',
        'corFundoToolbar': corFundoToolbar?.toHex() ?? '',
        'corFundoTela': corFundoTela?.toHex() ?? '',
        'corTeclaLiberadaTeclado': corTeclaLiberadaTeclado?.toHex() ?? '',
        'corFundoTeclado': corFundoTeclado?.toHex() ?? '',
        'corTextoCaixaEdicao': corTextoCaixaEdicao?.toHex() ?? '',
        'corSeparadorMenu': corSeparadorMenu?.toHex() ?? '',
      });
    } on PlatformException catch (e) {
      throw '${e.message}';
    }
  }

  static Future<String> transactionCall({
    required Operacoes operacao,
    int? idTransaction,
  }) async {
    try {
      return await _channel.invokeMethod('transactionCall', <String, dynamic>{
        'operacao': operacao.toShortString(),
        'idTransaction': (idTransaction ?? Random().nextInt(999999)).toString(),
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

  static Future<bool> configurarTexto({
    required DialogText dialogText,
    String? title,
    String? message,
    String? positiveButton,
    String? negativeButton,
  }) async {
    try {
      return await _channel.invokeMethod('configurarTexto', <String, dynamic>{
        'dialog': dialogText.toShortString(),
        'title': title,
        'message': message,
        'positiveButton': positiveButton,
        'negativeButton': negativeButton,
      });
    } on PlatformException catch (e) {
      throw '${e.message}';
    }
  }
}
