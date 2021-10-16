import 'package:json_annotation/json_annotation.dart';
import 'package:smartpos_flutter/enums.dart';

part 'entrada_transacao.g.dart';

@JsonSerializable()
class EntradaTransacao {
  EntradaTransacao(
      {required this.operacao,
      required this.identificadorTransacaoAutomacao,
      this.codigoMoeda = "986",
      this.taxaEmbarque,
      this.taxaServico,
      this.valorTotal,
      this.nomeProvedor,
      this.documentoFiscal,
      this.estabelecimentoCNPJouCPF,
      this.numeroFatura,
      this.numeroTelefone,
      this.dadosAdicionaisAutomacao1,
      this.dadosAdicionaisAutomacao2,
      this.dadosAdicionaisAutomacao3,
      this.dadosAdicionaisAutomacao4,
      this.codigoAutorizacaoOriginal,
      this.nsuTransacaoOriginal,
      this.numeroParcelas = 0,
      this.tipoCartao,
      this.tipoFinanciamento,
      this.modalidadePagamento,
      this.dataPredatado,
      this.dataHoraTransacaoOriginal});

  Operacoes operacao;
  String identificadorTransacaoAutomacao;
  String codigoMoeda;
  int numeroParcelas;
  String? taxaEmbarque;
  String? taxaServico;
  String? valorTotal;
  String? nomeProvedor;
  String? documentoFiscal;
  String? estabelecimentoCNPJouCPF;
  String? numeroFatura;
  String? numeroTelefone;
  String? dadosAdicionaisAutomacao1;
  String? dadosAdicionaisAutomacao2;
  String? dadosAdicionaisAutomacao3;
  String? dadosAdicionaisAutomacao4;
  String? codigoAutorizacaoOriginal;
  String? nsuTransacaoOriginal;
  Cartoes? tipoCartao;
  Financiamentos? tipoFinanciamento;
  ModalidadesPagamento? modalidadePagamento;
  DateTime? dataPredatado;
  DateTime? dataHoraTransacaoOriginal;

  factory EntradaTransacao.fromJson(Map<String, dynamic> json) =>
      _$EntradaTransacaoFromJson(json);
  Map<String, dynamic> toJson() => _$EntradaTransacaoToJson(this);
}
