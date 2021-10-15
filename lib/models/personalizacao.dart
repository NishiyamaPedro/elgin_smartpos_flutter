import 'package:json_annotation/json_annotation.dart';

part 'personalizacao.g.dart';

@JsonSerializable()
class Personalizacao {
  Personalizacao({
    this.corFundoTela,
    this.corFundoToolbar,
    this.corFundoTeclado,
    this.corFonte,
    this.corFonteTeclado,
    this.corFundoCaixaEdicao,
    this.corSeparadorMenu,
    this.corTeclaLiberadaTeclado,
    this.corTeclaPressionadaTeclado,
    this.corTextoCaixaEdicao,
    this.fonte,
    this.iconeToolbar,
  });
  String? corFundoTela;
  String? corFundoToolbar;
  String? corFundoTeclado;
  String? corFonte;
  String? corFundoCaixaEdicao;
  String? corTextoCaixaEdicao;
  String? corTeclaLiberadaTeclado;
  String? corTeclaPressionadaTeclado;
  String? corFonteTeclado;
  String? corSeparadorMenu;
  String? iconeToolbar;
  String? fonte;

  factory Personalizacao.fromJson(Map<String, dynamic> json) =>
      _$PersonalizacaoFromJson(json);
  Map<String, dynamic> toJson() => _$PersonalizacaoToJson(this);
}
