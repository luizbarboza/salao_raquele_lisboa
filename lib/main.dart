import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:sala_raquele_lisboa/bloc/auth_event.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide AuthState;

import 'bloc/appointment.dart';
import 'bloc/auth.dart';
import 'bloc/auth_state.dart';
import 'page/home.dart';
import 'page/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://ufhvdhccnprpcfsfhooq.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InVmaHZkaGNjbnBycGNmc2Zob29xIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MjYzMjY1NTksImV4cCI6MjA0MTkwMjU1OX0.w8_JHe0KqL9X52T6-SQeCuaukBgqWwCxBLovKZOZqN4',
  );

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc()..add(AuthCheckRequested()),
        ),
        BlocProvider<AppointmentBloc>(
          create: (context) => AppointmentBloc(),
        ),
      ],
      child: MaterialApp(
        title: 'App de Salão',
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('pt', 'BR'),
        ],
        initialRoute: '/login',
        routes: {
          '/login': (context) => LoginPage(),
          '/home': (context) {
            return BlocListener<AuthBloc, AuthState>(
              listener: (context, state) {
                switch (state) {
                  case AuthUnauthenticated _:
                    Navigator.of(context).pushReplacementNamed('/login');
                }
              },
              child: const HomePage(),
            );
          }
        },
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.pink,
              brightness: MediaQuery.of(context).platformBrightness),
        ),
      ),
    );
  }
}
