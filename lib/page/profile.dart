import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/auth.dart';
import '../bloc/auth_state.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AuthAuthenticated) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Bem-vindo!'),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/agendamentos');
                    },
                    child: const Text('Ver Agendamentos'),
                  ),
                ],
              ),
            );
          }
          return const Center(child: Text('Carregando perfil...'));
        },
      ),
    );
  }
}
