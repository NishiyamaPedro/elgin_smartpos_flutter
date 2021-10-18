import 'package:json_annotation/json_annotation.dart';

import '../enums.dart';
import 'transacao_pendente_dados.dart';

part 'saida_transacao.g.dart';

@JsonSerializable()
class SaidaTransacao {
  SaidaTransacao();

  String? valorTroco;
  String? valorDesconto;
  String? valorTotal;
  String? codigoMoeda;
  String? saldoVoucher;
  String? valorDevido;
  String? documentoFiscal;
  String? nsuTransacao;
  String? nsuTerminal;
  String? codigoAutorizacao;
  String? identificadorTransacaoAutomacao;
  String? identificadorConfirmacaoTransacao;
  String? identificadorEstabelecimento;
  String? identificadorPontoCaptura;
  String? nomeEstabelecimento;
  Operacoes? operacao;
  DateTime? dataHoraTransacao;
  int? numeroParcelas;
  DateTime? dataPredatado;
  Financiamentos? tipoFinanciamento;
  String? nomeProvedor;
  String? uniqueID;
  Cartoes? tipoCartao;
  String? modoEntradaCartao;
  String? panMascarado;
  String? panMascaradoPadrao;
  String? modoVerificacaoSenha;
  String? nomeCartao;
  String? nomeCartaoPadrao;
  String? nomePortadorCartao;
  String? aidCartao;
  ModalidadesTransacao? modalidadeTransacao;
  bool? requerConfirmacao;
  int? resultadoTransacao;
  String? mensagemResultado;
  String? respostaRede;
  ViasImpressao? viasImprimir;
  List<dynamic>? comprovanteCompleto;
  List<dynamic>? comprovanteDiferenciadoLoja;
  List<dynamic>? comprovanteDiferenciadoPortador;
  List<dynamic>? comprovanteReduzidoPortador;
  bool? existeComprovanteGrafico;
  String? comprovanteGraficoLojista;
  String? comprovanteGraficoPortador;
  String? valorOriginal;
  DateTime? dataHoraTransacaoOriginal;
  String? nsuTransacaoOriginal;
  String? codigoAutorizacaoOriginal;
  String? nsuTerminalOriginal;
  bool? existeTransacaoPendente;
  TransacaoPendenteDados? dadosTransacaoPendente;

  factory SaidaTransacao.fromJson(Map<String, dynamic> json) =>
      _$SaidaTransacaoFromJson(json);
  Map<String, dynamic> toJson() => _$SaidaTransacaoToJson(this);
}
