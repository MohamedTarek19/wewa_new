import 'package:email_otp/email_otp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:wewa/presentation/widgets/custom_signin_signup.dart';

class EmailVerify extends StatefulWidget {
  EmailVerify({Key? key}) : super(key: key);

  @override
  State<EmailVerify> createState() => _EmailVerifyState();
}

class _EmailVerifyState extends State<EmailVerify> {
  EmailOTP verification = EmailOTP();

  late String code;

  var otpTextStyles = [
    const TextStyle(fontSize: 16),
    const TextStyle(fontSize: 16),
    const TextStyle(fontSize: 16),
    const TextStyle(fontSize: 16),
    const TextStyle(fontSize: 16),
    const TextStyle(fontSize: 16),
  ];

  @override
  Widget build(BuildContext context) {
    double actualHeight = (1 - (90 / MediaQuery.of(context).size.height)) *
        MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 90,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: actualHeight,
        margin: const EdgeInsets.only(right: 20, left: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Column(
              children: [
                const Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Email verification',
                      style: TextStyle(
                          fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Almost there! Just verify your email to continue.',
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: OtpTextField(
                      numberOfFields: 6,
                      borderColor: const Color(0xFF0CB502),
                      styles: otpTextStyles,
                      fieldWidth: 45,
                      //set to true to show as box or false to show as dash
                      showFieldAsBox: true,
                      //runs when a code is typed in
                      onCodeChanged: (String code) {
                        //handle validation or checks here
                        code = code;
                      },
                      //runs when every textfield is filled
                      onSubmit: (String verificationCode) async {
                        setState(() {
                          code = verificationCode;
                        });
                      }, // end onSubmit
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: CustomSignIn_UpOne(title: 'Verify',ontap: () async {
                    if (await verification.verifyOTP(otp: code) == true) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(const SnackBar(
                    content: Text("OTP is verified"),
                    ),);
                    } else {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(const SnackBar(
                    content: Text("Invalid OTP"),
                    ),);
                    }
                  },),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
