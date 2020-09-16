import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PerfilPage extends StatefulWidget {
  PerfilPage({Key key}) : super(key: key);

  @override
  _PerfilPageState createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 20),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          width: 50,
                          height: 50,
                          child: Icon(Icons.more_vert, color: Colors.teal,),
                        ),
                      )
                    ],
                  ),
                  CircleAvatar(
                    radius: 60.0,
                    backgroundImage: NetworkImage(
                        'https://interfacetreinamentos.com.br/wp-content/uploads/2016/04/img-profile-default.jpg'),
                    backgroundColor: Colors.transparent,
                  ),
                  Text("Lucas De Lavra Pinto"),
                  Text(
                    "459 pontos",
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                        color: Colors.teal),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    child: Column(
                      children: <Widget>[
                        ListTile(
                          leading: Icon(Icons.person, color: Colors.teal,),
                          title: Text("Editar meus dados"),
                        ),
                        ListTile(
                          leading: Icon(Icons.history, color: Colors.teal,),
                          title: Text("Histórico de trocas"),
                        ),
                        ListTile(
                          leading: Icon(Icons.help, color: Colors.teal,),
                          title: Text("Ajuda"),
                        ),
                        ListTile(
                          leading: Icon(Icons.priority_high, color: Colors.teal,),
                          title: Text("Privacidade"),
                        ),
                        ListTile(
                          leading: Icon(Icons.exit_to_app, color: Colors.teal,),
                          title: Text("Sair"),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
