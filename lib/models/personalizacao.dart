import 'package:json_annotation/json_annotation.dart';

part 'personalizacao.g.dart';

@JsonSerializable()
class Personalizacao {
  const Personalizacao({
    this.corFundoTela,
    this.corFundoToolbar,
    this.corFundoTeclado,
    this.corFonte = '#000000',
    this.corFonteTeclado,
    this.corFundoCaixaEdicao,
    this.corSeparadorMenu,
    this.corTeclaLiberadaTeclado,
    this.corTeclaPressionadaTeclado,
    this.corTextoCaixaEdicao,
    this.fonte,
    this.iconeToolbar,
  });
  final String? corFundoTela;
  final String? corFundoToolbar;
  final String? corFundoTeclado;
  final String? corFonte;
  final String? corFundoCaixaEdicao;
  final String? corTextoCaixaEdicao;
  final String? corTeclaLiberadaTeclado;
  final String? corTeclaPressionadaTeclado;
  final String? corFonteTeclado;
  final String? corSeparadorMenu;
  final String? iconeToolbar;
  final String? fonte;

  factory Personalizacao.fromJson(Map<String, dynamic> json) =>
      _$PersonalizacaoFromJson(json);
  Map<String, dynamic> toJson() => _$PersonalizacaoToJson(this);
}
