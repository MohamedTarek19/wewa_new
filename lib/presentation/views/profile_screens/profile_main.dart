import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfileMain extends StatelessWidget {
  const ProfileMain({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SvgPicture.asset(
          'assets/images/logos/inAppLogo.svg',
          height: 40,
        ),
        centerTitle: true,
      ),
    );
  }
}
