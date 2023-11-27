import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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


      body: MainHome(),



      bottomNavigationBar: BottomNavigationBar(
        type : BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: selectPage,
        selectedItemColor:const Color(0xff0CB502),
        unselectedItemColor: const Color(0xff737373),
        elevation: 9,
        items:  [
          BottomNavigationBarItem(icon: SvgPicture.asset('assets/images/Icons/home_icon.svg',
            color: _selectedIndex == 0? const Color(0xff0CB502):const Color(0xff737373),)
            ,label: 'Home',),
           BottomNavigationBarItem(icon: SvgPicture.asset('assets/images/Icons/vendor_icon.svg',
            color: _selectedIndex == 1? const Color(0xff0CB502):const Color(0xff737373),),label: 'Vendor',),
           BottomNavigationBarItem(icon: SvgPicture.asset('assets/images/Icons/categories_icon.svg',
             color: _selectedIndex == 2? const Color(0xff0CB502):const Color(0xff737373),),label: 'Categories',),
           BottomNavigationBarItem(icon: SvgPicture.asset('assets/images/Icons/profile_icon.svg',
             color: _selectedIndex == 3? const Color(0xff0CB502):const Color(0xff737373),),label: 'Profile',),
        ],
      ),
    );
  }
}
