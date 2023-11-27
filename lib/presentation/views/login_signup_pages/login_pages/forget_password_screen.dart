import 'package:email_otp/email_otp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wewa/bussiness_logic/state_cubits/forget_password_cubit.dart';
import 'package:wewa/bussiness_logic/state_cubits/login_cubit.dart';
import 'package:wewa/presentation/views/login_signup_pages/login_pages/email_verification.dart';
import 'package:wewa/presentation/widgets/custom_form_field.dart';
import 'package:wewa/presentation/widgets/custom_signin_signup.dart';

class ForgetPassword extends StatelessWidget {
  ForgetPassword({Key? key}) : super(key: key);
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
                        'Forget password',
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Let\'s get you back in! Enter your email',
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
                          Padding(
                            padding: const EdgeInsets.only(bottom: 15.0),
                            child: CustomFormField(
                              title: "Email",
                              HintText: "example@gmail.com",
                              controller: context.read<LoginCubit>().email,
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
                          ),
                          BlocBuilder<ForgetPasswordCubit, ForgetPasswordState>(
                            builder: (context, state) {
                              return CustomSignIn_UpOne(
                                title: 'Send Code',
                                ontap: () async {
                                  if (formKey.currentState!.validate()) {
                                    await context.read<ForgetPasswordCubit>().SendEmail(context.read<LoginCubit>().email.text);
                                    if(state is ForgetPassInitialized){
                                      if (await context.read<ForgetPasswordCubit>().verification.sendOTP() == true) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            content: Text("OTP has been sent"),
                                          ),
                                        );
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) {
                                              return EmailVerify();
                                            },
                                          ),
                                        );
                                      }
                                      else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            content:
                                            Text("Oops, OTP send failed"),
                                          ),
                                        );
                                      }
                                    }else if(state is ForgetPassFail){
                                      print('failed');
                                    }
                                  }
                                },
                              );
                            },
                          ),
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
