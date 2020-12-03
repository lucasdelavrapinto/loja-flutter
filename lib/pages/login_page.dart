import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tionico/Class/Usuario.dart';
import 'package:tionico/MOBX/STORE.dart';
import 'package:tionico/Webservice/chamadas.dart';
import 'package:tionico/Webservice/shared_preferences.dart';
import 'package:tionico/pages/cadastro.dart';
import 'package:tionico/utils.dart';

import '../template.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = new GlobalKey<FormState>();

  TextEditingController loginController =
      TextEditingController(text: "lucasdelavrapinto@gmail.com");
  TextEditingController _passwordController =
      TextEditingController(text: "Reload04");

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
                    _showLogo(),
                    _showUsuarioInput(),
                    _showPasswordInput(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _showCadastrese(),
                        _showEsqueceuSenha(),
                      ],
                    ),
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
          height: 100,
        ),
      ),
    );
  }

  Widget _showUsuarioInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 80.0, 0.0, 0.0),
      child: TextFormField(
        focusNode: loginNode,
        controller: loginController,
        inputFormatters: <TextInputFormatter>[LowerCaseTextFormatter()],
        keyboardType: TextInputType.text,
        autocorrect: false,
        cursorColor: Colors.black,
        cursorWidth: 1,
        style: GoogleFonts.poppins(),
        decoration: InputDecoration(
          focusedBorder:
              UnderlineInputBorder(borderSide: BorderSide(color: Colors.green)),
          hintText: 'usuário',
          hintStyle: TextStyle(color: Colors.black38),
          helperText: 'ex: joao.silva',
          helperStyle: TextStyle(color: Colors.black26, fontSize: 10),
          icon: new Icon(
            Icons.person,
            color: Colors.green,
          ),
        ),
        validator: (value) =>
            value.isEmpty ? 'Informe o nome do usuário' : null,
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
                color: Colors.blue,
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
              color: Colors.amber,
              borderRadius: BorderRadius.all(Radius.circular(15.0)),
            ),
            child: FlatButton(
              child: Text(
                'ACESSAR',
                style: GoogleFonts.roboto(
                    letterSpacing: -1,
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: Colors.white),
              ),
              onPressed: _fazerLogin,
            ),
          ),
        ],
      ),
    );
  }

  _showCadastrese() {
    return Container(
      margin: EdgeInsets.only(top: 20, bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FlatButton(
            onPressed: () => Navigator.of(context)
                .push(new MaterialPageRoute(builder: (context) {
              return new NovoCadastro();
            })),
            child: Text(
              "Cadastre-se",
              style: GoogleFonts.roboto(
                  color: Colors.blue[800],
                  fontWeight: FontWeight.bold,
                  fontSize: 14),
            ),
          )
        ],
      ),
    );
  }

  _showEsqueceuSenha() {
    return Container(
      margin: EdgeInsets.only(top: 20, bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FlatButton(
            onPressed: () {},
            child: Text(
              "Esqueceu sua senha?",
              style: GoogleFonts.roboto(
                  color: Colors.blue[800],
                  fontWeight: FontWeight.bold,
                  fontSize: 14),
            ),
          )
        ],
      ),
    );
  }

  _fazerLogin() async {
    loginNode.unfocus();
    passNode.unfocus();

    if (loginController.text.isEmpty || _passwordController.text.isEmpty) {
      return toastAviso("É necessário preencher os dados de acesso");
    }

    setState(() => _isLoading = true );

    await getBearerToken(loginController.text, _passwordController.text)
        .then((value) async {
      log(value.body.toString());

      if (value.statusCode == 200) {
        var res = json.decode(value.body);
        await saveSharedPreferences('access_token', res['access_token']);

        await getMe().then((response) {
          print("@@@@@@@@@");
          print(response.data);

          if (response.data['status'] == "Token de Autorização não encontrada!") {
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

        await Future.delayed(Duration(seconds: 1));

        print('passou');
        setState(() => _isLoading = false );

        return Navigator.of(context)
            .push(new MaterialPageRoute(builder: (context) {
          return new HomePage();
        }));

      } else {
        setState(() => _isLoading = false );
      }
    });
  }
}

class LowerCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text?.toLowerCase(),
      selection: newValue.selection,
    );
  }
}
