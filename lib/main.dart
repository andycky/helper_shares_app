import 'package:flutter/material.dart';
import 'pages/home.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      theme: ThemeData(
          primarySwatch: Colors.purple
      ),      home: MyStatefulWidget(),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({super.key});

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int _selectedIndex = -1;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Helper Shares'),
        leading: IconButton(
          onPressed: () {},
          icon: const CircleAvatar(backgroundImage: AssetImage('assets/img/avatar.png')),
        )
      ),
      body: Center(
        child: HomeScreen(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
          //showSelectedLabels: false,
          //showUnselectedLabels: false,
          selectedItemColor: (_selectedIndex == -1) ? Colors.grey : Colors.amber[800],
          items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Employers',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_2),
            label: 'Helpers',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.transform),
            label: 'Records',
          ),
        ],
        currentIndex: (_selectedIndex==-1)?0:_selectedIndex,
        //selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
