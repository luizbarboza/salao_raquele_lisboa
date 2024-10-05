import 'package:flutter/material.dart';

import 'agendamento.dart';
import 'profile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  // Mapeamos o índice da BottomNavigationBar para as rotas nomeadas
  final List<String> _routes = ['/profile', '/agendamentos'];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    // Usa o Navigator para trocar de página com base no índice
    Navigator.pushReplacementNamed(context, _routes[index]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_currentIndex == 0 ? 'Perfil' : 'Agendamentos'),
      ),
      body: Navigator(
        onGenerateRoute: (RouteSettings settings) {
          // Exibe a rota correta na tela inicial com base no _currentIndex
          return MaterialPageRoute(
            builder: (context) {
              return _currentIndex == 0
                  ? const ProfilePage()
                  : const AgendamentoPage();
            },
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Perfil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Agendamentos',
          ),
        ],
      ),
    );
  }
}
