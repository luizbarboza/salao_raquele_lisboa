import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import '../bloc/specialist.dart';
import '../bloc/specialist_event.dart';
import '../bloc/specialist_state.dart';
import '../model/specialist.dart';

class SpecialistsPage extends StatefulWidget {
  const SpecialistsPage({super.key});

  @override
  SpecialistsPageState createState() => SpecialistsPageState();
}

class SpecialistsPageState extends State<SpecialistsPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => SpecialistBloc()..add(SpecialistFetch()),
        child: BlocConsumer<SpecialistBloc, SpecialistState>(
          listener: (context, state) {
            if (state is SpecialistError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            } else if (state is SpecialistDeleted) {
              context.read<SpecialistBloc>().add(SpecialistFetch());
            }
          },
          builder: (context, state) {
            switch (state) {
              case SpecialistFetching():
                return const Center(child: CircularProgressIndicator());
              case SpecialistFetched():
                return SpecialistsListView(state.specialists);
              default:
                return Container();
            }
          },
        ),
      ),
    );
  }
}

class SpecialistsListView extends StatelessWidget {
  final List<Specialist> specialists;

  const SpecialistsListView(this.specialists, {super.key});

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
                itemCount: specialists.length,
                itemBuilder: (context, index) {
                  Specialist specialist = specialists[index];
                  return Card(
                    elevation: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
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
                                        text: " ${specialist.specialty.name}",
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
                                          Symbols.person_apron,
                                          size: 20,
                                        ),
                                      ),
                                      TextSpan(
                                        text: " ${specialist.person.name}",
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          IconButton.filledTonal(
                            onPressed: () {
                              context
                                  .read<SpecialistBloc>()
                                  .add(SpecialistDelete(specialist.id));
                            },
                            //label: const Text("Cancelar"),
                            icon: const Icon(Symbols.delete),
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
