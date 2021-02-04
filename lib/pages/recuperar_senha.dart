import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tionico/Webservice/chamadas.dart';
import 'package:tionico/utils.dart';

class RecuperarSenha extends StatefulWidget {
  RecuperarSenha({Key key}) : super(key: key);

  @override
  _RecuperarSenhaState createState() => _RecuperarSenhaState();
}

class _RecuperarSenhaState extends State<RecuperarSenha> {
  final _formKey = new GlobalKey<FormState>();

  TextEditingController _emailController = TextEditingController(text: "");

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
                    _showEmail(),

                    Container(
                      margin: EdgeInsets.only(top: 20),
                      child: Text(
                        "Será enviado uma nova senha para seu email, você não conseguirá acessar sua conta com a senha antiga.",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.roboto(
                            fontSize: 12,
                            color: Colors.black45,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    _recuperarSenha(),
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

  Widget _showEmail() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 0.0),
      child: TextFormField(
        controller: _emailController,
        obscureText: false,
        keyboardType: TextInputType.text,
        cursorColor: Colors.black,
        cursorWidth: 1,
        style: GoogleFonts.poppins(),
        onChanged: (String value) {
          setState(() {});
        },
        decoration: InputDecoration(
          focusedBorder:
              UnderlineInputBorder(borderSide: BorderSide(color: Colors.green)),
          hintText: 'Email',
          hintStyle: TextStyle(color: Colors.black38),
          icon: new Icon(
            Icons.email,
            color: Colors.teal,
          ),
        ),
        validator: (value) => value.isEmpty ? 'Informe o email' : null,
      ),
    );
  }

  Widget _recuperarSenha() {
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
                'Recuperar Senha',
                style: GoogleFonts.roboto(
                    letterSpacing: -1,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.white),
              ),
              onPressed: _recuperar,
            ),
          ),
        ],
      ),
    );
  }

  _recuperar() async {
    if (_emailController.text.isEmpty) {
      return toastAviso("É necessário preencher o email", textoSize: 12);
    }

    setState(() => _isLoading = true);

    String email = _emailController.text;

    recuperarSenha({"email": email}).then((e) async {
      setState(() => _isLoading = false);
      if (e.statusCode == 200) {
        toastAviso("Senha enviada para seu email! Siga os procedimentos.",
            textoSize: 12);

        await Future.delayed(Duration(seconds: 1))
            .then((x) => Navigator.of(context).pop());
      } else if (e.statusCode == 404) {
        toastAviso("Falha ao enviar o email, tente mais tarde!", textoSize: 12);
      }

      log(e.body.toString());
    }).catchError((x) {
      log(x.toString());
      setState(() => _isLoading = false);
    });
  }
}
