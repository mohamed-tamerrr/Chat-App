import 'package:chat/constants.dart';
import 'package:chat/cubits/register_cubit/register_cubit.dart';
import 'package:chat/screens/login_page.dart';
import 'package:chat/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegisterPage extends StatelessWidget {
  String? email;
  static String id = 'RegisterPage';
  String? password;

  GlobalKey<FormState> FormKey = GlobalKey();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if (state is RegisterLoading) {
          isLoading = true;
        } else if (state is RegisterSuccess) {
          Navigator.pushNamed(
            context,
            LoginPage.id,
            arguments: email,
          );
          isLoading = false;
        } else if (state is RegisterFailure) {
          showSnackBar(context, state.errMsg);
          isLoading = false;
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: isLoading,
          child: Scaffold(
            backgroundColor: kPrimaryColor,
            body: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 10.0,
              ),
              child: Form(
                key: FormKey,
                child: Column(
                  children: [
                    Image(
                      image: AssetImage(kLogo),
                      height: 150,
                    ),
                    Row(
                      mainAxisAlignment:
                          MainAxisAlignment.center,
                      children: [
                        Text(
                          'Scholar Chat',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Pacifico',
                          ),
                        ),
                      ],
                    ),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        'Sign Up',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 12),
                    CustomTextField(
                      hint: 'Email',
                      onChanged: (email) {
                        this.email = email;
                      },
                    ),
                    SizedBox(height: 16),
                    CustomTextField(
                      hint: 'Password',
                      obscure: true,
                      onChanged: (password) {
                        this.password = password;
                      },
                    ),
                    SizedBox(height: 16),
                    GestureDetector(
                      onTap: () async {
                        if (FormKey.currentState!
                            .validate()) {
                          BlocProvider.of<RegisterCubit>(
                            context,
                          ).Register(
                            email: email!,
                            password: password!,
                          );
                        } else {}
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(
                          20,
                        ),
                        child: Container(
                          width: double.infinity,
                          height: 50,
                          color: Colors.white,
                          child: Center(
                            child: Text(
                              'Sign Up',
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Text(
                          "Have already an account ?",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        GestureDetector(
                          onTap: () =>
                              Navigator.pop(context),
                          child: Text(
                            " Log in",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void ShowMsg(BuildContext context, {required Msg}) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('$Msg')));
  }
}
