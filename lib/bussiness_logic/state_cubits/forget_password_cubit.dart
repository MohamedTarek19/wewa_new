import 'package:bloc/bloc.dart';
import 'package:email_otp/email_otp.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'forget_password_state.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  ForgetPasswordCubit() : super(ForgetPasswordInitial());
  EmailOTP verification = EmailOTP();
  String code = '';


  Future<void> SendEmail(String email)async{
    try{
      verification.setConfig(
        appEmail: "mohamedtarek20192001@gmail.com",
        appName:
        "Wewa Emial verification for password reset",
        userEmail: email,
        otpLength: 6,
        otpType: OTPType.digitsOnly,
      );
      emit(ForgetPassInitialized());
    }catch(e){
      emit(ForgetPassFail());
    }

  }
}
