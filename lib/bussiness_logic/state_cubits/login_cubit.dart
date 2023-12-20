import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:meta/meta.dart';
import 'package:wewa/app_brain/api_end_points.dart';
import 'package:woocommerce_api/woocommerce_api.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:convert';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  bool rememberflag = false;
  FlutterSecureStorage storage = FlutterSecureStorage();
  String token = 'email';
  bool obsecure = true;

  void visibiltyToggele(){
    obsecure = !obsecure;
    emit(toggle());
  }
  rememberMe(var res)async{
    String data = res['user_email'] +'/'+
        res['user_nicename']+'/'+res['roles'].join();
    print(data);
    await storage.write(key: token, value: data);
  }


  void reset(){
    email = TextEditingController();
    password = TextEditingController();
    confirmPassword = TextEditingController();
  }
  Future Login({String? email,String? pass}) async {
    // Initialize the API
    String mail = this.email.text;
    String passwrd = this.password.text;
    try{
      emit(WewaLoginLoading());
      WooCommerceAPI wooCommerceAPI = WooCommerceAPI(
          url: baseurl,
          consumerKey: consumerKey,
          consumerSecret: consumerSecret);

      // Get data using the "customers" endpoint
      var usersList = await wooCommerceAPI.getAsync("customers");
      print(usersList.last['password']);
      emit(WewaLoginSuccess());
      bool flag = true;
      for(var e in usersList){
        if(mail == e['email'] ){
          print(1);
          print(e);
          flag = false;
        }
      }
      if(flag){
        return null;
      }
      return usersList;
    }catch(e){
      print('didn\'t get: ${e}');
      emit(WewaLoginFail());
      return null;
    }

  }


  Future NewLogin({String? email,String? pass}) async {
    // Initialize the API
    String mail = this.email.text;
    String passwrd = this.password.text;
    var credentials = {
      'username': mail,
      'password': passwrd
    };
    var headers = {'Content-Type': 'application/x-www-form-urlencoded'};
    emit(WewaLoginLoading());
    var url=Uri.parse("https://wewatea.com/wp-json/jwt-auth/v1/token");
    try{
      var response = await http.post(url, body: credentials, headers:headers);
      print(jsonDecode(response.body)['token']);
      emit(WewaLoginSuccess());
      return jsonDecode(response.body);
    }catch(e){
      emit(WewaLoginFail());
      return null;
    }


  }


}
