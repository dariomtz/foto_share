import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:foto_share/auth/bloc/auth_bloc.dart';
import 'package:foto_share/content/agregar/bloc/agregar_bloc.dart';
import 'package:foto_share/content/espera/bloc/pending_bloc.dart';
import 'package:foto_share/content/feed/bloc/feed_bloc.dart';
import 'package:foto_share/content/mi_contenido/bloc/micontenido_bloc.dart';
import 'package:foto_share/home/home_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'login/login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc()..add(VerifyAuthEvent()),
        ),
        BlocProvider(
          create: (context) => PendingBloc()..add(GetAllMyDisabledFotosEvent()),
        ),
        BlocProvider(
          create: (context) =>
              MicontenidoBloc()..add(GetAllMyPublicFotosEvent()),
        ),
        BlocProvider(create: ((context) => FeedBloc()..add(GetMyFeedEvent()))),
        BlocProvider(
          create: (context) => AgregarBloc(),
        )
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.purple,
        ),
        primaryColor: Colors.purple,
      ),
      home: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Favor de autenticarse"),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is AuthSuccessState) {
            return HomePage();
          } else if (state is UnAuthState ||
              state is AuthErrorState ||
              state is SignOutSuccessState) {
            return LoginPage();
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
