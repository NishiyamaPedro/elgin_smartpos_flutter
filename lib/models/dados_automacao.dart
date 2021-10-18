import 'package:json_annotation/json_annotation.dart';
import 'personalizacao.dart';

part 'dados_automacao.g.dart';

@JsonSerializable()
class DadosAutomacao {
  DadosAutomacao({
    required this.nomeAutomacao,
    required this.versaoAutomacao,
    required this.empresaAutomacao,
    this.suportaAbatimentoSaldoVoucher,
    this.suportaDesconto,
    this.suportaTroco,
    this.suportaViaReduzida,
    this.suportaViasDiferenciadas,
    this.mPersonalizacaoCliente = const Personalizacao(),
  });

  String nomeAutomacao;
  String versaoAutomacao;
  String empresaAutomacao;
  bool? suportaTroco;
  bool? suportaDesconto;
  bool? suportaViasDiferenciadas;
  bool? suportaViaReduzida;
  bool? suportaAbatimentoSaldoVoucher;
  Personalizacao mPersonalizacaoCliente;

  factory DadosAutomacao.fromJson(Map<String, dynamic> json) =>
      _$DadosAutomacaoFromJson(json);
  Map<String, dynamic> toJson() => _$DadosAutomacaoToJson(this);
}
