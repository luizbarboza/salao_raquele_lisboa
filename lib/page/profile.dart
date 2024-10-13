import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../bloc/auth.dart';
import '../bloc/auth_state.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          final person = (state as AuthAuthenticated).person;
          return Center(
            child: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 400),
                  child: Card(
                    color: colorScheme.surfaceContainerLow,
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(25),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 400,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const CircleAvatar(
                                  radius: 60,
                                  backgroundImage: NetworkImage(
                                      'https://cdn-icons-png.flaticon.com/512/9993/9993258.png'),
                                ),
                                const SizedBox(height: 20),
                                Text(
                                  person.name,
                                  style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 30),
                          const Text(
                            "CPF",
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          const SizedBox(height: 1),
                          Text(person.cpf),
                          const SizedBox(height: 10),
                          const Text(
                            "Data de nascimento",
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          const SizedBox(height: 1),
                          Text(DateFormat('dd/MM/yyyy')
                              .format(person.birthDate)),
                          const SizedBox(height: 10),
                          const Text(
                            "Número de telefone",
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          const SizedBox(height: 1),
                          Text(person.phoneNumber),
                          const SizedBox(height: 10),
                          const Text(
                            "Endereço",
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          const SizedBox(height: 1),
                          Text(person.address),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
