import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tionico/Class/Produto.dart';
import 'package:tionico/env.dart';

class ProdutoInfo extends StatelessWidget {
  final Produto produto;
  const ProdutoInfo({Key key, this.produto}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(produto);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 30),
                width: MediaQuery.of(context).size.width,
                height: 400,
                child: Center(
                    child: Image.network(
                  "$host/storage/${produto.urlImg}",
                  fit: BoxFit.fitHeight,
                )),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                child: Container(
                  height: MediaQuery.of(context).size.height / 2.5,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3))
                    ],
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30)),
                    color: Colors.teal.withOpacity(0.7),
                  ),
                  width: MediaQuery.of(context).size.width,
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(left: 20, right: 20, bottom: 10),
                          child: Text(
                            produto.descricao,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.orange[800],
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              produto.pontos.toString() + " pontos necessários",
                              style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 30,
                left: 0,
                child: Row(
                  children: <Widget>[
                    FlatButton(onPressed: () => Navigator.of(context).pop(), child: Icon(Icons.arrow_back),)
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
