import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wewa/bussiness_logic/state_cubits/screens_cubit.dart';
import 'package:wewa/presentation/views/home/main_home.dart';
import 'package:wewa/presentation/views/login_signup_pages/onboarding.dart';

class MainHub extends StatelessWidget {
  const MainHub({super.key});

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<ScreensCubit, ScreensState>(
  builder: (context, state) {
    return Scaffold(

      body: context.read<ScreensCubit>().screens[context.read<ScreensCubit>()
          .selectedIndex],

      bottomNavigationBar: BottomNavigationBar(
        type : BottomNavigationBarType.fixed,
        currentIndex: context.read<ScreensCubit>()
            .selectedIndex,
        onTap: context.read<ScreensCubit>().selectPage,
        selectedItemColor:const Color(0xff0CB502),
        unselectedItemColor: const Color(0xff737373),
        elevation: 9,
        items:  [
          BottomNavigationBarItem(icon: SvgPicture.asset('assets/images/Icons/home_icon.svg',
            color: context.read<ScreensCubit>()
                .selectedIndex == 0? const Color(0xff0CB502):const Color(0xff737373),)
            ,label: 'Home',),
           BottomNavigationBarItem(icon: SvgPicture.asset('assets/images/Icons/vendor_icon.svg',
            color: context.read<ScreensCubit>()
                .selectedIndex == 1? const Color(0xff0CB502):const Color(0xff737373),),label: 'Vendor',),
           BottomNavigationBarItem(icon: SvgPicture.asset('assets/images/Icons/categories_icon.svg',
             color: context.read<ScreensCubit>()
                 .selectedIndex == 2? const Color(0xff0CB502):const Color(0xff737373),),label: 'Categories',),
           BottomNavigationBarItem(icon: SvgPicture.asset('assets/images/Icons/profile_icon.svg',
             color: context.read<ScreensCubit>()
                 .selectedIndex == 3? const Color(0xff0CB502):const Color(0xff737373),),label: 'Profile',),
        ],
      ),
    );
  },
);
  }
}
