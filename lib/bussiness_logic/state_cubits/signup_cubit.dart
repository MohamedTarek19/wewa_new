import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:wewa/app_brain/api_end_points.dart';
import 'package:woocommerce_api/woocommerce_api.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit() : super(SignupInitial());
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  TextEditingController phone = TextEditingController();
  List<Map<String,String>>? countries = [{'+20':'assets/images/Icons/egypt.svg'}];
  Map<String,String>? value;

  bool obsecure = true;

  void reset(){
    name = TextEditingController();
    email = TextEditingController();
    password = TextEditingController();
    confirmPassword = TextEditingController();
    phone = TextEditingController();
  }
  void addval(){
    value = countries?.first;
    //print(countries?.length);
    emit(toggle());
  }
  void visibiltyToggele(){
    obsecure = !obsecure;
    emit(toggle());
  }
  Future CreateAccount({String? name,String? email,String? pass,String? phone,required BuildContext context}) async {
    // Initialize the API
    name = this.name.text;
    email = this.email.text;
    pass = this.password.text;
    phone = '+20 '+this.phone.text;

    List<String> names = name.split(' ');
    Map<dynamic,dynamic> data = {
      "email": "$email",
      "first_name": "${names[0]}",
      "last_name": "${names[1]}",
      "password": "$pass",
      "username": "$name",
      "billing": {
        "first_name": "${names[0]}",
        "last_name": "${names[1]}",
        "company": "",
        "address_1": "",
        "address_2": "",
        "city": "",
        "state": "",
        "postcode": "",
        "country": "",
        "email": "$email",
        "phone": "$phone"
      },
      "shipping": {
        "first_name": "${names[0]}",
        "last_name": "${names[1]}",
        "company": "",
        "address_1": "",
        "address_2": "",
        "city": "",
        "state": "",
        "postcode": "",
        "country": ""
      }
    };
    try{
      emit(WewaSignUpLoading());
      WooCommerceAPI wooCommerceAPI = WooCommerceAPI(
          url: baseurl,
          consumerKey: consumerKey,
          consumerSecret: consumerSecret);

      var signUp = await wooCommerceAPI.postAsync("customers",data);
      emit(WewaSignUpSuccess());
      print(signUp['message'] !=null? null: signUp);
      return signUp['message'] !=null? null: signUp;
    }catch(e){
      //print('didn\'t get: ${e}');
      emit(WewaSignUpFail());
      return null;
    }

  }



}
