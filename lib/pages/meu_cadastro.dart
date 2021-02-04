import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tionico/Class/Usuario.dart';
import 'package:tionico/MOBX/STORE.dart';
import 'package:tionico/Webservice/chamadas.dart';
import 'package:tionico/pages/login_page.dart';
import 'package:tionico/utils.dart';

class MeuCadastro extends StatefulWidget {
  MeuCadastro({Key key}) : super(key: key);

  @override
  _MeuCadastroState createState() => _MeuCadastroState();
}

class _MeuCadastroState extends State<MeuCadastro> {
  final _formKeyCadastro = new GlobalKey<FormState>();

  TextEditingController _nomeController =
      TextEditingController(text: userStore.usuario.name);
  TextEditingController _emailController =
      TextEditingController(text: userStore.usuario.email);
  TextEditingController _cpfController =
      TextEditingController(text: userStore.usuario.cpf);
  TextEditingController _telefoneController;
  TextEditingController _nascimentoController;

  FocusNode loginNode = FocusNode();

  bool _isLoading = false;

  @override
  void initState() {
    log(userStore.usuario.telefone);
    super.initState();
    if (userStore.usuario.telefone.isEmpty ||
        userStore.usuario.telefone == "null") {
      _telefoneController = TextEditingController(text: "");
    } else {
      _telefoneController =
          TextEditingController(text: userStore.usuario.telefone);
    }

    if (userStore.usuario.nascimento.isEmpty ||
        userStore.usuario.nascimento == "null") {
      _nascimentoController = TextEditingController(text: "");
    } else {
      _nascimentoController =
          TextEditingController(text: userStore.usuario.nascimento);
    }
  }

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
                key: _formKeyCadastro,
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
        readOnly: true,
        inputFormatters: <TextInputFormatter>[LowerCaseTextFormatter()],
        keyboardType: TextInputType.text,
        autocorrect: false,
        cursorColor: Colors.black,
        cursorWidth: 1,
        style: GoogleFonts.poppins(color: Colors.grey[400]),
        decoration: InputDecoration(
          focusedBorder:
              UnderlineInputBorder(borderSide: BorderSide(color: Colors.green)),
          hintText: 'email',
          hintStyle: TextStyle(color: Colors.black38),
          helperText: 'Alteração de email bloqueada',
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

  Widget _acessarButton() {
    if (_isLoading) {
      return Padding(
        padding: EdgeInsets.only(top: 45),
        child: SpinKitThreeBounce(
          color: Colors.teal,
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
                'Atualizar meus dados',
                style: GoogleFonts.roboto(
                    letterSpacing: -1,
                    fontSize: 14,
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

    setState(() => _isLoading = true );

    Map dados = {
      "nome": _nomeController.text,
      "cpf": _cpfController.text,
      "telefone": _telefoneController.text,
      "nascimento": _nascimentoController.text.replaceAll("/", '-')
    };

    print("+++");
    print(dados);

    updateCadastro(dados).then((e) async {
      print("___");
      print(e);

      setState(() => _isLoading = false );

      if (e['message'] == "success") {
        toastAviso("Dados atualizados com sucesso!", textoSize: 12);
        await getMe().then((response) async {
          Usuario user = Usuario.fromMap(response.data);
          userStore.setUser(user);
        });
        
        await Future.delayed(Duration(milliseconds: 500))
            .then((x) => Navigator.of(context).pop());
      } else {
        toastAviso("Falha ao atualizar os dados, tente novamente mais tarde!", textoSize: 12);
      }
    }).catchError((error){
        toastAviso("Verifique seus dados e tente novamente!", textoSize: 12);
    });
  }
}
