import 'package:flutter/material.dart';
import 'package:tionico/Class/Usuario.dart';
import 'package:tionico/Webservice/chamadas.dart';
import 'package:tionico/template.dart';
import 'package:tionico/utils.dart';

import 'MOBX/STORE.dart';
import 'pages/login_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Posto Tio Nico',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/login': (context) => LoginPage(),
        '/home': (context) => HomePage()
      },
    );
  }
}

class SplashScreen extends StatefulWidget {
  SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    checkIfUserIsLogged();
    super.initState();
  }

  checkIfUserIsLogged() async {
    await getMe().then((response) async {
      print(">>>>>>>>>>>>>>");
      print(response.data);

      switch (response.data['status']) {
        case "Token de Autorização não encontrada!":
        case "Token expirado":
        case "Token é inválido":
          toastAviso("falha ao obter o token");

          return Navigator.of(context)
              .push(new MaterialPageRoute(builder: (context) {
            return new LoginPage();
          }));

          break;
        default:
      }

      Usuario user = Usuario.fromMap(response.data);
      print([user.name, user.email].toString());
      userStore.setUser(user);

      await Future.delayed(Duration(seconds: 2));

      print('passou');

      if (userStore.usuario.name.isNotEmpty &&
          userStore.usuario.email.isNotEmpty) {
        return Navigator.of(context)
            .pushReplacement(new MaterialPageRoute(builder: (context) {
          return new HomePage();
        }));
      } else {
        Usuario user = Usuario.fromMap(response.data);
        print([user.name, user.email].toString());
        userStore.setUser(user);

        return Navigator.of(context)
            .pushReplacement(new MaterialPageRoute(builder: (context) {
          return new HomePage();
        }));
      }
    }).catchError((onError) {
      return Navigator.of(context)
          .push(new MaterialPageRoute(builder: (context) {
        return new LoginPage();
      }));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Hero(
          tag: 'hero',
          child: Padding(
            padding: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
            child: Image.asset(
              "assets/images/logo.jpeg",
              height: 100,
            ),
          ),
        ),
      ),
    );
  }
}
