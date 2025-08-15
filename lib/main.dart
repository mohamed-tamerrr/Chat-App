import 'package:chat/cubits/login_cubit/login_cubit.dart';
import 'package:chat/cubits/register_cubit/register_cubit.dart';
import 'package:chat/firebase_options.dart';
import 'package:chat/screens/home_page.dart';
import 'package:chat/screens/login_page.dart';
import 'package:chat/screens/register_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(ChatApp());
}

class ChatApp extends StatelessWidget {
  const ChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LoginCubit()),
        BlocProvider(create: (context) => RegisterCubit()),
      ],
      child: MaterialApp(
        routes: {
          LoginPage.id: (context) => LoginPage(),
          RegisterPage.id: (context) => RegisterPage(),
          HomePage.id: (context) => HomePage(),
        },
        debugShowCheckedModeBanner: false,
        home: LoginPage(),
      ),
    );
  }
}
