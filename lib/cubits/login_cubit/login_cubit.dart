import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  loginUser({
    required String email,
    required String password,
  }) async {
    emit(LoginLoading());
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
            email: email,
            password: password,
          );
      emit(LoginSuccess());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        emit(LoginFailure('No user found for that email.'));
      } else if (e.code == 'wrong-password') {
        emit(LoginFailure('Wrong password provided.'));
      } else if (e.code == 'invalid-email') {
        emit(
          LoginFailure('The email address is not valid.'),
        );
      } else if (e.code == 'invalid-credential') {
        emit(LoginFailure('Incorrect email or password.'));
      } else if (e.code == 'too-many-requests') {
        emit(
          LoginFailure(
            'Too many failed attempts. Please try again later.',
          ),
        );
      } else if (e.code == 'network-request-failed') {
        emit(
          LoginFailure(
            'Network error. Please check your internet connection.',
          ),
        );
      } else {
        emit(
          LoginFailure(
            'Login failed: ${e.message ?? 'Unknown error'}',
          ),
        );
      }
    }
  }
}


// try {
//                           isLoading = true;

//                           Navigator.pushNamed(
//                             context,
//                             HomePage.id,
//                             arguments: email,
//                           );
//                         } 