part of 'forget_password_cubit.dart';

@immutable
abstract class ForgetPasswordState {}

class ForgetPasswordInitial extends ForgetPasswordState {}
class ForgetPassInitialized extends ForgetPasswordState {}
class ForgetPassFail extends ForgetPasswordState {}
