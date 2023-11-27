import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wewa/bussiness_logic/state_cubits/login_cubit.dart';
import 'package:wewa/presentation/views/login_signup_pages/login_pages/Login_screen.dart';
import 'package:wewa/presentation/widgets/custom_form_field.dart';
import 'package:wewa/presentation/widgets/custom_signin_signup.dart';

class CreateNewPassword extends StatelessWidget {
  const CreateNewPassword({Key? key}) : super(key: key);
  static final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double actualHeight = (1 - (150 / MediaQuery.sizeOf(context).height)) *
        MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 90,
        scrolledUnderElevation: 0.0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            //color: Colors.blue,
            height: actualHeight,
            width: MediaQuery.sizeOf(context).width,
            margin: const EdgeInsets.only(left: 20, right: 20),
            //color: Colors.red,
            child: Column(
              children: [
                Container(
                  //color: Colors.red,
                  margin: EdgeInsets.only(bottom: actualHeight * 0.1),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Create New Password',
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Connect with your friends today!',
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                BlocBuilder<LoginCubit, LoginState>(
                  builder: (context, state) {
                    return Form(
                      key: formKey,
                      child: Column(
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height *
                                0.01,
                          ),
                          CustomFormField(
                            title: "Password",
                            HintText: "Enter your Password",
                            controller: context.read<LoginCubit>().password,
                            obsecure: context.read<LoginCubit>().obsecure,
                            passwordField: true,
                            validation: (value) {
                              var temp = value?.split('');
                              if (value == null || value.isEmpty) {
                                return 'please enter your password';
                              } else if (!value.contains(RegExp(r'[0-9]')) ||
                                  !value.contains(RegExp(r'[a-z]')) ||
                                  !value.contains(RegExp(r'[A-Z]'))) {
                                return "your password should contain at least two small letters,\ncapital letters and four numbers";
                              } else if ((temp?.where((element) => element.contains(RegExp(r'[0-9]'))).length ?? 0) < 4
                                  ||
                                  (temp?.where((element) => element.contains(RegExp(r'[a-z]'))).length ?? 0) < 4
                                  ||
                                  (temp?.where((element) => element.contains(RegExp(r'[A-Z]'))).length ?? 0) < 4) {
                                return "your password should contain at least\n two small letters,capital letters and four numbers";
                              }
                              return null;
                            },
                            visibleOnTap: () {
                              context.read<LoginCubit>().visibiltyToggele();
                            },
                          ),
                          CustomFormField(
                            title: "Confirm Password",
                            HintText: "Confirm your Password",
                            controller: context.read<LoginCubit>().confirmPassword,
                            obsecure: context.read<LoginCubit>().obsecure,
                            passwordField: true,
                            validation: (value) {
                              if (context.read<LoginCubit>().password.text != context.read<LoginCubit>().confirmPassword.text){
                                return 'your input should match the password';
                              }
                              return null;
                            },
                            visibleOnTap: () {
                              context.read<LoginCubit>().visibiltyToggele();
                            },

                          ),
                          CustomSignIn_UpOne(
                                title: 'Send Code',
                                ontap: () async {
                                  if (formKey.currentState!.validate()) {
                                    Navigator.popUntil(context, (route) => false);
                                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                                      return LoginScreen();
                                    },),);
                                    }
                                  }
                              )
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
