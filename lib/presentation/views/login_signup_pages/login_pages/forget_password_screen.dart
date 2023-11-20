import 'package:email_otp/email_otp.dart';
import 'package:flutter/material.dart';
import 'package:wewa/presentation/views/login_signup_pages/login_pages/email_verification.dart';
import 'package:wewa/presentation/widgets/custom_form_field.dart';
import 'package:wewa/presentation/widgets/custom_signin_signup.dart';

class ForgetPassword extends StatelessWidget {
  ForgetPassword({Key? key}) : super(key: key);
  static final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  EmailOTP verification = EmailOTP();
  late TextEditingController email = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double actualHeight = (1 - (90 / MediaQuery.of(context).size.height)) *
        MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 90,
        scrolledUnderElevation: 0.0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: actualHeight,
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.only(left: 20, right: 20),
          //color: Colors.red,
          child: Column(
            children: [
              Container(
                //color: Colors.red,
                margin: EdgeInsets.only(bottom: actualHeight*0.1),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Forget password',
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
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
              Form(
                key: formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 15.0),
                      child: CustomFormField(
                        title: "Email",
                        HintText: "example@gmail.com",
                        controller: email,
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
                    CustomSignIn_UpOne(
                      title: 'Send Code',
                      ontap: () async {
                        if (formKey.currentState!.validate()) {
                          verification.setConfig(
                            appEmail: "mohamedtarek20192001@gmail.com",
                            appName:
                                "Wewa Emial verification for password reset",
                            userEmail: email.text,
                            otpLength: 6,
                            otpType: OTPType.digitsOnly,
                          );
                          if (await verification.sendOTP() == true) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("OTP has been sent"),
                              ),
                            );
                            Navigator.push(context, MaterialPageRoute(builder: (context) {
                              return EmailVerify();
                            },),);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Oops, OTP send failed"),
                              ),
                            );
                          }
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
