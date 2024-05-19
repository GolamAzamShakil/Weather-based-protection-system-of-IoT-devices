import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:sdp4/pages/devices_page.dart';
import 'package:sdp4/pages/profile_page.dart';
import 'package:sdp4/pages/weather_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      //title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      /*theme: ThemeData(
        primarySwatch: Colors.blue,
      ),*/
      home: Run(),
    );
  }
}

class Run extends StatefulWidget {
  const Run({super.key});

  @override
  _RunState createState() => _RunState();
}

int _currentIndex = 1;

class _RunState extends State<Run> {
  void changePage(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  final pages = [
    const DevicesPage(),
    const WeatherPage(),
    const ProfilePage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      extendBody: true,
      body: pages[_currentIndex],
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 5.0),
        child: DotNavigationBar(
          margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
          enableFloatingNavBar: true,
          dotIndicatorColor: Colors.transparent,
          //selectedItemColor: Theme.of(context).colorScheme.onSurface,
          unselectedItemColor: Theme.of(context).colorScheme.inversePrimary,
          itemPadding: const EdgeInsets.all(10),
          marginR: const EdgeInsets.symmetric(horizontal: 80, vertical: 0),
          paddingR: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
          splashBorderRadius: 50,
          currentIndex: _currentIndex,
          onTap: changePage,
          //dotIndicatorColor: Colors.transparent,
          items: [
            DotNavigationBarItem(
              icon: const Icon(Icons.devices_fold_rounded),
              selectedColor: Theme.of(context).colorScheme.onSurface,
            ),
            DotNavigationBarItem(
              icon: const Icon(Icons.home),
              selectedColor: Theme.of(context).colorScheme.onSurface,
            ),
            DotNavigationBarItem(
              icon: const Icon(Icons.person_2_rounded),
              selectedColor: Theme.of(context)
                  .colorScheme
                  .onSurface, //const Color(0xff73544C),
            ),
          ],
        ),
      ),
    );
  }
}
