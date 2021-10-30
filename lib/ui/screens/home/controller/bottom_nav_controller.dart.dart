import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class BottomNavController extends ChangeNotifier {
  //Switcher index NavBar
  int index = 0;

  //Switcher para mostrar u ocultar el NavBar
  bool showNavBar = true;

  //Métodos para cambiar el estado de NavBar
  changeShowNavBar() {
    showNavBar = !showNavBar;
    notifyListeners();
  }

  changeIndex(int index) {
    this.index = index;
    notifyListeners();
  }

  //Listener de scroll
  final ScrollController scrollController = ScrollController();
  void scrollListener() {
    if (scrollController.position.userScrollDirection ==
            ScrollDirection.reverse &&
        showNavBar) {
      print('HACIA ABAJO');
      changeShowNavBar();
    }
    if (scrollController.position.userScrollDirection ==
            ScrollDirection.forward &&
        !showNavBar) {
      print('HACIA ARRIBA');
      changeShowNavBar();
    }
  }
}
