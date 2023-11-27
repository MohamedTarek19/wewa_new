import 'package:flutter/material.dart';
import 'package:wewa/presentation/views/home/main_home.dart';

class MainHub extends StatefulWidget {
  const MainHub({super.key});

  @override
  State<MainHub> createState() => _MainHubState();
}

class _MainHubState extends State<MainHub> {


  static const TextStyle optionStyle =
  TextStyle(fontSize: 25, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'home',
      style: optionStyle,
    ),
    Text(
      'vendor',
      style: optionStyle,
    ),
    Text(
      'buy',
      style: optionStyle,
    ),
    Text(
      'Cart',
      style: optionStyle,
    ),
  ];
  int _selectedIndex = 0;
  void selectPage(int index){
    setState(() {
      _selectedIndex = index;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(


      body: const MainHome(),



      bottomNavigationBar: BottomNavigationBar(
        type : BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: selectPage,
        selectedItemColor:Colors.black,
        unselectedItemColor: Colors.grey,
        elevation: 9,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined),label: 'home',),
          BottomNavigationBarItem(icon: Icon(Icons.sell),label: 'vendor',),
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined),label: 'vendor',),
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined),label: 'vendor',),
        ],
      ),
    );
  }
}
