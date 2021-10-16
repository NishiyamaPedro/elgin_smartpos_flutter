// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'entrada_transacao.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EntradaTransacao _$EntradaTransacaoFromJson(Map<String, dynamic> json) =>
    EntradaTransacao(
      operacao: $enumDecode(_$OperacoesEnumMap, json['operacao']),
      identificadorTransacaoAutomacao:
          json['identificadorTransacaoAutomacao'] as String,
      codigoMoeda: json['codigoMoeda'] as String? ?? "986",
      taxaEmbarque: json['taxaEmbarque'] as String?,
      taxaServico: json['taxaServico'] as String?,
      valorTotal: json['valorTotal'] as String?,
      nomeProvedor: json['nomeProvedor'] as String?,
      documentoFiscal: json['documentoFiscal'] as String?,
      estabelecimentoCNPJouCPF: json['estabelecimentoCNPJouCPF'] as String?,
      numeroFatura: json['numeroFatura'] as String?,
      numeroTelefone: json['numeroTelefone'] as String?,
      dadosAdicionaisAutomacao1: json['dadosAdicionaisAutomacao1'] as String?,
      dadosAdicionaisAutomacao2: json['dadosAdicionaisAutomacao2'] as String?,
      dadosAdicionaisAutomacao3: json['dadosAdicionaisAutomacao3'] as String?,
      dadosAdicionaisAutomacao4: json['dadosAdicionaisAutomacao4'] as String?,
      codigoAutorizacaoOriginal: json['codigoAutorizacaoOriginal'] as String?,
      nsuTransacaoOriginal: json['nsuTransacaoOriginal'] as String?,
      numeroParcelas: json['numeroParcelas'] as int? ?? 0,
      tipoCartao: $enumDecodeNullable(_$CartoesEnumMap, json['tipoCartao']),
      tipoFinanciamento: $enumDecodeNullable(
          _$FinanciamentosEnumMap, json['tipoFinanciamento']),
      modalidadePagamento: $enumDecodeNullable(
          _$ModalidadesPagamentoEnumMap, json['modalidadePagamento']),
      dataPredatado: json['dataPredatado'] == null
          ? null
          : DateTime.parse(json['dataPredatado'] as String),
      dataHoraTransacaoOriginal: json['dataHoraTransacaoOriginal'] == null
          ? null
          : DateTime.parse(json['dataHoraTransacaoOriginal'] as String),
    );

Map<String, dynamic> _$EntradaTransacaoToJson(EntradaTransacao instance) =>
    <String, dynamic>{
      'operacao': _$OperacoesEnumMap[instance.operacao],
      'identificadorTransacaoAutomacao':
          instance.identificadorTransacaoAutomacao,
      'codigoMoeda': instance.codigoMoeda,
      'numeroParcelas': instance.numeroParcelas,
      'taxaEmbarque': instance.taxaEmbarque,
      'taxaServico': instance.taxaServico,
      'valorTotal': instance.valorTotal,
      'nomeProvedor': instance.nomeProvedor,
      'documentoFiscal': instance.documentoFiscal,
      'estabelecimentoCNPJouCPF': instance.estabelecimentoCNPJouCPF,
      'numeroFatura': instance.numeroFatura,
      'numeroTelefone': instance.numeroTelefone,
      'dadosAdicionaisAutomacao1': instance.dadosAdicionaisAutomacao1,
      'dadosAdicionaisAutomacao2': instance.dadosAdicionaisAutomacao2,
      'dadosAdicionaisAutomacao3': instance.dadosAdicionaisAutomacao3,
      'dadosAdicionaisAutomacao4': instance.dadosAdicionaisAutomacao4,
      'codigoAutorizacaoOriginal': instance.codigoAutorizacaoOriginal,
      'nsuTransacaoOriginal': instance.nsuTransacaoOriginal,
      'tipoCartao': _$CartoesEnumMap[instance.tipoCartao],
      'tipoFinanciamento': _$FinanciamentosEnumMap[instance.tipoFinanciamento],
      'modalidadePagamento':
          _$ModalidadesPagamentoEnumMap[instance.modalidadePagamento],
      'dataPredatado': instance.dataPredatado?.toIso8601String(),
      'dataHoraTransacaoOriginal':
          instance.dataHoraTransacaoOriginal?.toIso8601String(),
    };

const _$OperacoesEnumMap = {
  Operacoes.ADMINISTRATIVA: 'ADMINISTRATIVA',
  Operacoes.CANCELAMENTO: 'CANCELAMENTO',
  Operacoes.CANCELAMENTO_PAGAMENTOCONTA: 'CANCELAMENTO_PAGAMENTOCONTA',
  Operacoes.CANCELAMENTO_PREAUTORIZACAO: 'CANCELAMENTO_PREAUTORIZACAO',
  Operacoes.CONFIGURACAO: 'CONFIGURACAO',
  Operacoes.CONSULTA_CHEQUE: 'CONSULTA_CHEQUE',
  Operacoes.CONSULTA_SALDO: 'CONSULTA_SALDO',
  Operacoes.DOACAO: 'DOACAO',
  Operacoes.EXIBE_PDC: 'EXIBE_PDC',
  Operacoes.FECHAMENTO: 'FECHAMENTO',
  Operacoes.GARANTIA_CHEQUE: 'GARANTIA_CHEQUE',
  Operacoes.INSTALACAO: 'INSTALACAO',
  Operacoes.MANUTENCAO: 'MANUTENCAO',
  Operacoes.OPERACAO_DESCONHECIDA: 'OPERACAO_DESCONHECIDA',
  Operacoes.PAGAMENTO_CONTA: 'PAGAMENTO_CONTA',
  Operacoes.PREAUTORIZACAO: 'PREAUTORIZACAO',
  Operacoes.RECARGA_CELULAR: 'RECARGA_CELULAR',
  Operacoes.REIMPRESSAO: 'REIMPRESSAO',
  Operacoes.RELATORIO_DETALHADO: 'RELATORIO_DETALHADO',
  Operacoes.RELATORIO_RESUMIDO: 'RELATORIO_RESUMIDO',
  Operacoes.RELATORIO_SINTETICO: 'RELATORIO_SINTETICO',
  Operacoes.SAQUE: 'SAQUE',
  Operacoes.TESTE_COMUNICACAO: 'TESTE_COMUNICACAO',
  Operacoes.VENDA: 'VENDA',
  Operacoes.VERSAO: 'VERSAO',
};

const _$CartoesEnumMap = {
  Cartoes.CARTAO_CREDITO: 'CARTAO_CREDITO',
  Cartoes.CARTAO_DEBITO: 'CARTAO_DEBITO',
  Cartoes.CARTAO_DESCONHECIDO: 'CARTAO_DESCONHECIDO',
  Cartoes.CARTAO_FROTA: 'CARTAO_FROTA',
  Cartoes.CARTAO_PRIVATELABEL: 'CARTAO_PRIVATELABEL',
  Cartoes.CARTAO_VOUCHER: 'CARTAO_VOUCHER',
};

const _$FinanciamentosEnumMap = {
  Financiamentos.A_VISTA: 'A_VISTA',
  Financiamentos.CREDITO_EMISSOR: 'CREDITO_EMISSOR',
  Financiamentos.FINANCIAMENTO_NAO_DEFINIDO: 'FINANCIAMENTO_NAO_DEFINIDO',
  Financiamentos.PARCELADO_EMISSOR: 'PARCELADO_EMISSOR',
  Financiamentos.PARCELADO_ESTABELECIMENTO: 'PARCELADO_ESTABELECIMENTO',
  Financiamentos.PRE_DATADO: 'PRE_DATADO',
};

const _$ModalidadesPagamentoEnumMap = {
  ModalidadesPagamento.CARTEIRA_VIRTUAL: 'CARTEIRA_VIRTUAL',
  ModalidadesPagamento.PAGAMENTO_CARTAO: 'PAGAMENTO_CARTAO',
  ModalidadesPagamento.PAGAMENTO_CHEQUE: 'PAGAMENTO_CHEQUE',
  ModalidadesPagamento.PAGAMENTO_DINHEIRO: 'PAGAMENTO_DINHEIRO',
};
