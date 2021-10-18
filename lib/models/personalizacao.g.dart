// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'personalizacao.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Personalizacao _$PersonalizacaoFromJson(Map<String, dynamic> json) =>
    Personalizacao(
      corFundoTela: json['corFundoTela'] as String?,
      corFundoToolbar: json['corFundoToolbar'] as String?,
      corFundoTeclado: json['corFundoTeclado'] as String?,
      corFonte: json['corFonte'] as String? ?? '#000000',
      corFonteTeclado: json['corFonteTeclado'] as String?,
      corFundoCaixaEdicao: json['corFundoCaixaEdicao'] as String?,
      corSeparadorMenu: json['corSeparadorMenu'] as String?,
      corTeclaLiberadaTeclado: json['corTeclaLiberadaTeclado'] as String?,
      corTeclaPressionadaTeclado: json['corTeclaPressionadaTeclado'] as String?,
      corTextoCaixaEdicao: json['corTextoCaixaEdicao'] as String?,
      fonte: json['fonte'] as String?,
      iconeToolbar: json['iconeToolbar'] as String?,
    );

Map<String, dynamic> _$PersonalizacaoToJson(Personalizacao instance) =>
    <String, dynamic>{
      'corFundoTela': instance.corFundoTela,
      'corFundoToolbar': instance.corFundoToolbar,
      'corFundoTeclado': instance.corFundoTeclado,
      'corFonte': instance.corFonte,
      'corFundoCaixaEdicao': instance.corFundoCaixaEdicao,
      'corTextoCaixaEdicao': instance.corTextoCaixaEdicao,
      'corTeclaLiberadaTeclado': instance.corTeclaLiberadaTeclado,
      'corTeclaPressionadaTeclado': instance.corTeclaPressionadaTeclado,
      'corFonteTeclado': instance.corFonteTeclado,
      'corSeparadorMenu': instance.corSeparadorMenu,
      'iconeToolbar': instance.iconeToolbar,
      'fonte': instance.fonte,
    };
