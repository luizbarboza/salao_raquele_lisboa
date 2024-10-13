import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import '../bloc/specialty.dart';
import '../bloc/specialty_event.dart';
import '../bloc/specialty_state.dart';
import '../model/specialty.dart';
import 'add_specialty.dart';

class SpecialtiesPage extends StatefulWidget {
  const SpecialtiesPage({super.key});

  @override
  SpecialtiesPageState createState() => SpecialtiesPageState();
}

class SpecialtiesPageState extends State<SpecialtiesPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Especialidades'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute<void>(
              builder: (BuildContext context) => const AddSpecialtyPage(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: BlocConsumer<SpecialtyBloc, SpecialtyState>(
        bloc: SpecialtyBloc()..add(SpecialtyFetch()),
        listener: (context, state) {
          if (state is SpecialtyError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          switch (state) {
            case SpecialtyFetching():
              return const Center(child: CircularProgressIndicator());
            case SpecialtyFetched():
              return SpecialtiesLisView(state.specialties);
            default:
              return Container();
          }
        },
      ),
    );
  }
}

class SpecialtiesLisView extends StatelessWidget {
  final List<Specialty> specialties;

  const SpecialtiesLisView(this.specialties, {super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 400),
        child: Column(
          children: [
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.all(8),
                itemCount: specialties.length,
                itemBuilder: (context, index) {
                  Specialty specialty = specialties[index];
                  return Card(
                    elevation: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text.rich(
                            TextSpan(
                              children: [
                                const WidgetSpan(
                                  child: Icon(
                                    Symbols.license,
                                    size: 20,
                                  ),
                                ),
                                TextSpan(
                                  text: " ${specialty.name}",
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          Text.rich(
                            TextSpan(
                              children: [
                                const WidgetSpan(
                                  child: Icon(
                                    Symbols.description,
                                    size: 20,
                                  ),
                                ),
                                TextSpan(
                                  text: " ${specialty.description}",
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) => const SizedBox(
                  height: 8,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
