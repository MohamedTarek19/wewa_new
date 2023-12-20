import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wewa/bussiness_logic/state_cubits/login_cubit.dart';
import 'package:wewa/bussiness_logic/state_cubits/signup_cubit.dart';
import 'package:wewa/bussiness_logic/state_cubits/wewa_products_cubit.dart';
import 'package:wewa/presentation/views/home/main_hub.dart';
import 'package:wewa/presentation/views/login_signup_pages/login_pages/forget_password_screen.dart';
import 'package:wewa/presentation/views/login_signup_pages/register_pages/sign_up_first.dart';
import 'package:wewa/presentation/widgets/custom_form_field.dart';
import 'package:wewa/presentation/widgets/custom_signin_signup.dart';
import 'package:wewa/presentation/widgets/custom_snak_bar.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  static final formkey = GlobalKey<FormState>();
  bool rememberMe = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: MediaQuery.sizeOf(context).width,
            height: MediaQuery.sizeOf(context).height * 0.94,
            child: SingleChildScrollView(
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          left: 20,
                          right: 20,
                          top: MediaQuery.sizeOf(context).height * 0.09),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 50),
                            child: SvgPicture.asset(
                              'assets/images/logos/inAppLogo.svg',
                              width: MediaQuery.sizeOf(context).width * 0.3,
                              height: MediaQuery.sizeOf(context).height * 0.1,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: BlocBuilder<LoginCubit, LoginState>(
                        builder: (context, state) {
                          return Form(
                            key: formkey,
                            child: Container(
                              //color: Colors.blue,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  SizedBox(
                                    height: MediaQuery.sizeOf(context).height *
                                        0.02,
                                  ),
                                  CustomFormField(
                                    title: "Email",
                                    HintText: "example@gmail.com",
                                    controller:
                                        context.read<LoginCubit>().email,
                                    obsecure: false,
                                    passwordField: false,
                                    validation: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'please enter your Email address';
                                      } else if (!value.contains('@') ||
                                          !value.contains('.com')) {
                                        return "your email should be in the form example@xxx.com";
                                      } else if (value.contains(' ')) {
                                        return 'your email shouldn\'t contain spaces';
                                      }
                                      return null;
                                    },
                                    visibleOnTap: () {},
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.02,
                                  ),
                                  CustomFormField(
                                    title: "Password",
                                    HintText: "Enter your Password",
                                    controller:
                                        context.read<LoginCubit>().password,
                                    obsecure:
                                        context.read<LoginCubit>().obsecure,
                                    passwordField: true,
                                    validation: (value) {
                                      // var temp = value?.split('');
                                      // if (value == null || value.isEmpty) {
                                      //   return 'please enter your password';
                                      // } else if (!value.contains(RegExp(r'[0-9]')) ||
                                      //     !value.contains(RegExp(r'[a-z]')) ||
                                      //     !value.contains(RegExp(r'[A-Z]'))) {
                                      //   return "your password should contain at least two small letters,\ncapital letters and four numbers";
                                      // } else if ((temp?.where((element) => element.contains(
                                      //     RegExp(r'[0-9]'))).length ?? 0) < 2 ||
                                      //     (temp?.where((element) => element.contains(
                                      //         RegExp(r'[a-z]'))).length ?? 0) < 2 ||
                                      //     (temp?.where((element) => element.contains(RegExp(r'[A-Z]'))).length ?? 0) < 4) {
                                      //   return "your password should contain at least two small letters,\ncapital letters and four numbers";
                                      // }
                                      // return null;
                                    },
                                    visibleOnTap: () {
                                      context
                                          .read<LoginCubit>()
                                          .visibiltyToggele();
                                    },
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).size.height * 0.01),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10, right: 15),
                            child: Container(
                              //color: Colors.red,
                              child: Row(
                                children: [
                                  StatefulBuilder(
                                    builder: (BuildContext context,
                                        void Function(void Function())
                                            setState) {
                                      return Expanded(
                                        child: ListTileTheme(
                                          horizontalTitleGap: -1,
                                          child: CheckboxListTile(
                                            splashRadius: 15,
                                            contentPadding:
                                                const EdgeInsets.all(0),
                                            controlAffinity:
                                                ListTileControlAffinity.leading,
                                            title: const Text(
                                              'Remember me',
                                              style: TextStyle(fontSize: 14),
                                            ),
                                            value: rememberMe,
                                            onChanged: (value) {
                                              setState(() {
                                                rememberMe = !rememberMe;
                                              });
                                            },
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                  Expanded(
                                    child: Container(
                                      alignment: Alignment.centerRight,
                                      child: TextButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) {
                                                return ForgetPassword();
                                              },
                                            ),
                                          );
                                        },
                                        child: Container(
                                          decoration: const BoxDecoration(
                                              border: Border(
                                                  bottom: BorderSide(
                                            color: Colors.black,
                                            width:
                                                1.0, // This would be the width of the underline
                                          ))),
                                          child: const Text(
                                            "forget password?",
                                            style: TextStyle(
                                              fontSize: 13,
                                              color: Color(0xaf000000),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          BlocBuilder<LoginCubit, LoginState>(
                            builder: (context, state) {
                              return Padding(
                                padding:
                                    const EdgeInsets.only(left: 20, right: 20),
                                child: CustomSignIn_UpOne(
                                      title: 'Sign In',
                                      ontap: () async {
                                        showDialog(context: context, builder: (context) {
                                          return Center(child: CircularProgressIndicator());
                                        },);
                                        if (formkey.currentState!.validate()) {
                                          var res = await context
                                              .read<LoginCubit>()
                                              .NewLogin();
                                          if (res['token'] == null) {
                                            Navigator.pop(context);
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(CustomSnak(
                                                    content: Text(
                                              "check your credentials or Sign "
                                              "Up",
                                              style: TextStyle(
                                                  color: Colors.red[900]),
                                              textDirection: TextDirection.ltr,
                                            )));

                                          } else {
                                            if (rememberMe == true) {
                                              await context
                                                  .read<LoginCubit>()
                                                  .rememberMe(res);
                                            }
                                            //context.read<WewaProductsCubit>().Products.forEach((element) {print(element.name);});
                                            Navigator.pop(context);
                                            Navigator.popUntil(
                                              context,
                                              (route) => false,
                                            );
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) {
                                                  return MainHub();
                                                },
                                              ),
                                            );
                                          }
                                        }
                                      },
                                    ),

                              );
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    'Don\'t have an account?',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  BlocBuilder<SignupCubit, SignupState>(
                                    builder: (context, state) {
                                      return TextButton(
                                        onPressed: () {
                                          context.read<SignupCubit>().reset();
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) {
                                                return SignupFirst();
                                              },
                                            ),
                                          );
                                        },
                                        child: Container(
                                          decoration: const BoxDecoration(
                                              border: Border(
                                                  bottom: BorderSide(
                                            color: Color(0xff0CB502),
                                            width:
                                                1.0, // This would be the width of the underline
                                          ))),
                                          child: const Text(
                                            "Sign up",
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: Color(0xff0CB502),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
