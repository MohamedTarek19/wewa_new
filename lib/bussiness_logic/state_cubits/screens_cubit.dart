import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:meta/meta.dart';
import 'package:wewa/presentation/views/home/Categories_pages/all_categories_Screen.dart';
import 'package:wewa/presentation/views/home/main_home.dart';
import 'package:wewa/presentation/views/login_signup_pages/onboarding.dart';
import 'package:wewa/presentation/views/profile_pages/profile_main.dart';

part 'screens_state.dart';

class ScreensCubit extends Cubit<ScreensState> {
  ScreensCubit() : super(ScreensInitial());
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
      'Categories',
      style: optionStyle,
    ),
    Text(
      'Profile',
      style: optionStyle,
    ),
  ];
  int selectedIndex = 0;
  late List<Widget> screens;
  ScreensInitializer(){
    screens = [
      MainHome(),
      SafeArea(child: Placeholder(child: _widgetOptions[1],)),
      AllCategories(),
     ProfileMain(),

    ];
  }
  void selectPage(int index){
      selectedIndex = index;
      emit(ScreensChange());
  }

}


