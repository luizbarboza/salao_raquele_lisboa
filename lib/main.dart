import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'bloc/agendamento.dart';
import 'bloc/auth.dart';
import 'page/agendamento.dart';
import 'page/home.dart';
import 'page/login.dart';
import 'page/profile.dart';
import 'page/register.dart';

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
          create: (context) => AuthBloc(),
        ),
        BlocProvider<AgendamentoBloc>(
          create: (context) => AgendamentoBloc(),
        ),
      ],
      child: MaterialApp(
        title: 'App de Salão',
        initialRoute: '/login',
        routes: {
          '/': (context) => HomePage(),
          '/login': (context) => LoginPage(),
          '/register': (context) => RegisterPage(),
          '/profile': (context) => const ProfilePage(),
          '/agendamentos': (context) => const AgendamentoPage(),
        },
      ),
    );
  }
}
