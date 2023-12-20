import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wewa/bussiness_logic/state_cubits/login_cubit.dart';
import 'package:wewa/bussiness_logic/state_cubits/signup_cubit.dart';
import 'package:wewa/presentation/views/login_signup_pages/login_pages/Login_screen.dart';
import 'package:wewa/presentation/views/login_signup_pages/register_pages/sign_up_second.dart';
import 'package:wewa/presentation/widgets/custom_form_field.dart';
import 'package:wewa/presentation/widgets/custom_signin_signup.dart';

class SignupFirst extends StatelessWidget {
  SignupFirst({Key? key}) : super(key: key);
  static final formkey = GlobalKey<FormState>();

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
                      child: BlocBuilder<SignupCubit, SignupState>(
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
                                        0.01,
                                  ),
                                  CustomFormField(
                                    title: "Full Name",
                                    HintText: "eg. John Doe",
                                    controller:
                                        context.read<SignupCubit>().name,
                                    obsecure: false,
                                    passwordField: false,
                                    validation: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'please enter your full name';
                                      } else if (!value.contains(' ')) {
                                        return "your name should contain spaces like \"John Doe\"";
                                      }
                                      return null;
                                    },
                                    visibleOnTap: () {},
                                  ),
                                  CustomFormField(
                                    title: "Email",
                                    HintText: "example@gmail.com",
                                    controller:
                                        context.read<SignupCubit>().email,
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
                                  CustomFormField(
                                    title: "Password",
                                    HintText: "Enter your Password",
                                    controller:
                                        context.read<SignupCubit>().password,
                                    obsecure:
                                        context.read<SignupCubit>().obsecure,
                                    passwordField: true,
                                    validation: (value) {
                                      // var temp = value?.split('');
                                      // if (value == null || value.isEmpty) {
                                      //   return 'please enter your password';
                                      // } else if (!value.contains(RegExp(r'[0-9]')) ||
                                      //     !value.contains(RegExp(r'[a-z]')) ||
                                      //     !value.contains(RegExp(r'[A-Z]'))) {
                                      //   return "your password should contain at least two small letters,\ncapital letters and four numbers";
                                      // } else if ((temp?.where((element) => element.contains(RegExp(r'[0-9]'))).length ?? 0) < 2
                                      //     ||
                                      //     (temp?.where((element) => element.contains(RegExp(r'[a-z]'))).length ?? 0) < 2
                                      //     ||
                                      //     (temp?.where((element) => element.contains(RegExp(r'[A-Z]'))).length ?? 0) < 4) {
                                      //   return "your password should contain at least two small letters,\ncapital letters and four numbers";
                                      // }
                                      // return null;
                                    },
                                    visibleOnTap: () {
                                      context
                                          .read<SignupCubit>()
                                          .visibiltyToggele();
                                    },
                                  ),
                                  CustomFormField(
                                    title: "Confirm Password",
                                    HintText: "Confirm your Password",
                                    controller: context
                                        .read<SignupCubit>()
                                        .confirmPassword,
                                    obsecure:
                                        context.read<SignupCubit>().obsecure,
                                    passwordField: true,
                                    validation: (value) {
                                      if (context
                                              .read<SignupCubit>()
                                              .password
                                              .text !=
                                          context
                                              .read<SignupCubit>()
                                              .confirmPassword
                                              .text) {
                                        return 'your input should match the password';
                                      }
                                      return null;
                                    },
                                    visibleOnTap: () {
                                      context
                                          .read<SignupCubit>()
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
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            child: CustomSignIn_UpOne(
                              title: 'Sign Up',
                              ontap: () {
                                if (formkey.currentState!.validate()) {
                                  Navigator.push(context, MaterialPageRoute(
                                    builder: (context) {
                                      return SignupSecondScreen();
                                    },
                                  ));
                                }
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    'Already have an account?',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  BlocBuilder<LoginCubit, LoginState>(
                                    builder: (context, state) {
                                      return TextButton(
                                        onPressed: () {
                                          context.read<LoginCubit>().reset();
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) {
                                                return LoginScreen();
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
                                            "Log in",
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
