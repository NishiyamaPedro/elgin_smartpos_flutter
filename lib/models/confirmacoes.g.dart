// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'confirmacoes.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Confirmacoes _$ConfirmacoesFromJson(Map<String, dynamic> json) => Confirmacoes()
  ..statusTransacao =
      $enumDecodeNullable(_$StatusTransacaoEnumMap, json['statusTransacao'])
  ..identificadorConfirmacaoTransacao =
      json['identificadorConfirmacaoTransacao'] as String?;

Map<String, dynamic> _$ConfirmacoesToJson(Confirmacoes instance) =>
    <String, dynamic>{
      'statusTransacao': _$StatusTransacaoEnumMap[instance.statusTransacao],
      'identificadorConfirmacaoTransacao':
          instance.identificadorConfirmacaoTransacao,
    };

const _$StatusTransacaoEnumMap = {
  StatusTransacao.CONFIRMADO_AUTOMATICO: 'CONFIRMADO_AUTOMATICO',
  StatusTransacao.CONFIRMADO_MANUAL: 'CONFIRMADO_MANUAL',
  StatusTransacao.DESFEITO_ERRO_IMPRESSAO_AUTOMATICO:
      'DESFEITO_ERRO_IMPRESSAO_AUTOMATICO',
  StatusTransacao.DESFEITO_LIBERACAO_MERCADORIA:
      'DESFEITO_LIBERACAO_MERCADORIA',
  StatusTransacao.DESFEITO_MANUAL: 'DESFEITO_MANUAL',
  StatusTransacao.STATUS_TRANSACAO_NAO_DEFINIDO:
      'STATUS_TRANSACAO_NAO_DEFINIDO',
};
