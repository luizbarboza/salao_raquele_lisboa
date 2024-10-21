import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import '../bloc/specialty.dart';
import '../bloc/specialty_event.dart';
import '../bloc/specialty_state.dart';
import '../model/specialty.dart';

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
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      body: BlocProvider(
        create: (context) => SpecialtyBloc()..add(SpecialtyFetch()),
        child: Container(
          color: colorScheme.surfaceContainer,
          child: BlocConsumer<SpecialtyBloc, SpecialtyState>(
            listener: (context, state) {
              if (state is SpecialtyError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.message)),
                );
              } else if (state is SpecialtyDeleted) {
                context.read<SpecialtyBloc>().add(SpecialtyFetch());
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
        ),
      ),
    );
  }
}

class SpecialtiesLisView extends StatelessWidget {
  final List<Specialty> specialties;

  const SpecialtiesLisView(this.specialties, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(8),
      itemCount: specialties.length,
      itemBuilder: (context, index) {
        Specialty specialty = specialties[index];
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
                IconButton.filledTonal(
                  onPressed: () {
                    context
                        .read<SpecialtyBloc>()
                        .add(SpecialtyDelete(specialty.id));
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
    );
  }
}
