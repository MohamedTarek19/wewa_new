part of 'login_cubit.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

class toggle extends LoginState {}

class WewaLoginLoading extends LoginState {}
class WewaLoginSuccess extends LoginState {}
class WewaLoginFail extends LoginState {}
