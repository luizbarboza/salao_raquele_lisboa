import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sala_raquele_lisboa/bloc/auth_event.dart';
import '../bloc/auth.dart';
import '../bloc/auth_state.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<AuthBloc>().add(AuthSignOutRequested());
        },
        child: const Icon(Icons.logout),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Bem-vindo!'),
            ElevatedButton(
              onPressed: () {
                //Navigator.pushNamed(context, '/agendamentos');
              },
              child: const Text('Ver Agendamentos'),
            ),
          ],
        ),
      ),
    );
  }
}
