import 'package:json_annotation/json_annotation.dart';

part 'transacao_pendente_dados.g.dart';

@JsonSerializable()
class TransacaoPendenteDados {
  TransacaoPendenteDados({
    this.nomeProvedor,
    this.identificadorEstabelecimento,
    this.nsuLocal,
    this.nsuTransacao,
    this.nsuHost,
  });

  String? nomeProvedor;
  String? identificadorEstabelecimento;
  String? nsuLocal;
  String? nsuTransacao;
  String? nsuHost;

  factory TransacaoPendenteDados.fromJson(Map<String, dynamic> json) =>
      _$TransacaoPendenteDadosFromJson(json);
  Map<String, dynamic> toJson() => _$TransacaoPendenteDadosToJson(this);
}
