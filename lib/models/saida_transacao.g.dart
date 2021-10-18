// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'saida_transacao.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SaidaTransacao _$SaidaTransacaoFromJson(Map<String, dynamic> json) =>
    SaidaTransacao()
      ..valorTroco = json['valorTroco'] as String?
      ..valorDesconto = json['valorDesconto'] as String?
      ..valorTotal = json['valorTotal'] as String?
      ..codigoMoeda = json['codigoMoeda'] as String?
      ..saldoVoucher = json['saldoVoucher'] as String?
      ..valorDevido = json['valorDevido'] as String?
      ..documentoFiscal = json['documentoFiscal'] as String?
      ..nsuTransacao = json['nsuTransacao'] as String?
      ..nsuTerminal = json['nsuTerminal'] as String?
      ..codigoAutorizacao = json['codigoAutorizacao'] as String?
      ..identificadorTransacaoAutomacao =
          json['identificadorTransacaoAutomacao'] as String?
      ..identificadorConfirmacaoTransacao =
          json['identificadorConfirmacaoTransacao'] as String?
      ..identificadorEstabelecimento =
          json['identificadorEstabelecimento'] as String?
      ..identificadorPontoCaptura = json['identificadorPontoCaptura'] as String?
      ..nomeEstabelecimento = json['nomeEstabelecimento'] as String?
      ..operacao = $enumDecodeNullable(_$OperacoesEnumMap, json['operacao'])
      ..dataHoraTransacao = json['dataHoraTransacao'] == null
          ? null
          : DateTime.parse(json['dataHoraTransacao'] as String)
      ..numeroParcelas = json['numeroParcelas'] as int?
      ..dataPredatado = json['dataPredatado'] == null
          ? null
          : DateTime.parse(json['dataPredatado'] as String)
      ..tipoFinanciamento = $enumDecodeNullable(
          _$FinanciamentosEnumMap, json['tipoFinanciamento'])
      ..nomeProvedor = json['nomeProvedor'] as String?
      ..uniqueID = json['uniqueID'] as String?
      ..tipoCartao = $enumDecodeNullable(_$CartoesEnumMap, json['tipoCartao'])
      ..modoEntradaCartao = json['modoEntradaCartao'] as String?
      ..panMascarado = json['panMascarado'] as String?
      ..panMascaradoPadrao = json['panMascaradoPadrao'] as String?
      ..modoVerificacaoSenha = json['modoVerificacaoSenha'] as String?
      ..nomeCartao = json['nomeCartao'] as String?
      ..nomeCartaoPadrao = json['nomeCartaoPadrao'] as String?
      ..nomePortadorCartao = json['nomePortadorCartao'] as String?
      ..aidCartao = json['aidCartao'] as String?
      ..modalidadeTransacao = $enumDecodeNullable(
          _$ModalidadesTransacaoEnumMap, json['modalidadeTransacao'])
      ..requerConfirmacao = json['requerConfirmacao'] as bool?
      ..resultadoTransacao = json['resultadoTransacao'] as int?
      ..mensagemResultado = json['mensagemResultado'] as String?
      ..respostaRede = json['respostaRede'] as String?
      ..viasImprimir =
          $enumDecodeNullable(_$ViasImpressaoEnumMap, json['viasImprimir'])
      ..comprovanteCompleto = json['comprovanteCompleto'] as List<dynamic>?
      ..comprovanteDiferenciadoLoja =
          json['comprovanteDiferenciadoLoja'] as List<dynamic>?
      ..comprovanteDiferenciadoPortador =
          json['comprovanteDiferenciadoPortador'] as List<dynamic>?
      ..comprovanteReduzidoPortador =
          json['comprovanteReduzidoPortador'] as List<dynamic>?
      ..existeComprovanteGrafico = json['existeComprovanteGrafico'] as bool?
      ..comprovanteGraficoLojista = json['comprovanteGraficoLojista'] as String?
      ..comprovanteGraficoPortador =
          json['comprovanteGraficoPortador'] as String?
      ..valorOriginal = json['valorOriginal'] as String?
      ..dataHoraTransacaoOriginal = json['dataHoraTransacaoOriginal'] == null
          ? null
          : DateTime.parse(json['dataHoraTransacaoOriginal'] as String)
      ..nsuTransacaoOriginal = json['nsuTransacaoOriginal'] as String?
      ..codigoAutorizacaoOriginal = json['codigoAutorizacaoOriginal'] as String?
      ..nsuTerminalOriginal = json['nsuTerminalOriginal'] as String?
      ..existeTransacaoPendente = json['existeTransacaoPendente'] as bool?
      ..dadosTransacaoPendente = json['dadosTransacaoPendente'] == null
          ? null
          : TransacaoPendenteDados.fromJson(
              json['dadosTransacaoPendente'] as Map<String, dynamic>);

Map<String, dynamic> _$SaidaTransacaoToJson(SaidaTransacao instance) =>
    <String, dynamic>{
      'valorTroco': instance.valorTroco,
      'valorDesconto': instance.valorDesconto,
      'valorTotal': instance.valorTotal,
      'codigoMoeda': instance.codigoMoeda,
      'saldoVoucher': instance.saldoVoucher,
      'valorDevido': instance.valorDevido,
      'documentoFiscal': instance.documentoFiscal,
      'nsuTransacao': instance.nsuTransacao,
      'nsuTerminal': instance.nsuTerminal,
      'codigoAutorizacao': instance.codigoAutorizacao,
      'identificadorTransacaoAutomacao':
          instance.identificadorTransacaoAutomacao,
      'identificadorConfirmacaoTransacao':
          instance.identificadorConfirmacaoTransacao,
      'identificadorEstabelecimento': instance.identificadorEstabelecimento,
      'identificadorPontoCaptura': instance.identificadorPontoCaptura,
      'nomeEstabelecimento': instance.nomeEstabelecimento,
      'operacao': _$OperacoesEnumMap[instance.operacao],
      'dataHoraTransacao': instance.dataHoraTransacao?.toIso8601String(),
      'numeroParcelas': instance.numeroParcelas,
      'dataPredatado': instance.dataPredatado?.toIso8601String(),
      'tipoFinanciamento': _$FinanciamentosEnumMap[instance.tipoFinanciamento],
      'nomeProvedor': instance.nomeProvedor,
      'uniqueID': instance.uniqueID,
      'tipoCartao': _$CartoesEnumMap[instance.tipoCartao],
      'modoEntradaCartao': instance.modoEntradaCartao,
      'panMascarado': instance.panMascarado,
      'panMascaradoPadrao': instance.panMascaradoPadrao,
      'modoVerificacaoSenha': instance.modoVerificacaoSenha,
      'nomeCartao': instance.nomeCartao,
      'nomeCartaoPadrao': instance.nomeCartaoPadrao,
      'nomePortadorCartao': instance.nomePortadorCartao,
      'aidCartao': instance.aidCartao,
      'modalidadeTransacao':
          _$ModalidadesTransacaoEnumMap[instance.modalidadeTransacao],
      'requerConfirmacao': instance.requerConfirmacao,
      'resultadoTransacao': instance.resultadoTransacao,
      'mensagemResultado': instance.mensagemResultado,
      'respostaRede': instance.respostaRede,
      'viasImprimir': _$ViasImpressaoEnumMap[instance.viasImprimir],
      'comprovanteCompleto': instance.comprovanteCompleto,
      'comprovanteDiferenciadoLoja': instance.comprovanteDiferenciadoLoja,
      'comprovanteDiferenciadoPortador':
          instance.comprovanteDiferenciadoPortador,
      'comprovanteReduzidoPortador': instance.comprovanteReduzidoPortador,
      'existeComprovanteGrafico': instance.existeComprovanteGrafico,
      'comprovanteGraficoLojista': instance.comprovanteGraficoLojista,
      'comprovanteGraficoPortador': instance.comprovanteGraficoPortador,
      'valorOriginal': instance.valorOriginal,
      'dataHoraTransacaoOriginal':
          instance.dataHoraTransacaoOriginal?.toIso8601String(),
      'nsuTransacaoOriginal': instance.nsuTransacaoOriginal,
      'codigoAutorizacaoOriginal': instance.codigoAutorizacaoOriginal,
      'nsuTerminalOriginal': instance.nsuTerminalOriginal,
      'existeTransacaoPendente': instance.existeTransacaoPendente,
      'dadosTransacaoPendente': instance.dadosTransacaoPendente,
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

const _$FinanciamentosEnumMap = {
  Financiamentos.A_VISTA: 'A_VISTA',
  Financiamentos.CREDITO_EMISSOR: 'CREDITO_EMISSOR',
  Financiamentos.FINANCIAMENTO_NAO_DEFINIDO: 'FINANCIAMENTO_NAO_DEFINIDO',
  Financiamentos.PARCELADO_EMISSOR: 'PARCELADO_EMISSOR',
  Financiamentos.PARCELADO_ESTABELECIMENTO: 'PARCELADO_ESTABELECIMENTO',
  Financiamentos.PRE_DATADO: 'PRE_DATADO',
};

const _$CartoesEnumMap = {
  Cartoes.CARTAO_CREDITO: 'CARTAO_CREDITO',
  Cartoes.CARTAO_DEBITO: 'CARTAO_DEBITO',
  Cartoes.CARTAO_DESCONHECIDO: 'CARTAO_DESCONHECIDO',
  Cartoes.CARTAO_FROTA: 'CARTAO_FROTA',
  Cartoes.CARTAO_PRIVATELABEL: 'CARTAO_PRIVATELABEL',
  Cartoes.CARTAO_VOUCHER: 'CARTAO_VOUCHER',
};

const _$ModalidadesTransacaoEnumMap = {
  ModalidadesTransacao.ON: 'ON',
  ModalidadesTransacao.OFF: 'OFF',
};

const _$ViasImpressaoEnumMap = {
  ViasImpressao.VIA_CLIENTE: 'VIA_CLIENTE',
  ViasImpressao.VIA_CLIENTE_E_ESTABELECIMENTO: 'VIA_CLIENTE_E_ESTABELECIMENTO',
  ViasImpressao.VIA_ESTABELECIMENTO: 'VIA_ESTABELECIMENTO',
  ViasImpressao.VIA_NENHUMA: 'VIA_NENHUMA',
};
