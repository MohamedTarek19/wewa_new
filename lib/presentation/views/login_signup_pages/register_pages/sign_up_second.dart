import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wewa/presentation/widgets/custom_phone_field.dart';
import 'package:wewa/presentation/widgets/custom_signin_signup.dart';

import '../../../../bussiness_logic/state_cubits/signup_cubit.dart';

class SignupSecondScreen extends StatelessWidget {
  const SignupSecondScreen({Key? key}) : super(key: key);
  static final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double actualHeight = (1 - (150 / MediaQuery.sizeOf(context).height)) *
        MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 90,
        scrolledUnderElevation: 0.0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            //color: Colors.blue,
            height: actualHeight,
            width: MediaQuery.sizeOf(context).width,
            margin: const EdgeInsets.only(left: 20, right: 20),
            //color: Colors.red,
            child: Column(
              children: [
                Container(
                  //color: Colors.red,
                  margin: EdgeInsets.only(bottom: actualHeight * 0.1),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Verify Phone Number',
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'One step closer to deliciousness! Verify your phone.',
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                BlocBuilder<SignupCubit, SignupState>(
                  builder: (context, state) {

                    return Form(
                      key: formKey,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 15.0),
                            child: CustomPhoneFormField(
                              title: 'Phone Number',
                              HintText: 'xxx xxx xxxx',
                              validation: (String? value) {
                                if (value == null || value.isEmpty == true) {
                                  return 'please enter your phone number';
                                } else if (int.tryParse(value) == null) {
                                  return "your name shouldn't contain Characters";
                                } else if (value.length != 11) {
                                  return "your phone number should be 11 digits";
                                } else if ((value[0] != '0' && value[1] != '1') &&
                                    (value[2] != '0' ||
                                        value[2] != '1' ||
                                        value[2] != '2' ||
                                        value[2] != '5')) {
                                  return 'Invalid phone number\n{your phone first two digits\nshould start with \'01\' and\nthe third digit is either 0,1,2, or 5}';
                                }
                                return null;
                              },
                              controller: context.read<SignupCubit>().phone,
                              val: context.read<SignupCubit>().value??{},
                              list: context.read<SignupCubit>().countries,
                            ),
                          ),
                          CustomSignIn_UpOne(
                                title: 'Send Code',
                                ontap: () async {
                                  if (formKey.currentState!.validate()) {
                                    await context.read<SignupCubit>().CreateAccount();
                                  }
                                },
                              ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
