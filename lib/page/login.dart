import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/auth.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';
import 'register.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthAuthenticated) {
            Navigator.pushReplacementNamed(context, '/home');
          } else if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return const Center(child: CircularProgressIndicator());
          }

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
                        children: [
                          const CircleAvatar(
                            radius: 60,
                            backgroundImage: NetworkImage(
                                'https://cdn-icons-png.flaticon.com/512/9993/9993258.png'),
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            'Entre na sua conta',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 30),
                          TextField(
                            controller: _emailController,
                            decoration: const InputDecoration(
                              labelText: 'E-mail',
                              hintText: 'Digite o seu e-mail',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(height: 15),
                          TextField(
                            controller: _passwordController,
                            decoration: const InputDecoration(
                              labelText: 'Senha',
                              hintText: 'Digite a sua senha',
                              border: OutlineInputBorder(),
                            ),
                            obscureText: true,
                          ),
                          const SizedBox(height: 15),
                          TextButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute<void>(
                                  builder: (BuildContext context) =>
                                      RegisterPage(),
                                ),
                              );
                            },
                            child: Text(
                              'Ainda não possui uma conta? Cadastre-se!',
                              style: TextStyle(
                                color: colorScheme.onSurface,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          const SizedBox(height: 20),
                          SizedBox(
                            width: double
                                .infinity, // O botão ocupará toda a largura disponível
                            child: FilledButton(
                              onPressed: () {
                                context.read<AuthBloc>().add(
                                      AuthSignInRequested(
                                        _emailController.text,
                                        _passwordController.text,
                                      ),
                                    );
                              },
                              child: const Text(
                                'Entrar',
                              ),
                            ),
                          ),
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
