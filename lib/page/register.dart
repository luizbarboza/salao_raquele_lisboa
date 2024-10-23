import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../bloc/auth.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';
import 'login.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // User
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Personal information
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _cpfController = TextEditingController();
  final TextEditingController _birthDateController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();

  // Address
  final TextEditingController _cepController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _municipalityController = TextEditingController();
  final TextEditingController _neighborhoodController = TextEditingController();
  final TextEditingController _publicPlaceController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();
  final TextEditingController _complementController = TextEditingController();

  DateTime? _pickedDate;

  Future<void> _selectDate(BuildContext context) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      setState(() {
        _pickedDate = pickedDate;
        _birthDateController.text = DateFormat('dd/MM/yyyy').format(pickedDate);
      });
    }
  }

  String _formatPhoneNumber(String value) {
    value = value.replaceAll(RegExp(r'\D'), '');
    if (value.length <= 2) return value;
    if (value.length <= 6) {
      return '(${value.substring(0, 2)}) ${value.substring(2)}';
    }
    if (value.length <= 10) {
      return '(${value.substring(0, 2)}) ${value.substring(2, 6)}-${value.substring(6)}';
    }
    return '(${value.substring(0, 2)}) ${value.substring(2, 7)}-${value.substring(7, 11)}';
  }

  String _formatCpf(String value) {
    value = value.replaceAll(RegExp(r'\D'), '');
    if (value.length <= 3) return value;
    if (value.length <= 6) {
      return '${value.substring(0, 3)}.${value.substring(3)}';
    }
    if (value.length <= 9) {
      return '${value.substring(0, 3)}.${value.substring(3, 6)}.${value.substring(6)}';
    }
    return '${value.substring(0, 3)}.${value.substring(3, 6)}.${value.substring(6, 9)}-${value.substring(9, 11)}';
  }

  String _formatCep(String value) {
    value = value.replaceAll(RegExp(r'\D'), '');
    if (value.length <= 5) return value;
    return '${value.substring(0, 5)}-${value.substring(5, 8)}';
  }

  final _formKeys = [
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
  ];

  var _activeStep = 0;

  List<Step> _steps() {
    return [
      Step(
        state: _activeStep <= 0 ? StepState.editing : StepState.complete,
        isActive: _activeStep >= 0,
        title: const Text('Usuário'),
        content: Form(
          key: _formKeys[0],
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                height: 5,
              ),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  isDense: true,
                  border: OutlineInputBorder(),
                  labelText: 'Email',
                ),
                validator: (text) {
                  return text != null &&
                          RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                              .hasMatch(text)
                      ? null
                      : "Informe um email válido";
                },
              ),
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                obscureText: true,
                controller: _passwordController,
                decoration: const InputDecoration(
                  isDense: true,
                  border: OutlineInputBorder(),
                  labelText: 'Senha',
                ),
                validator: (text) {
                  return text != null &&
                          RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,}$')
                              .hasMatch(text)
                      ? null
                      : "Informe uma senha forte";
                },
              ),
            ],
          ),
        ),
      ),
      Step(
        state: _activeStep <= 1 ? StepState.editing : StepState.complete,
        isActive: _activeStep >= 1,
        title: const Text('Informações pessoais'),
        content: Form(
          key: _formKeys[1],
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                height: 5,
              ),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  isDense: true,
                  border: OutlineInputBorder(),
                  labelText: 'Nome',
                ),
                validator: (text) {
                  return text != null && text.isNotEmpty
                      ? null
                      : "Informe o nome";
                },
              ),
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: _cpfController,
                decoration: const InputDecoration(
                  isDense: true,
                  border: OutlineInputBorder(),
                  labelText: 'CPF',
                ),
                validator: (text) {
                  return text != null &&
                          RegExp(r'(^\d{3}\.\d{3}\.\d{3}\-\d{2}$)')
                              .hasMatch(text)
                      ? null
                      : "Informe um CPF válido";
                },
              ),
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: _birthDateController,
                decoration: const InputDecoration(
                  isDense: true,
                  border: OutlineInputBorder(),
                  labelText: 'Data de nascimento',
                ),
                validator: (text) {
                  return null;
                },
                readOnly: true,
                onTap: () => _selectDate(context),
              ),
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: _phoneNumberController,
                decoration: const InputDecoration(
                  isDense: true,
                  border: OutlineInputBorder(),
                  labelText: 'Número de telefone',
                ),
                validator: (text) {
                  return text != null && text.isNotEmpty
                      ? null
                      : "Informe o número de telefone";
                },
              ),
            ],
          ),
        ),
      ),
      Step(
        state: _activeStep <= 2 ? StepState.editing : StepState.complete,
        isActive: _activeStep >= 2,
        title: const Text('Endereço'),
        content: Form(
          key: _formKeys[2],
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                height: 5,
              ),
              TextFormField(
                controller: _cepController,
                decoration: const InputDecoration(
                  isDense: true,
                  border: OutlineInputBorder(),
                  labelText: 'CEP',
                ),
                validator: (text) {
                  return text != null &&
                          RegExp(r'(^[0-9]{5})-?([0-9]{3}$)').hasMatch(text)
                      ? null
                      : "Informe um CEP válido";
                },
              ),
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: _stateController,
                decoration: const InputDecoration(
                  isDense: true,
                  border: OutlineInputBorder(),
                  labelText: 'Estado',
                ),
                validator: (text) {
                  return text != null && text.isNotEmpty
                      ? null
                      : "Informe o estado";
                },
              ),
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: _municipalityController,
                decoration: const InputDecoration(
                  isDense: true,
                  border: OutlineInputBorder(),
                  labelText: 'Município',
                ),
                validator: (text) {
                  return text != null && text.isNotEmpty
                      ? null
                      : "Informe o município";
                },
              ),
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: _neighborhoodController,
                decoration: const InputDecoration(
                  isDense: true,
                  border: OutlineInputBorder(),
                  labelText: 'Bairro',
                ),
                validator: (text) {
                  return text != null && text.isNotEmpty
                      ? null
                      : "Informe o bairro";
                },
              ),
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: _publicPlaceController,
                decoration: const InputDecoration(
                  isDense: true,
                  border: OutlineInputBorder(),
                  labelText: 'Logradouro',
                ),
                validator: (text) {
                  return text != null && text.isNotEmpty
                      ? null
                      : "Informe o logradouro";
                },
              ),
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: _numberController,
                decoration: const InputDecoration(
                  isDense: true,
                  border: OutlineInputBorder(),
                  labelText: 'Número',
                ),
                validator: (text) {
                  return text != null && text.isNotEmpty
                      ? null
                      : "Informe o número";
                },
              ),
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: _complementController,
                decoration: const InputDecoration(
                  isDense: true,
                  border: OutlineInputBorder(),
                  labelText: 'Complemento',
                ),
                validator: (text) {
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
    ];
  }

  @override
  void initState() {
    super.initState();
    _phoneNumberController.addListener(() {
      final text = _phoneNumberController.text;
      final formattedText = _formatPhoneNumber(text);
      _phoneNumberController.value = _phoneNumberController.value.copyWith(
        text: formattedText,
        selection: TextSelection.collapsed(
          offset: formattedText.length,
        ),
      );
    });
    _cpfController.addListener(() {
      final text = _cpfController.text;
      final formattedText = _formatCpf(text);
      _cpfController.value = _cpfController.value.copyWith(
        text: formattedText,
        selection: TextSelection.collapsed(offset: formattedText.length),
      );
    });
    _cepController.addListener(() {
      final text = _cepController.text;
      final formattedText = _formatCep(text);
      _cepController.value = _cepController.value.copyWith(
        text: formattedText,
        selection: TextSelection.collapsed(offset: formattedText.length),
      );
    });
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
                            'Faça o seu cadastro',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 30),
                          Stepper(
                            type: StepperType.vertical,
                            currentStep: _activeStep,
                            steps: _steps(),
                            onStepContinue: () {
                              if (_formKeys[_activeStep]
                                  .currentState!
                                  .validate()) {
                                if (_activeStep < (_steps().length - 1)) {
                                  setState(() {
                                    _activeStep += 1;
                                  });
                                } else {
                                  setState(() {
                                    context.read<AuthBloc>().add(
                                          AuthSignUpRequested(
                                            email: _emailController.text,
                                            password: _passwordController.text,
                                            name: _nameController.text,
                                            cpf: _cpfController.text,
                                            birthDate: DateFormat('yyyy-MM-dd')
                                                .format(_pickedDate!),
                                            phoneNumber:
                                                _phoneNumberController.text,
                                            cep: _cepController.text,
                                            state: _stateController.text,
                                            municipality:
                                                _municipalityController.text,
                                            neighborhood:
                                                _neighborhoodController.text,
                                            publicPlace:
                                                _publicPlaceController.text,
                                            number: _numberController.text,
                                            complement:
                                                _complementController.text,
                                          ),
                                        );
                                  });
                                }
                              }
                            },
                            onStepCancel: () {
                              if (_activeStep == 0) {
                                return;
                              }

                              setState(() {
                                _activeStep -= 1;
                              });
                            },
                            onStepTapped: (int index) {
                              return;
                            },
                          ),
                          const SizedBox(height: 15),
                          TextButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute<void>(
                                  builder: (BuildContext context) =>
                                      const LoginPage(),
                                ),
                              );
                            },
                            child: Text(
                              'Já possui uma conta? Entre!',
                              style: TextStyle(
                                color: colorScheme.onSurface,
                              ),
                              textAlign: TextAlign.center,
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
