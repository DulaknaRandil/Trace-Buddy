import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:glassmorphism_ui/glassmorphism_ui.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:iconsax/iconsax.dart';
import 'package:responsive_navigation_bar/responsive_navigation_bar.dart';
import 'package:trace_buddy/ui/Profile%20Screen/profile_screen.dart';

class NavigationBarScreen extends StatefulWidget {
  @override
  _NavigationBarScreenState createState() => _NavigationBarScreenState();
}

class _NavigationBarScreenState extends State<NavigationBarScreen> {
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    HomeScreen(), // Home Tab content
    TaskListScreen(),
    SettingsScreen(), // Explore Tab content
    ProfileScreen(), // Profile Tab content
  ];

  void _onTabChange(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Background with Glassmorphism effect
          GlassContainer(
            blur: 50,
            shadowStrength: 10,
            opacity: 0.1,
            borderRadius: BorderRadius.circular(0),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFFFFC100), Colors.amber],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
          ),
          SafeArea(
            child: _widgetOptions.elementAt(_selectedIndex),
          ),
        ],
      ),
      bottomNavigationBar: ResponsiveNavigationBar(
        outerPadding: EdgeInsets.all(2),
        borderRadius: 10,
        backgroundOpacity: 0.1,
        activeButtonFlexFactor: 50,
        selectedIndex: _selectedIndex,
        activeIconColor: Colors.black,
        inactiveIconColor: Colors.black,
        onTabChange: _onTabChange,
        textStyle: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
        navigationBarButtons: const <NavigationBarButton>[
          NavigationBarButton(
            icon: Icons.home,
            backgroundGradient: LinearGradient(
              colors: [Colors.yellow, Colors.amber],
            ),
          ),
          NavigationBarButton(
            icon: EvaIcons.search,
            backgroundGradient: LinearGradient(
              colors: [Colors.yellow, Colors.amber],
            ),
          ),
          NavigationBarButton(
            icon: Iconsax.routing,
            backgroundGradient: LinearGradient(
              colors: [Colors.yellow, Colors.amber],
            ),
          ),
          NavigationBarButton(
            icon: EvaIcons.heart,
            backgroundGradient: LinearGradient(
              colors: [Colors.yellow, Colors.amber],
            ),
          ),
        ],
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        backgroundColor: Colors.amber,
      ),
      body: Center(
        child: Text(
          'Home Screen Content',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}

class TaskListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task List'),
        backgroundColor: Colors.amber,
      ),
      body: Center(
        child: Text(
          'Task List Screen Content',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        backgroundColor: Colors.amber,
      ),
      body: Center(
        child: Text(
          'Settings Screen Content',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
