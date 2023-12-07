part of 'signup_cubit.dart';

@immutable
abstract class SignupState {}

class SignupInitial extends SignupState {}

class toggle extends SignupState{}


class WewaSignUpLoading extends SignupState{}
class WewaSignUpSuccess extends SignupState{}
class WewaSignUpFail extends SignupState{}
