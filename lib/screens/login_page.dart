import 'package:chat/constants.dart';
import 'package:chat/cubits/login_cubit/login_cubit.dart';
import 'package:chat/screens/home_page.dart';
import 'package:chat/screens/register_page.dart';
import 'package:chat/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginPage extends StatelessWidget {
  String? email;
  static String id = 'LoginPage';
  String? password;

  GlobalKey<FormState> FormKey = GlobalKey();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginLoading) {
          isLoading = true;
        } else if (state is LoginSuccess) {
          Navigator.pushNamed(
            context,
            HomePage.id,
            arguments: email,
          );
          isLoading = false;
        } else if (state is LoginFailure) {
          showSnackBar(context, state.errMsg);
          isLoading = false;
        }
      },
      builder: (context, state) => ModalProgressHUD(
        inAsyncCall: isLoading,
        child: Scaffold(
          backgroundColor: kPrimaryColor,
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
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
                      'Log in',
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
                    onChanged: (p0) {
                      email = p0;
                    },
                  ),
                  SizedBox(height: 16),
                  CustomTextField(
                    hint: 'Password',
                    onChanged: (p0) {
                      password = p0;
                    },
                    obscure: true,
                  ),
                  SizedBox(height: 16),
                  GestureDetector(
                    onTap: () async {
                      if (FormKey.currentState!
                          .validate()) {
                        BlocProvider.of<LoginCubit>(
                          context,
                        ).loginUser(
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
                            'Log in',
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Text(
                        "Don't have an account ?",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.pushNamed(
                          context,
                          RegisterPage.id,
                        ),
                        child: Text(
                          " Sign Up",
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
      ),
    );
  }
}

void showSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(
    context,
  ).showSnackBar(SnackBar(content: Text(message)));
}
