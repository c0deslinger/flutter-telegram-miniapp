import 'package:flutter/material.dart';
import 'package:foruai_mini_app/controller/coin_controller.dart';
import 'package:foruai_mini_app/controller/telegram_controller.dart';
import 'package:foruai_mini_app/views/adventure_tab.dart';
import 'package:foruai_mini_app/views/home_tab.dart';
import 'package:get/get.dart';

void main() {
  runApp(const ExpeditionToTheMoonApp());
}

class ExpeditionToTheMoonApp extends StatelessWidget {
  const ExpeditionToTheMoonApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expedition to the Moon',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.dark,
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  late List<Widget> _widgetOptions;
  TelegramController telegramController = Get.put(TelegramController());

  @override
  void initState() {
    super.initState();
    _widgetOptions = <Widget>[
      HomeTab(),
      const AdventureTab(),
      const Text('Earn Tab - Coming Soon'),
      const Text('Friend Tab - Coming Soon'),
      const Text('Airdrop Tab - Coming Soon'),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Get.put(CoinController());
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 20,
        // title: Text(
        //   'Expedition to the Moon',
        //   style: TextStyle(fontSize: 18),
        // ),
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.garage),
            label: 'Garage',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.flight_takeoff),
            label: 'Adventure',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.monetization_on),
            label: 'Earn',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.group),
            label: 'Friend',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.airplanemode_active),
            label: 'Airdrop',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
        showUnselectedLabels: true,
      ),
    );
  }
}
