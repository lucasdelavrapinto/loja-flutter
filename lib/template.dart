import 'package:flutter/material.dart';
import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tionico/homePage.dart';
import 'package:tionico/perfilPage.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex;

  @override
  void initState() {
    
    super.initState();
    currentIndex = 0;
  }

  void changePage(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  List<Widget> pages = [
    PerfilPage(),
    ProdutosPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BubbleBottomBar(
        hasNotch: true,
        opacity: .2,
        currentIndex: currentIndex,
        onTap: changePage,
        elevation: 8,
        items: <BubbleBottomBarItem>[
          BubbleBottomBarItem(
              backgroundColor: Colors.teal,
              icon: Icon(
                FontAwesomeIcons.userAlt,
                color: Colors.black,
              ),
              activeIcon: Icon(
                FontAwesomeIcons.userAlt,
                color: Colors.teal,
              ),
              title: Text("Perfil")),
          BubbleBottomBarItem(
              backgroundColor: Colors.teal,
              icon: Icon(
                FontAwesomeIcons.store,
                color: Colors.black,
              ),
              activeIcon: Icon(
                FontAwesomeIcons.store,
                color: Colors.teal,
              ),
              title: Text("Produtos")),
        ],
      ),
      body: pages[currentIndex],
    );
  }
}
