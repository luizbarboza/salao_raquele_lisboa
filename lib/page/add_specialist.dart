import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import '../bloc/person.dart';
import '../bloc/person_event.dart';
import '../bloc/person_state.dart';
import '../bloc/specialist.dart';
import '../bloc/specialist_event.dart';
import '../bloc/specialist_state.dart';
import '../bloc/specialty.dart';
import '../bloc/specialty_event.dart';
import '../bloc/specialty_state.dart';

class AddSpecialistPage extends StatefulWidget {
  const AddSpecialistPage({super.key});

  @override
  AddSpecialistPageState createState() => AddSpecialistPageState();
}

class AddSpecialistPageState extends State<AddSpecialistPage> {
  final TextEditingController _specialtyController = TextEditingController();
  final TextEditingController _personController = TextEditingController();

  int? _selectedSpecialty;
  int? _selectedPerson;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SpecialtyBloc>(
          create: (context) => SpecialtyBloc()..add(SpecialtyFetch()),
        ),
        BlocProvider<PersonBloc>(
          create: (context) => PersonBloc()..add(PersonFetch()),
        ),
        BlocProvider<SpecialistBloc>(
          create: (context) => SpecialistBloc(),
        ),
      ],
      child: BlocListener<SpecialistBloc, SpecialistState>(
        listener: (context, state) {
          if (state is SpecialistInserted) {
            Navigator.pop(context);
          } else if (state is SpecialistError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Adicionar especialista'),
          ),
          body: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    BlocBuilder<SpecialtyBloc, SpecialtyState>(
                        builder: (context, state) {
                      var dropdownMenuEntries = <DropdownMenuEntry<int?>>[];
                      if (state is SpecialtyFetched) {
                        dropdownMenuEntries = state.specialties
                            .map((specialty) => DropdownMenuEntry(
                                  value: specialty.id,
                                  label: specialty.name,
                                ))
                            .toList();
                      }
                      return DropdownMenu<int?>(
                        width: 300,
                        initialSelection: null,
                        label: const Text('Especialidade'),
                        onSelected: (selectedSpecialty) {
                          setState(() {
                            _selectedSpecialty = selectedSpecialty;
                          });
                        },
                        dropdownMenuEntries: dropdownMenuEntries,
                        enableFilter: true,
                        controller: _specialtyController,
                      );
                    }),
                    const SizedBox(height: 20),
                    BlocBuilder<PersonBloc, PersonState>(
                        builder: (context, state) {
                      var dropdownMenuEntries = <DropdownMenuEntry<int?>>[];
                      if (state is PersonFetched) {
                        dropdownMenuEntries = state.people
                            .map((person) => DropdownMenuEntry(
                                  value: person.id,
                                  label: person.name,
                                ))
                            .toList();
                      }
                      return DropdownMenu<int?>(
                        width: 300,
                        initialSelection: null,
                        label: const Text('Pessoa'),
                        onSelected: (selectedPerson) {
                          setState(() {
                            _selectedPerson = selectedPerson;
                          });
                        },
                        dropdownMenuEntries: dropdownMenuEntries,
                        enableFilter: true,
                        controller: _personController,
                      );
                    }),
                    const SizedBox(height: 20),
                    Builder(builder: (context) {
                      return FilledButton.icon(
                        icon: const Icon(Symbols.add),
                        onPressed: () {
                          final specialtyBloc = context.read<SpecialistBloc>();
                          specialtyBloc.add(SpecialistInsert({
                            "especialidade": _selectedSpecialty!,
                            "pessoa": _selectedPerson!,
                          }));
                        },
                        label: const Text('Adicionar'),
                      );
                    }),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
