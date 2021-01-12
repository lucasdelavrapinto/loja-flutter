import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:tionico/Class/Usuario.dart';
import 'package:tionico/MOBX/STORE.dart';
import 'package:tionico/Webservice/chamadas.dart';
import 'package:tionico/pages/alterar_senha.dart';
import 'package:tionico/pages/login_page.dart';
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
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "${userStore.usuario.pontos} pontos",
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
                                userStore.setUser(Usuario("", "", "", '', ""));
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
