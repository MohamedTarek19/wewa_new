import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit() : super(SignupInitial());
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  TextEditingController phone = TextEditingController();
  List<Map<String,String>>? countries = [{'+20':'assets/images/Icons/egypt.svg'}];
  Map<String,String>? value;

  bool obsecure = true;

  void addval(){
    value = countries?.first;
    print(countries?.length);
    emit(toggle());
  }
  void visibiltyToggele(){
    obsecure = !obsecure;
    emit(toggle());
  }



}
