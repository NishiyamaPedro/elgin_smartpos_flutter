import 'package:json_annotation/json_annotation.dart';
import 'package:smartpos_flutter/enums.dart';

part 'confirmacoes.g.dart';

@JsonSerializable()
class Confirmacoes {
  Confirmacoes({this.identificadorConfirmacaoTransacao, this.statusTransacao});

  StatusTransacao? statusTransacao;
  String? identificadorConfirmacaoTransacao;

  factory Confirmacoes.fromJson(Map<String, dynamic> json) =>
      _$ConfirmacoesFromJson(json);
  Map<String, dynamic> toJson() => _$ConfirmacoesToJson(this);
}
