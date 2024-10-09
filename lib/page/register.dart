import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../bloc/auth.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';

class RegisterPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _cpfController = TextEditingController();
  final TextEditingController _birthDateController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();

  DateTime? _pickedDate;

  RegisterPage({super.key});

  Future<void> _selectDate(BuildContext context) async {
    _pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (_pickedDate != null) {
      _birthDateController.text = DateFormat('dd/MM/yyyy').format(_pickedDate!);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthAuthenticated) {
            Navigator.pushReplacementNamed(context, '/');
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

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 400),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CircleAvatar(
                        radius: 60,
                        backgroundImage: NetworkImage(
                            'https://cdn-icons-png.flaticon.com/512/9993/9993258.png'),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Faça o seu cadastro',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 30),
                      Card(
                        color: colorScheme.surfaceContainerLow,
                        elevation: 5,
                        child: Padding(
                          padding: const EdgeInsets.all(25),
                          child: Column(
                            children: [
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
                              const SizedBox(height: 15),
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
                              TextField(
                                controller: _birthDateController,
                                decoration: InputDecoration(
                                  labelText: 'Data de nascimento',
                                  hintText:
                                      'Selecione a sua data de nascimento',
                                  suffixIcon: IconButton(
                                    icon: const Icon(Icons.calendar_today),
                                    onPressed: () => _selectDate(context),
                                  ),
                                  border: const OutlineInputBorder(),
                                ),
                                readOnly: true,
                                onTap: () => _selectDate(context),
                              ),
                              const SizedBox(height: 15),
                              _buildTextField(
                                controller: _addressController,
                                label: 'Endereço',
                                hint: 'Digite o seu endereço',
                              ),
                              const SizedBox(height: 15),
                              _buildTextField(
                                controller: _phoneNumberController,
                                label: 'Número de telefone',
                                hint: '(DDD) Telefone',
                              ),
                              const SizedBox(height: 15),
                              TextButton(
                                onPressed: () {
                                  Navigator.pushReplacementNamed(
                                      context, '/login');
                                },
                                child: Text(
                                  'Já possui uma conta? Entre!',
                                  style: TextStyle(
                                    color: colorScheme.onSurface,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width:
                            double.infinity, // O botão ocupará toda a largura
                        child: FilledButton(
                          onPressed: () {
                            context.read<AuthBloc>().add(
                                  SignUpRequested(
                                    email: _emailController.text,
                                    password: _passwordController.text,
                                    name: _nameController.text,
                                    cpf: _cpfController.text,
                                    birthDate: DateFormat('yyyy-MM-dd')
                                        .format(_pickedDate!),
                                    address: _addressController.text,
                                    phoneNumber: _phoneNumberController.text,
                                  ),
                                );
                          },
                          child: const Text(
                            'Cadastrar',
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

  Widget _buildTextField(
      {required TextEditingController controller,
      required String label,
      required String hint,
      bool obscureText = false}) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        border: const OutlineInputBorder(),
      ),
      obscureText: obscureText,
    );
  }
}
