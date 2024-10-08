import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/auth.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';

class RegisterPage extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _cpfController = TextEditingController();
  final TextEditingController _cellController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthAuthenticated) {
            Navigator.pushReplacementNamed(context, '/profile');
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

          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            color: const Color(0xFFF7F7F7), // Fundo da página
            child: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'Faça o seu cadastro',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Card(
                        elevation: 5,
                        color: Colors.white, // Cor do fundo do card
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: const BorderSide(color: Color(0xFFBDBDBD)), // Borda cinza
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(25.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              _buildTextField(
                                controller: _nameController,
                                label: 'Nome',
                                hint: 'Digite o seu nome',
                              ),
                              const SizedBox(height: 15),
                              _buildTextField(
                                controller: _cpfController,
                                label: 'CPF',
                                hint: 'Digite seu CPF',
                              ),
                              const SizedBox(height: 15),
                              _buildTextField(
                                controller: _cellController,
                                label: 'Celular',
                                hint: '(DDD) Celular',
                              ),
                              const SizedBox(height: 15),
                              _buildTextField(
                                controller: _emailController,
                                label: 'E-mail',
                                hint: 'exemplo@gmail.com',
                              ),
                              const SizedBox(height: 15),
                              _buildTextField(
                                controller: _passwordController,
                                label: 'Senha',
                                hint: 'Digite a sua senha',
                                obscureText: true,
                              ),
                              const SizedBox(height: 20),
                              TextButton(
                                style: TextButton.styleFrom(
                                  foregroundColor: Colors.blue, // Cor do texto do botão
                                ),
                                onPressed: () {
                                  Navigator.pushReplacementNamed(context, '/login');
                                },
                                child: const Text('Já tem um login? Clique aqui'),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity, // O botão ocupará toda a largura
                        child: FilledButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(const Color(0xFF212121)), // Cor quase preta
                            padding: MaterialStateProperty.all(const EdgeInsets.symmetric(vertical: 15)),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          onPressed: () {
                            context.read<AuthBloc>().add(
                              SignUpRequested(
                                name: _nameController.text,
                                cpf: _cpfController.text,
                                cell: _cellController.text,
                                email: _emailController.text,
                                password: _passwordController.text,
                              ),
                            );
                          },
                          child: const Text(
                            'Cadastrar',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTextField({required TextEditingController controller, required String label, required String hint, bool obscureText = false}) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Color(0xFFBDBDBD)), // Borda cinza dos campos
        ),
        filled: true,
        fillColor: Colors.white, // Fundo do campo
      ),
      obscureText: obscureText,
    );
  }
}
