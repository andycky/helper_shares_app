import 'package:flutter/material.dart';
import '../pages/employers.dart';



class HomeScreen extends StatelessWidget{

  final int index;

  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  const HomeScreen(this.index);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return navigate(index);

    throw UnimplementedError();
  }

  static Widget navigate(index){

    Widget page=const Text('');
    switch (index){
      case -1:
        page = Image.asset('assets/img/logo.jpeg');
        break;
      case 0:
        page = const EmployersPage();
        break;
      case 1:
        page = const Text(
          'Index 1: test',
          style: optionStyle,
        );
        break;
      case 2:
        page = const Text(
          'Index 2: test',
          style: optionStyle,
        );
        break;
      case 3:
        page = const Text(
          'Index 3: test',
          style: optionStyle,
        );
        break;
    }

    return page;

  }


}

