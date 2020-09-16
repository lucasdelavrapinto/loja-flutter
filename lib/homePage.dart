import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 20),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("Produtos",
                    style: GoogleFonts.poppins(
                        fontSize: 20,
                        color: Colors.teal,
                        fontWeight: FontWeight.bold)),
                Container(
                  height: MediaQuery.of(context).size.height - 150,
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: 10,
                      itemBuilder: (ctx, idx) {
                        return ListTile(
                          leading: CircleAvatar(
                            radius: 30.0,
                            backgroundImage: NetworkImage(
                                'https://www.usemilitar.com.br/image/cache/catalog/produtos/Camisetas/camiseta-soldier-verde-frente-550x550.jpg'),
                            backgroundColor: Colors.transparent,
                          ),
                          title: Text("Camiseta xyz"),
                          subtitle: Text("123 pontos"),
                          trailing: Container(
                            height: 30,
                            decoration: BoxDecoration(
                              color: Colors.teal,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15.0)),
                            ),
                            child: FlatButton(
                                onPressed: () {},
                                child: Text(
                                  "selecionar",
                                  style: GoogleFonts.roboto(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                )),
                          ),
                        );
                      }),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
