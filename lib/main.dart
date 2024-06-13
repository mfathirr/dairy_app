import 'package:dairy_app/data/datasources/auth_remote_datasource.dart';
import 'package:dairy_app/presentations/auth/login_page.dart';
import 'package:dairy_app/presentations/bloc/register/register_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterBloc(AuthRemoteDatasource()),
      child: const MaterialApp(
        title: 'Flutter Demo',
        home: LoginPage(),
      ),
    );
  }
}
