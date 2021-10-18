
# Elgin SmartPOS

Plugin Elgin SmartPOS para flutter.
**O plugin ainda esta em desenvolvimento e pode conter erros. Caso encontre um erro abra uma issue.**

## Funções ainda não implementadas

- Scanner.

## Exemplo
```dart
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
```

## Instalar

- Rode o comando para instalar.

```yaml
flutter pub add smartpos_flutter
```


- Adicionar as bibliotecas da Elgin no build.gradle dentro da pasta 'Android/app/', como descrito no manual de integracao da Elgin.

### Links
-[Repositorio Elgin SmartPOS.](https://github.com/ElginDeveloperCommunity/SmartPOS/tree/master)
