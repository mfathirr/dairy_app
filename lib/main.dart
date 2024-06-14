import 'package:dairy_app/data/datasources/auth_local_datasource.dart';
import 'package:dairy_app/data/datasources/auth_remote_datasource.dart';
import 'package:dairy_app/pages/home_page.dart';
import 'package:dairy_app/presentations/auth/login_page.dart';
import 'package:dairy_app/presentations/bloc/login/login_bloc.dart';
import 'package:dairy_app/presentations/bloc/logout/logout_bloc.dart';
import 'package:dairy_app/presentations/bloc/register/register_bloc.dart';
import 'package:dairy_app/presentations/notes/notes_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => RegisterBloc(AuthRemoteDatasource()),
          ),
          BlocProvider(
            create: (context) => LoginBloc(AuthRemoteDatasource()),
          ),
          BlocProvider(
            create: (context) => LogoutBloc(AuthRemoteDatasource()),
          ),
        ],
        child: MaterialApp(
          home: FutureBuilder<bool>(
            future: AuthLocalDatasource().isLogin(),
            builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Scaffold(
                    body: Center(child: CircularProgressIndicator()));
              }
              if (snapshot.connectionState == ConnectionState.done) {
                return snapshot.data! ? const NotesPage() : const LoginPage();
              }
              return const Scaffold(
                body: Center(
                  child: Text('Error'),
                ),
              );
            },
          ),
        ));
  }
}
