import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:tionico/Class/Usuario.dart';
import 'package:tionico/MOBX/STORE.dart';
import 'package:tionico/Webservice/chamadas.dart';
import 'package:tionico/pages/alterar_senha.dart';
import 'package:tionico/pages/login_page.dart';
import 'package:tionico/pages/meu_cadastro.dart';
import 'package:tionico/utils.dart';

import 'Webservice/shared_preferences.dart';

class PerfilPage extends StatefulWidget {
  PerfilPage({Key key}) : super(key: key);

  @override
  _PerfilPageState createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {
  Future _check() async {
    await refreshMe().then((value) {
      print(value);
      if (!value) {
        Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
          return new LoginPage();
        }));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _check,
        child: Observer(
          builder: (_) => ListView(
            children: <Widget>[
              Column(
                children: [
                  SizedBox(
                    height: 40,
                  ),
                  Image.asset(
                    "assets/person.png",
                    width: MediaQuery.of(context).size.width / 2,
                  ),
                  Text("${userStore.usuario.name}",
                      style: GoogleFonts.poppins(fontSize: 18)),
                  Text("${userStore.usuario.email}", style: fonteTexto),
                  Text("${userStore.usuario.cpf}",
                      style: GoogleFonts.poppins(fontSize: 26)),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "${double.parse(userStore.usuario.pontos).toStringAsFixed(2)} pontos",
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                        color: Colors.teal),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    child: Column(
                      children: <Widget>[
                        GestureDetector(
                          onTap: () => Navigator.of(context)
                              .push(new MaterialPageRoute(builder: (context) {
                            return new AlterarSenhaPage();
                          })),
                          child: ListTile(
                            leading: Icon(
                              Icons.lock,
                              color: Colors.teal,
                            ),
                            title: Text("Alterar Senha de acesso",
                                style: fonteTexto),
                          ),
                        ),
                        GestureDetector(
                          onTap: () => Navigator.of(context)
                              .push(new MaterialPageRoute(builder: (context) {
                            return new MeuCadastro();
                          })),
                          child: ListTile(
                            leading: Icon(
                              Icons.person,
                              color: Colors.teal,
                            ),
                            title: Text("Alterar meus dados cadastrais",
                                style: fonteTexto),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text("Como faço para trocar meus pontos? "),
                                  content: Text("Basta ir até o Autoposto Tio Nico e apresentar a tela do perfil.\nAqui temos tudo que precisamos."),
                                  actions: [
                                    FlatButton(
                                      child: Text("OK"),
                                      onPressed: () => Navigator.of(context).pop(),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          child: ListTile(
                            leading: Icon(
                              Icons.help_outline,
                              color: Colors.teal,
                            ),
                            title: Text("Como trocar os pontos",
                                style: fonteTexto),
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            await logout().then((value) {
                              if (value.statusCode != 200) {
                                return toastAviso("Falha ao desconectar");
                              }

                              saveSharedPreferences('access_token', "");

                              // userStore.usuario = null;

                              EasyLoading.dismiss();

                              return Navigator.of(context).push(
                                  new MaterialPageRoute(builder: (context) {
                                return new LoginPage();
                              })).whenComplete(() {
                                userStore.setUser(Usuario("", "", "", '', "", ""));
                              });
                            });
                          },
                          child: ListTile(
                            leading: Icon(
                              Icons.exit_to_app,
                              color: Colors.teal,
                            ),
                            title: Text("Sair", style: fonteTexto),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
