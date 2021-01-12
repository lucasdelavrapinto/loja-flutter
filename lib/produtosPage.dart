import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tionico/Class/Produto.dart';
import 'package:tionico/MOBX/STORE.dart';
import 'package:tionico/Webservice/chamadas.dart';

import 'env.dart';

class ProdutosPage extends StatefulWidget {
  ProdutosPage({Key key}) : super(key: key);

  @override
  _ProdutosPageState createState() => _ProdutosPageState();
}

class _ProdutosPageState extends State<ProdutosPage> {
  Future getInfo() async {
    print('consultando produtos');
    produtoStore.listaDeProdutos.clear();

    await getConsultaProdutos().then((value) {
      print(">>> ${value.toString()}");
      for (var i in value.data) {
        var produto = Produto.fromJson(i);
        log(produto.descricao);
        produtoStore.addProdutoToList(produto);
      }
    });

    print('fim');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => Scaffold(
        body: RefreshIndicator(
          key: Key("aaaaa"),
          onRefresh: getInfo,
          child: Container(
            margin: EdgeInsets.only(top: 30),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Produtos",
                    style: GoogleFonts.poppins(
                        fontSize: 20,
                        color: Colors.teal,
                        fontWeight: FontWeight.bold),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: produtoStore.listaDeProdutos.length,
                    itemBuilder: (ctx, idx) {
                      var produto = produtoStore.listaDeProdutos[idx];

                      Widget getImage() {
                        try {
                          String url = "$host/storage/${produto.urlImg}";
                          return Container(
                              width: 100, child: Image.network(url));
                        } catch (e) {
                          return Image.asset("assets/logo.jpeg");
                        }
                      }

                      return Container(
                        height: 70,
                        child: ListTile(
                          leading: getImage(),
                          title: Text(
                            "Pontos necessários: ${produto.pontos}",
                            style: GoogleFonts.poppins(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text("${produto.descricao.toUpperCase()}"),
                        ),
                      );
                    },
                  ),
                  Center(
                    child: Container(
                        margin: EdgeInsets.only(top: 60),
                        width: MediaQuery.of(context).size.width - 80,
                        child: Text(
                          "Para resgatar seus pontos, vá até o Posto Tio Nico ou entre em contato conosco.",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                              fontSize: 12, color: Colors.black38),
                        )),
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
