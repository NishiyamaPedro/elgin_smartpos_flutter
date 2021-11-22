import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:smartpos_flutter/models/confirmacoes.dart';
import 'package:smartpos_flutter/models/dados_automacao.dart';
import 'package:smartpos_flutter/models/entrada_transacao.dart';
import 'package:smartpos_flutter/models/personalizacao.dart';
import 'package:smartpos_flutter/models/transacao_pendente_dados.dart';
import 'package:smartpos_flutter/smartpos_flutter.dart';
import 'package:smartpos_flutter/utils.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    initElgin();
  }

  void initElgin() async {
    await ElginPAY.init(
      DadosAutomacao(
        empresaAutomacao: "Empresa",
        nomeAutomacao: "Empresa",
        versaoAutomacao: "1",
        mPersonalizacaoCliente: Personalizacao(
          corFonte: Colors.blue.toHex(),
          corFundoTela: Colors.yellow.toHex(),
        ),
      ),
    );
  }

  void administrativa() async {
    var saidaTransacao = await ElginPAY.iniciarTransacao(
      EntradaTransacao(
        operacao: Operacoes.VENDA,
        identificadorTransacaoAutomacao: new Random().nextInt(9999).toString(),
      ),
    );

    await ElginPAY.resolvePendencia(
      saidaTransacao.dadosTransacaoPendente!,
     Confirmacoes(statusTransacao: StatusTransacao.CONFIRMADO_AUTOMATICO),
    );
  }

  void imprimir() {
    ElginPAY.imprimirStrings(<String>[
      'Teste Impressao',
      'Linha 2',
      'Linha 3',
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('SmartPOS Flutter DEMO'),
        ),
        body: Center(
          child: Column(children: [
            ElevatedButton(
              onPressed: administrativa,
              child: Text("Transação"),
            ),
            ElevatedButton(
              onPressed: imprimir,
              child: Text("Teste Impressao"),
            ),
          ]),
        ),
      ),
    );
  }
}
