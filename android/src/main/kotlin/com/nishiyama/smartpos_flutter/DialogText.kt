package com.nishiyama.smartpos_flutter

enum class DialogGroup {
    ERRO_IMPRESSAO,
    ERRO_OPERACAO,
    RETORNO,
    IMPRESSAO_CLIENTE,
}

class DialogText {
    companion object {
        var strings = arrayOf(
            mutableMapOf(
                "title" to "Erro na impressão",
                "message" to "Impressora sem papel\nTroque a bonina",
                "positiveButton" to "Reimprimir",
                "negativeButton" to "Sair"
            ),
            mutableMapOf(
                "title" to "Erro na Operação!",
                "message" to "Deseja confirmar a transação?",
                "positiveButton" to "Sim",
                "negativeButton" to ""
            ),
            mutableMapOf(
                "title" to "Retorno",
                "message" to "",
                "positiveButton" to "OK",
                "negativeButton" to ""
            ),
            mutableMapOf(
                "title" to "Comprovante Cliente",
                "message" to "Deseja imprimir via do Cliente?",
                "positiveButton" to "Sim",
                "negativeButton" to "Não"
            )
        )

        fun editString(dialog: DialogGroup, title : String?, message : String?, positiveButton : String?, negativeButton : String?) {
            if (title != null)
            strings[dialog.ordinal]["title"] = title
            if (message != null)
            strings[dialog.ordinal]["message"] = message
            if (positiveButton != null)
            strings[dialog.ordinal]["positiveButton"] = positiveButton
            if (negativeButton != null)
            strings[dialog.ordinal]["negativeButton"] = negativeButton
        }
    }
}