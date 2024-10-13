import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:sala_raquele_lisboa/bloc/auth_state.dart';
import 'package:sala_raquele_lisboa/page/specialties.dart';

import '../bloc/auth.dart';
import 'appointments.dart';
import 'profile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  int _currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final person = (context.read<AuthBloc>().state as AuthAuthenticated).person;
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            _currentPageIndex = index;
          });
        },
        selectedIndex: _currentPageIndex,
        destinations: <Widget>[
          const NavigationDestination(
            icon: Icon(Icons.person_outlined),
            selectedIcon: Icon(Icons.person),
            label: 'Perfil',
          ),
          const NavigationDestination(
            icon: Icon(Icons.calendar_today_outlined),
            selectedIcon: Icon(Icons.calendar_today),
            label: 'Agendamentos',
          ),
          if (person.role == "colaborador")
            const NavigationDestination(
              icon: Icon(Symbols.license),
              selectedIcon: Icon(
                Symbols.license,
                fill: 1,
              ),
              label: 'Especialidades',
            ),
        ],
      ),
      body: [
        const ProfilePage(),
        const AppointmentsPage(),
        if (person.role == "colaborador") const SpecialtiesPage(),
      ][_currentPageIndex],
    );
  }
}
