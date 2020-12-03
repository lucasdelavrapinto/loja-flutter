import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tionico/Class/Produto.dart';
import 'package:tionico/Webservice/chamadas.dart';
import 'package:tionico/utils.dart';

class ProdutosPage extends StatefulWidget {
  ProdutosPage({Key key}) : super(key: key);

  @override
  _ProdutosPageState createState() => _ProdutosPageState();
}

class _ProdutosPageState extends State<ProdutosPage> {
  List produtos = [];
  int pontos = 459;

  Future getInfo() async {
    print('consultando produtos');
    produtos.clear();

    await getConsultaProdutos().then((value) {
      print(">>> ${value.toString()}");
      for (var i in value.data) {
        var produto = Produto.fromJson(i);
        produtos.add(produto);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: getInfo,
        child: Container(
          margin: EdgeInsets.only(top: 30),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 20,
                ),
                Text("Produtos",
                    style: GoogleFonts.poppins(
                        fontSize: 20,
                        color: Colors.teal,
                        fontWeight: FontWeight.bold)),
                FutureBuilder(
                  future: getInfo(),
                  builder: (_, AsyncSnapshot snapshot) {
                    print(snapshot.connectionState);

                    switch (snapshot.connectionState) {
                      case ConnectionState.none:
                        return Text('Select lot');
                      case ConnectionState.waiting:
                        return Text("procurando produtos...");
                      case ConnectionState.active:
                        return Text('snapshot.data');
                      case ConnectionState.done:
                        return Container(
                          // height: 600,
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: produtos.length,
                              itemBuilder: (ctx, idx) {
                                var produto = produtos[idx];

                                return Container(
                                  height: 70,
                                  child: ListTile(
                                    title: Text(produto.descricao.toString()),
                                    trailing: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.teal[200],
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15.0)),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "${produto.pontos}",
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }),
                        );
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
