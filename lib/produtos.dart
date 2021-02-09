import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:tionico/Class/Produto.dart';
import 'package:tionico/MOBX/STORE.dart';
import 'package:tionico/Webservice/chamadas.dart';
import 'package:tionico/pages/login_page.dart';
import 'package:tionico/utils.dart';
import 'package:tionico/produto_info.dart';

import 'env.dart';

class ProdutosPage extends StatefulWidget {
  ProdutosPage({Key key}) : super(key: key);

  @override
  _ProdutosPageState createState() => _ProdutosPageState();
}

class _ProdutosPageState extends State<ProdutosPage> {
  Future getInfo() async {
    // produtoStore.listaDeProdutos.clear();

    log("1");

    if (produtoStore.listaDeProdutos.isEmpty) {
      log("2");
      await getConsultaProdutos().then((value) {
        if (value.data.asMap().containsKey('status')) {
          if (value.data["status"] == "Token expirado") {
            toastAviso("Tivemos um problema ao encontrar seus dados",
                textoSize: 12);

            Navigator.of(context)
                .pushReplacement(new MaterialPageRoute(builder: (context) {
              return new LoginPage();
            }));
          }
        }

        for (var i in value.data) {
          var produto = Produto.fromJson(i);
          produtoStore.addProdutoToList(produto);
        }
      });
    } else {
      log("3");
    }

    setState(() {});
  }

  Future getInfoForce() async {
    produtoStore.listaDeProdutos.clear();

    setState(() {});

    await getConsultaProdutos().then((value) {
      if (value.data.asMap().containsKey('status')) {
        if (value.data["status"] == "Token expirado") {
          toastAviso("Tivemos um problema ao encontrar seus dados",
              textoSize: 12);

          Navigator.of(context)
              .pushReplacement(new MaterialPageRoute(builder: (context) {
            return new LoginPage();
          }));
        }
      }

      for (var i in value.data) {
        var produto = Produto.fromJson(i);
        produtoStore.addProdutoToList(produto);
      }

      log('fim');
    });

    setState(() {});
  }

  getImage(url) async {
    return await http.get(url).then((http.Response e) {
      if (e.statusCode == 200) {
        return Container(width: 100, child: Image.network(url));
      } else {
        return Image.asset("assets/images/logo.jpeg");
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      return Scaffold(
        body: RefreshIndicator(
          key: Key("aaaaa"),
          onRefresh: getInfoForce,
          child: Container(
            margin: EdgeInsets.only(left: 10, right: 10, top: 30),
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
                produtoStore.listaDeProdutos.isEmpty
                    ? _empty()
                    : Expanded(
                        child: ListView.builder(
                          physics: AlwaysScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: produtoStore.listaDeProdutos.length,
                          itemBuilder: (ctx, idx) {
                            produtoStore.listaDeProdutos
                                .sort((a, b) => a.pontos.compareTo(b.pontos));
                            var produto = produtoStore.listaDeProdutos[idx];

                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(
                                      new MaterialPageRoute(builder: (context) {
                                    return new ProdutoInfo(produto: produto);
                                  }));
                                },
                                child: Container(
                                  child: ListTile(
                                    leading: Container(
                                        width: 100,
                                        child: Image.network(
                                            "$host/storage/${produto.urlImg}")),
                                    title: Text(
                                      "${produto.descricao.toUpperCase()}",
                                      style: GoogleFonts.poppins(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    subtitle: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Pontos necessários: ${produto.pontos}",
                                          style: GoogleFonts.poppins(
                                            fontSize: 12,
                                          ),
                                        ),
                                        double.parse(double.parse(userStore
                                                        .usuario.pontos)
                                                    .toStringAsFixed(2)) >=
                                                produto.pontos
                                            ? Container(
                                                decoration: BoxDecoration(
                                                  color: Colors.orange,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(10)),
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    "Disponível para troca",
                                                    style: TextStyle(
                                                        fontSize: 10,
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              )
                                            : Container()
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                Center(
                  child: Container(
                      margin: EdgeInsets.only(top: 10),
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
      );
    });
  }

  _empty() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: Text("Carregando produtos, aguarde...")),
        ],
      ),
    );
  }
}
