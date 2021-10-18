// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dados_automacao.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DadosAutomacao _$DadosAutomacaoFromJson(Map<String, dynamic> json) =>
    DadosAutomacao(
      nomeAutomacao: json['nomeAutomacao'] as String,
      versaoAutomacao: json['versaoAutomacao'] as String,
      empresaAutomacao: json['empresaAutomacao'] as String,
      suportaAbatimentoSaldoVoucher:
          json['suportaAbatimentoSaldoVoucher'] as bool?,
      suportaDesconto: json['suportaDesconto'] as bool?,
      suportaTroco: json['suportaTroco'] as bool?,
      suportaViaReduzida: json['suportaViaReduzida'] as bool?,
      suportaViasDiferenciadas: json['suportaViasDiferenciadas'] as bool?,
      mPersonalizacaoCliente: json['mPersonalizacaoCliente'] == null
          ? const Personalizacao()
          : Personalizacao.fromJson(
              json['mPersonalizacaoCliente'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DadosAutomacaoToJson(DadosAutomacao instance) =>
    <String, dynamic>{
      'nomeAutomacao': instance.nomeAutomacao,
      'versaoAutomacao': instance.versaoAutomacao,
      'empresaAutomacao': instance.empresaAutomacao,
      'suportaTroco': instance.suportaTroco,
      'suportaDesconto': instance.suportaDesconto,
      'suportaViasDiferenciadas': instance.suportaViasDiferenciadas,
      'suportaViaReduzida': instance.suportaViaReduzida,
      'suportaAbatimentoSaldoVoucher': instance.suportaAbatimentoSaldoVoucher,
      'mPersonalizacaoCliente': instance.mPersonalizacaoCliente,
    };
