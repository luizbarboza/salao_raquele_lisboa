import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import '../bloc/specialty.dart';
import '../bloc/specialty_event.dart';
import '../bloc/specialty_state.dart';

class AddSpecialtyPage extends StatefulWidget {
  const AddSpecialtyPage({super.key});

  @override
  AddSpecialtyPageState createState() => AddSpecialtyPageState();
}

class AddSpecialtyPageState extends State<AddSpecialtyPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SpecialtyBloc>(
          create: (context) => SpecialtyBloc(),
        ),
      ],
      child: BlocListener<SpecialtyBloc, SpecialtyState>(
        listener: (context, state) {
          if (state is SpecialtyInserted) {
            Navigator.pop(context);
          } else if (state is SpecialtyError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Adicionar especialidade'),
          ),
          body: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 300,
                      child: TextFormField(
                        controller: _nameController,
                        decoration: const InputDecoration(
                          labelText: 'Nome',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: 300,
                      child: TextFormField(
                        controller: _descriptionController,
                        decoration: const InputDecoration(
                          labelText: 'Descrição',
                          border: OutlineInputBorder(),
                        ),
                        minLines: 3, // Set this
                        maxLines: 6, // and this
                        keyboardType: TextInputType.multiline,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Builder(builder: (context) {
                      return FilledButton.icon(
                        icon: const Icon(Symbols.add),
                        onPressed: () {
                          final specialtyBloc = context.read<SpecialtyBloc>();
                          specialtyBloc.add(SpecialtyInsert({
                            "nome": _nameController.text,
                            "descricao": _descriptionController.text,
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
