// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transacao_pendente_dados.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransacaoPendenteDados _$TransacaoPendenteDadosFromJson(
        Map<String, dynamic> json) =>
    TransacaoPendenteDados()
      ..nomeProvedor = json['nomeProvedor'] as String?
      ..identificadorEstabelecimento =
          json['identificadorEstabelecimento'] as String?
      ..nsuLocal = json['nsuLocal'] as String?
      ..nsuTransacao = json['nsuTransacao'] as String?
      ..nsuHost = json['nsuHost'] as String?;

Map<String, dynamic> _$TransacaoPendenteDadosToJson(
        TransacaoPendenteDados instance) =>
    <String, dynamic>{
      'nomeProvedor': instance.nomeProvedor,
      'identificadorEstabelecimento': instance.identificadorEstabelecimento,
      'nsuLocal': instance.nsuLocal,
      'nsuTransacao': instance.nsuTransacao,
      'nsuHost': instance.nsuHost,
    };
