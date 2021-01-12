import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tionico/Webservice/chamadas.dart';

import '../utils.dart';

class AlterarSenhaPage extends StatefulWidget {
  AlterarSenhaPage({Key key}) : super(key: key);

  @override
  _AlterarSenhaPageState createState() => _AlterarSenhaPageState();
}

class _AlterarSenhaPageState extends State<AlterarSenhaPage> {
  final _formKey = new GlobalKey<FormState>();

  TextEditingController _senhaController = TextEditingController(text: "");
  TextEditingController _confirmaSenhaController =
      TextEditingController(text: "");

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
                    _showSenha(),
                    _showRepetirSenha(),
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      child: Text(
                        "A Alteração da senha terá validade para o próximo acesso ao app",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.roboto(fontSize: 10, color: Colors.black45, fontWeight: FontWeight.bold),
                      ),
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

  Widget _showSenha() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 0.0),
      child: TextFormField(
        controller: _senhaController,
        obscureText: true,
        keyboardType: TextInputType.text,
        autocorrect: false,
        cursorColor: Colors.black,
        cursorWidth: 1,
        style: GoogleFonts.poppins(),
        onChanged: (String value) {
          setState(() {});
        },
        decoration: InputDecoration(
          focusedBorder:
              UnderlineInputBorder(borderSide: BorderSide(color: Colors.green)),
          hintText: 'Senha',
          hintStyle: TextStyle(color: Colors.black38),
          helperText: "${_senhaController.text}",
          icon: new Icon(
            Icons.lock,
            color: Colors.teal,
          ),
        ),
        validator: (value) =>
            value.isEmpty ? 'Informe o nome do usuário' : null,
      ),
    );
  }

  Widget _showRepetirSenha() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
      child: TextFormField(
        controller: _confirmaSenhaController,
        keyboardType: TextInputType.text,
        autocorrect: false,
        cursorColor: Colors.black,
        obscureText: true,
        cursorWidth: 1,
        style: GoogleFonts.poppins(),
        decoration: InputDecoration(
          focusedBorder:
              UnderlineInputBorder(borderSide: BorderSide(color: Colors.green)),
          hintText: 'Repita a Senha',
          hintStyle: TextStyle(color: Colors.black38),
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

  Widget _acessarButton() {
    if (_isLoading) {
      return Padding(
        padding: EdgeInsets.only(top: 45),
        child: SpinKitThreeBounce(
          color: Colors.orange,
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
                'Atualizar Senha',
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
    if (_senhaController.text.isEmpty ||
        _confirmaSenhaController.text.isEmpty) {
      return toastAviso("É necessário preencher todos os campos.");
    }

    if (_senhaController.text != _confirmaSenhaController.text) {
      return toastAviso("Os valores informados são diferentes.");
    }

    setState(() => _isLoading = true );

    String senha = _senhaController.text;

    atualizarSenha(senha).then((e){

      if(e.data['message'] == "success"){
        toastAviso("Alteração de senha realizada com sucesso!");
      } else {
        toastAviso("Problema ao atualizar senha, tente novamente mais tarde!");
      }

      setState(() => _isLoading = false );
      
    });

    
  }
}
