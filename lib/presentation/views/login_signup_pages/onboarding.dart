import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wewa/presentation/views/login_signup_pages/login_pages/Login_screen.dart';
import 'package:wewa/presentation/widgets/custom_signin_signup.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.only(left: 20, right: 20),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.94,
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.02,bottom: MediaQuery.of(context).size.height*0.14),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 1.0),
                          child: SvgPicture.asset(
                            'assets/images/logos/inAppLogo.svg',
                            width: MediaQuery.of(context).size.width * 0.3,
                            height: MediaQuery.of(context).size.height * 0.1,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:  EdgeInsets.only(bottom: MediaQuery.of(context).size.height*0.02),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        CustomSignIn_UpOne(
                          title: "Sign In",
                          ontap: (){
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                              return LoginScreen();
                            },));
                          },
                        ),
                        CustomSignIn_UpTwo(
                          title: "Sign Up",
                          ontap: (){

                          },
                        ),
                      ],
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Divider(
                              height: 1,
                              color: Color(0x88000000),
                              thickness: 1,
                              indent: 5,
                              endIndent: 10,
                            ),
                          ),
                          Expanded(
                            child: Center(child: Text('Or with')),
                          ),
                          Expanded(
                            flex: 2,
                            child: Divider(
                              height: 1,
                              color: Color(0x88000000),
                              thickness: 1,
                              indent: 10,
                              endIndent: 5,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 10,
                              right: 10,
                            ),
                            child: Container(
                              height: 32,
                              width: 32,
                              child: SvgPicture.asset(
                                  'assets/images/Icons/facebook.svg'),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 10,
                              right: 10,
                            ),
                            child: Container(
                              height: 32,
                              width: 32,
                              child: SvgPicture.asset(
                                  'assets/images/Icons/google.svg'),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 10,
                              right: 10,
                            ),
                            child: Container(
                              height: 32,
                              width: 32,
                              child: SvgPicture.asset(
                                  'assets/images/Icons/apple.svg'),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.05,
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Container(
                          decoration: const BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                            color: Colors.black,
                            width:
                                1.0, // This would be the width of the underline
                          ))),
                          child: const Text(
                            "Continue as a guest",
                            style: TextStyle(
                              fontSize: 17,
                              color: Color(0xaf000000),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
