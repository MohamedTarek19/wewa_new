import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:wewa/app_brain/api_end_points.dart';
import 'package:woocommerce_api/woocommerce_api.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();

  bool obsecure = true;

  void visibiltyToggele(){
    obsecure = !obsecure;
    emit(toggle());
  }

  Future Login({String? email,String? pass}) async {
    // Initialize the API
    String mail = this.email.text;
    String password = this.password.text;
    try{
      emit(WewaLoginLoading());
      WooCommerceAPI wooCommerceAPI = WooCommerceAPI(
          url: baseurl,
          consumerKey: consumerKey,
          consumerSecret: consumerSecret);

      // Get data using the "products" endpoint
      var usersList = await wooCommerceAPI.getAsync("customers");
      emit(WewaLoginSuccess());
      for(var e in usersList){
        if(mail == e['email']){
          print(1);
          print(e);
        }
      }


      return usersList;
    }catch(e){
      print('didn\'t get: ${e}');
      emit(WewaLoginFail());
      return null;
    }

  }


}
