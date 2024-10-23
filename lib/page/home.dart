import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

import '../bloc/auth.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';
import '../components/adaptative_scaffold.dart';
import 'add_specialist.dart';
import 'add_specialty.dart';
import 'appointments.dart';
import 'new_appointment.dart';
import 'profile.dart';
import 'specialists.dart';
import 'specialties.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final authBloc = context.read<AuthBloc>();
    final person = (authBloc.state as AuthAuthenticated).person;
    return AdaptativeScaffold(
      destinations: [
        AdaptativeScaffoldDestination(
          label: "Perfil",
          iconData: Symbols.person,
          fab: AdaptativeScaffoldDestinationFab(
            label: "Sair",
            iconData: Symbols.logout,
            onPressed: () => authBloc.add(AuthSignOutRequested()),
          ),
          body: const ProfilePage(),
        ),
        AdaptativeScaffoldDestination(
          label: "Agendamentos",
          iconData: Symbols.calendar_today,
          fab: AdaptativeScaffoldDestinationFab(
            label: "Novo",
            iconData: Symbols.add,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => const NewAppointmentPage(),
                ),
              );
            },
          ),
          body: const AppointmentsPage(),
        ),
        if (person.role == "administrador") ...[
          AdaptativeScaffoldDestination(
            label: "Especialidades",
            iconData: Symbols.license,
            fab: AdaptativeScaffoldDestinationFab(
              label: "Adicionar",
              iconData: Symbols.add,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => const AddSpecialtyPage(),
                  ),
                );
              },
            ),
            body: const SpecialtiesPage(),
          ),
          AdaptativeScaffoldDestination(
            label: "Especialistas",
            iconData: Symbols.person_apron,
            fab: AdaptativeScaffoldDestinationFab(
              label: "Adicionar",
              iconData: Symbols.add,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) =>
                        const AddSpecialistPage(),
                  ),
                );
              },
            ),
            body: const SpecialistsPage(),
          ),
        ],
      ],
    );
  }
}
