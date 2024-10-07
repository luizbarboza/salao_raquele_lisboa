import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'bloc/appointment.dart';
import 'bloc/auth.dart';
import 'page/appointments.dart';
import 'page/home.dart';
import 'page/login.dart';
import 'page/new_appointment.dart';
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
        BlocProvider<AppointmentBloc>(
          create: (context) => AppointmentBloc(),
        ),
      ],
      child: MaterialApp(
        title: 'App de Salão',
        initialRoute: '/login',
        routes: {
          '/': (context) => const HomePage(),
          '/login': (context) => LoginPage(),
          '/register': (context) => RegisterPage(),
          '/profile': (context) => const ProfilePage(),
          '/appointments': (context) => const AppointmentsPage(),
          '/new_appointment': (context) => const NewAppointmentPage(),
        },
      ),
    );
  }
}
