
# Elgin SmartPOS

Plugin Elgin SmartPOS para flutter.
**O plugin ainda esta em desenvolvimento e pode conter erros. Caso encontre um erro abra uma issue.**

## Exemplo
```dart
void initElgin() {
  // (OPCIONAL) Caso deseje configurar o tema, configurar antes de chamar o init.
  ElginPAY.configTema(
    corFonte: Colors.black,
	corFundoTela: Colors.white,
  );

  // Inicializa a biblioteca.
  ElginPAY.init(
    empresaAutomacao: "Empresa",
	nomeAutomacao: "Empresa",
	versaoAutomacao: "versaoAutomacao",
  );

 // (OPCIONAL) Definir manualmente os textos das dialogs.
 // Nao e necessario definir todos os campos
 ElginPAY.configurarTexto(
    dialogText: DialogText.ERRO_IMPRESSAO,
	title: "ERROR",
  );
}

void administrativa() {
  ElginPAY.transactionCall(operacao: Operacoes.Venda);
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
