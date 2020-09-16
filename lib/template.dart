import 'package:flutter/material.dart';
import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tionico/homePage.dart';
import 'package:tionico/perfilPage.dart';

class TemplatePage extends StatefulWidget {
  TemplatePage({Key key}) : super(key: key);

  @override
  _TemplatePageState createState() => _TemplatePageState();
}

class _TemplatePageState extends State<TemplatePage> {
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
    HomePage(),
    PerfilPage()
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
                FontAwesomeIcons.home,
                color: Colors.black,
              ),
              activeIcon: Icon(
                FontAwesomeIcons.home,
                color: Colors.teal,
              ),
              title: Text("Produtos")),
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
        ],
      ),
      body: pages[currentIndex],
    );
  }
}
