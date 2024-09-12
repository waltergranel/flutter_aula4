import 'package:flutter/material.dart';

class Segunda extends StatefulWidget {
  const Segunda({super.key});

  @override
  State<Segunda> createState() => _SegundaState();
}

//*********
//
//Eu diminui o padding de 50 para 20 porque não está conseguindo enxergar os textfield e os buttons
//
//

class _SegundaState extends State<Segunda> {
  TextEditingController controllerNome = TextEditingController();
  TextEditingController controllerSobreNome = TextEditingController();
  TextEditingController controllerDataNascimento = TextEditingController();
  TextEditingController controllerSenha = TextEditingController();

  // Conjunto de Regras para a Data
  final RegExp dataRegExp =
      RegExp(r'^(0[1-9]|[12][0-9]|3[01])/(0[1-9]|1[0-2])/([0-9]{4})$');
  String dataErrorMessage = '';

  late FocusNode focoNome;
  String ajudaData = 'Exemplo: 01/01/1970';

  @override
  void initState() {
    super.initState();
    focoNome = FocusNode();
  }
  
  bool temMinimo8Caracteres = false;
  bool temLetraMaiuscula = false;
  bool tem3Numeros = false;
  bool tem2CaracteresEspeciais = false;
  
  final RegExp caractereEspecial = RegExp(r'[!@#$%^&*()?_\-+=]');
  final RegExp numeros = RegExp(r'[0-9]');
  final RegExp letraMaiuscula = RegExp(r'[A-Z]');
  String passwordErrorMessage = '';

  void validarSenha(String senha) {
    setState(() {
      temMinimo8Caracteres = senha.length >= 8;
      temLetraMaiuscula = letraMaiuscula.hasMatch(senha);
      tem3Numeros =
          senha.split('').where((c) => numeros.hasMatch(c)).length >= 3;
      tem2CaracteresEspeciais =
          senha.split('').where((c) => caractereEspecial.hasMatch(c)).length >=
              2;

      List<String> erros = [];
      if (!temMinimo8Caracteres) erros.add('Mínimo 8 caracteres');
      if (!temLetraMaiuscula) erros.add('Deve ter uma letra maiúscula');
      if (!tem3Numeros) erros.add('Deve conter 3 números');
      if (!tem2CaracteresEspeciais) {
        erros.add('Deve ter 2 caracteres especiais');
      }
      // Junta os erros em uma única string
      passwordErrorMessage = erros.isEmpty ? '' : erros.join('\n');
    });
  }

  @override
  void dispose() {
    focoNome.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextField(
                controller: controllerNome,
                autofocus: true,
                focusNode: focoNome,
                decoration: const InputDecoration(
                  /*enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                  ),*/
                  border: OutlineInputBorder(),
                  labelText: 'Nome:',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Sobrenome:',
                ),
                controller: controllerSobreNome,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextField(
                controller: controllerDataNascimento,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: 'Data Nascimento:',
                  helperText: ajudaData,
                  errorText:
                      dataErrorMessage.isNotEmpty ? dataErrorMessage : null,
                ),
                onChanged: (value) {
                  setState(() {
                    setState(() {
                      dataErrorMessage =
                          dataRegExp.hasMatch(value) ? '' : 'Data inválida';
                    });
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextField(
                  controller: controllerSenha,
                  obscureText: true,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: 'Senha:',
                    errorText: passwordErrorMessage.isNotEmpty
                        ? passwordErrorMessage
                        : null,
                  ),
                  onChanged: validarSenha,
                ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                    onPressed: () {
                      controllerNome.clear();
                      controllerSobreNome.clear();
                      controllerDataNascimento.clear();
                      controllerSenha.clear();
                      focoNome.requestFocus();
                      dataErrorMessage = '';
                      passwordErrorMessage = '';
                    },
                    child: const Text('Limpar')),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: ElevatedButton(
                      onPressed: () {
                        focoNome.requestFocus();
                      },
                      child: const Text('Enviar')),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}