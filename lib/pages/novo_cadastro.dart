import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tionico/Class/Produto.dart';
import 'package:tionico/Class/Usuario.dart';
import 'package:tionico/MOBX/STORE.dart';
import 'package:tionico/Webservice/chamadas.dart';
import 'package:tionico/Webservice/shared_preferences.dart';
import 'package:tionico/pages/login_page.dart';
import 'package:tionico/template.dart';

import '../utils.dart';

class NovoCadastro extends StatefulWidget {
  NovoCadastro({Key key}) : super(key: key);

  @override
  _NovoCadastroState createState() => _NovoCadastroState();
}

class _NovoCadastroState extends State<NovoCadastro> {
  final _formKey = new GlobalKey<FormState>();

  TextEditingController _nomeController = TextEditingController(text: "");
  TextEditingController _emailController = TextEditingController(text: "");
  TextEditingController _cpfController = TextEditingController(text: "");

  TextEditingController _telefoneController = TextEditingController(text: "");
  TextEditingController _nascimentoController = TextEditingController(text: "");

  TextEditingController _passwordController = TextEditingController(text: "");

  FocusNode loginNode = FocusNode();
  FocusNode passNode = FocusNode();

  bool showPassword = false;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(16.0),
              child: new Form(
                key: _formKey,
                child: ListView(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  children: <Widget>[
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Container(
                            child: Icon(Icons.arrow_back),
                          ),
                        ),
                      ],
                    ),
                    _showLogo(),
                    _showNome(),
                    _showUsuarioInput(),
                    _showCpfInput(),
                    _showTelefoneInput(),
                    _showNascimentoInput(),
                    _showPasswordInput(),
                    _acessarButton(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _showLogo() {
    return new Hero(
      tag: 'hero',
      child: Padding(
        padding: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
        child: Image.asset(
          "assets/images/logo.jpeg",
          height: 50,
        ),
      ),
    );
  }

  Widget _showNome() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 0.0),
      child: TextFormField(
        // focusNode: loginNode,
        controller: _nomeController,
        keyboardType: TextInputType.text,
        autocorrect: false,
        cursorColor: Colors.black,
        cursorWidth: 1,
        style: GoogleFonts.poppins(),
        decoration: InputDecoration(
          focusedBorder:
              UnderlineInputBorder(borderSide: BorderSide(color: Colors.green)),
          hintText: 'Nome',
          hintStyle: TextStyle(color: Colors.black38),
          helperText: 'ex: Nico',
          helperStyle: TextStyle(color: Colors.black26, fontSize: 10),
          icon: new Icon(
            Icons.person,
            color: Colors.teal,
          ),
        ),
        validator: (value) =>
            value.isEmpty ? 'Informe o nome do usuário' : null,
      ),
    );
  }

  Widget _showUsuarioInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
      child: TextFormField(
        focusNode: loginNode,
        controller: _emailController,
        inputFormatters: <TextInputFormatter>[LowerCaseTextFormatter()],
        keyboardType: TextInputType.text,
        autocorrect: false,
        cursorColor: Colors.black,
        cursorWidth: 1,
        style: GoogleFonts.poppins(),
        decoration: InputDecoration(
          focusedBorder:
              UnderlineInputBorder(borderSide: BorderSide(color: Colors.green)),
          hintText: 'email',
          hintStyle: TextStyle(color: Colors.black38),
          helperText: 'ex: fulano@gmail.com',
          helperStyle: TextStyle(color: Colors.black26, fontSize: 10),
          icon: new Icon(
            Icons.person,
            color: Colors.teal,
          ),
        ),
        validator: (value) =>
            value.isEmpty ? 'Informe o nome do usuário' : null,
      ),
    );
  }

  Widget _showCpfInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
      child: TextFormField(
        // focusNode: loginNode,
        controller: _cpfController,
        inputFormatters: <TextInputFormatter>[maskCpfFormatter],
        keyboardType: TextInputType.number,
        autocorrect: false,
        cursorColor: Colors.black,
        cursorWidth: 1,
        style: GoogleFonts.poppins(),
        decoration: InputDecoration(
          focusedBorder:
              UnderlineInputBorder(borderSide: BorderSide(color: Colors.green)),
          hintText: 'cpf',
          hintStyle: TextStyle(color: Colors.black38),
          helperText: 'ex: 000.000.000-00',
          helperStyle: TextStyle(color: Colors.black26, fontSize: 10),
          icon: new Icon(
            Icons.person,
            color: Colors.teal,
          ),
        ),
        validator: (value) =>
            value.isEmpty ? 'Informe o nome do usuário' : null,
      ),
    );
  }

  Widget _showTelefoneInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
      child: TextFormField(
        controller: _telefoneController,
        inputFormatters: <TextInputFormatter>[maskTelefoneFormatter],
        keyboardType: TextInputType.number,
        autocorrect: false,
        cursorColor: Colors.black,
        cursorWidth: 1,
        style: GoogleFonts.poppins(),
        decoration: InputDecoration(
          focusedBorder:
              UnderlineInputBorder(borderSide: BorderSide(color: Colors.green)),
          hintText: 'telefone',
          hintStyle: TextStyle(color: Colors.black38),
          helperText: 'ex: (49) 1234 4567',
          helperStyle: TextStyle(color: Colors.black26, fontSize: 10),
          icon: new Icon(
            Icons.person,
            color: Colors.teal,
          ),
        ),
      ),
    );
  }

  Widget _showNascimentoInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
      child: TextFormField(
        controller: _nascimentoController,
        inputFormatters: <TextInputFormatter>[maskDateFormatter],
        keyboardType: TextInputType.number,
        autocorrect: false,
        cursorColor: Colors.black,
        cursorWidth: 1,
        style: GoogleFonts.poppins(),
        decoration: InputDecoration(
          focusedBorder:
              UnderlineInputBorder(borderSide: BorderSide(color: Colors.green)),
          hintText: 'Data de Nascimento',
          hintStyle: TextStyle(color: Colors.black38),
          helperText: 'ex: 04/09/1991',
          helperStyle: TextStyle(color: Colors.black26, fontSize: 10),
          icon: new Icon(
            Icons.person,
            color: Colors.teal,
          ),
        ),
      ),
    );
  }

  Widget _showPasswordInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
      child: new TextFormField(
        focusNode: passNode,
        maxLines: 1,
        obscureText: !showPassword,
        autofocus: false,
        cursorColor: Colors.black,
        cursorWidth: 1,
        style: GoogleFonts.poppins(),
        controller: _passwordController,
        decoration: new InputDecoration(
            focusedBorder:
                UnderlineInputBorder(borderSide: BorderSide(color: Colors.red)),
            hintText: 'senha',
            hintStyle: TextStyle(color: Colors.black38),
            helperText: "OBS: Toque no cadeado para conferir a senha",
            helperStyle: TextStyle(color: Colors.black26, fontSize: 10),
            icon: GestureDetector(
              onTap: () {
                setState(() => showPassword = !showPassword);
              },
              child: new Icon(
                showPassword ? Icons.lock_open : Icons.lock,
                color: Colors.teal,
              ),
            )),
        validator: (value) => value.isEmpty ? 'Infome sua senha' : null,
      ),
    );
  }

  Widget _acessarButton() {
    if (_isLoading) {
      return Padding(
        padding: EdgeInsets.only(top: 45),
        child: SpinKitThreeBounce(
          color: Colors.yellow,
          size: 30,
        ),
      );
    }

    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 150,
            decoration: BoxDecoration(
              color: Colors.orange,
              borderRadius: BorderRadius.all(Radius.circular(15.0)),
            ),
            child: FlatButton(
              child: Text(
                'Cadastrar',
                style: GoogleFonts.roboto(
                    letterSpacing: -1,
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: Colors.white),
              ),
              onPressed: _cadastrar,
            ),
          ),
        ],
      ),
    );
  }

  _cadastrar() async {
    loginNode.unfocus();
    passNode.unfocus();

    if (_nomeController.text.isEmpty ||
        _passwordController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _cpfController.text.isEmpty ||
        _telefoneController.text.isEmpty ||
        _nascimentoController.text.isEmpty) {
      return toastAviso("É necessário preencher todos os dados.");
    }

    Map dados = {
      "nome": _nomeController.text,
      "email": _emailController.text,
      "cpf": _cpfController.text,
      "nascimento": _nascimentoController.text.replaceAll("/", "-"),
      "telefone": _telefoneController.text,
      "password": _passwordController.text
    };

    log(dados.toString());

    doCadastro(dados).then((value) {
      setState(() => _isLoading = true);

      print(value.body);

      if (value.statusCode == 200) {
        getBearerToken(_emailController.text, _passwordController.text)
            .then((val) async {
          if (val.statusCode == 200) {
            print([val.statusCode, val.body]);

            var res = json.decode(val.body);
            await saveSharedPreferences('access_token', res['access_token']);

            await getMe().then((response) async {
              print("@@@@@@@@@");
              print(response.data);

              await Future.delayed(Duration(seconds: 2));

              if (response.data['status'] ==
                  "Token de Autorização não encontrada!") {
                toastAviso("falha ao consultar dados");
                return Navigator.of(context)
                    .push(new MaterialPageRoute(builder: (context) {
                  return new LoginPage();
                }));
              }

              Usuario user = Usuario.fromMap(response.data);
              print([user.name, user.email].toString());
              userStore.setUser(user);
            });

            print('passou dados login');

            produtoStore.listaDeProdutos = [];
            await getConsultaProdutos().then((value) {
              print(">>> ${value.toString()}");
              for (var i in value.data) {
                var produto = Produto.fromJson(i);
                produtoStore.addProdutoToList(produto);
              }
            });

            setState(() => _isLoading = false);

            return Navigator.of(context)
                .push(new MaterialPageRoute(builder: (context) {
              return new HomePage();
            }));
          }
        });
      } else {
        setState(() => _isLoading = false);
      }
    }).catchError((onError) {
      setState(() => _isLoading = false);
      toastAviso(onError.toString());
    });
  }
}
