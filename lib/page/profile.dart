import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import '../bloc/auth.dart';
import '../bloc/auth_state.dart';
import '../bloc/person.dart';
import '../bloc/person_event.dart';
import '../bloc/person_state.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final ImagePicker _imagePicker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is! AuthAuthenticated) return Container();
          final person = state.person;
          return BlocProvider(
            create: (context) => PersonBloc()
              ..add(PersonFetch(
                {"id": person.id},
              )),
            child: Center(
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
                                  BlocConsumer<PersonBloc, PersonState>(
                                      listener: (context, state) {
                                    if (state is PersonError) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(content: Text(state.message)),
                                      );
                                    } else if (state is PersonUpdated) {
                                      context
                                          .read<PersonBloc>()
                                          .add(PersonFetch(
                                            {"id": person.id},
                                          ));
                                    }
                                  }, builder: (context, state) {
                                    if (state is! PersonFetched) {
                                      return const CircleAvatar(
                                        radius: 60,
                                        backgroundImage: AssetImage(
                                          'assets/default_profile_picture.jpeg',
                                        ),
                                      );
                                    }
                                    return GestureDetector(
                                      onTap: () async {
                                        final pickedImage =
                                            await _imagePicker.pickImage(
                                          source: ImageSource.gallery,
                                        );
                                        if (pickedImage != null) {
                                          pickedImage.readAsBytes();
                                          context
                                              .read<PersonBloc>()
                                              .add(PersonUpdateAvatar(
                                                state.people[0].id,
                                                await pickedImage.readAsBytes(),
                                              ));
                                        }
                                      },
                                      child: CircleAvatar(
                                        radius: 60,
                                        backgroundImage: NetworkImage(
                                          state.people[0].avatar,
                                        ),
                                      ),
                                    );
                                  }),
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
            ),
          );
        },
      ),
    );
  }
}
