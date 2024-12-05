// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, library_private_types_in_public_api, use_super_parameters

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'prime.dart'; // Assuming you have a primary color defined

// Theme Provider
class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;
  bool _isDarkMode = false;

  ThemeMode get themeMode => _themeMode;
  bool get isDarkMode => _isDarkMode;

  // Load theme from local storage
  Future<void> loadThemeFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    _isDarkMode = prefs.getBool('isDarkMode') ?? false;
    _themeMode = _isDarkMode ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  // Toggle theme
  void toggleTheme(bool isDark) async {
    _isDarkMode = isDark;
    _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;

    // Save theme preference
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', _isDarkMode);

    // Update system UI colors
    _updateSystemUIColors(isDark);

    notifyListeners();
  }

  // Update system UI colors based on theme
  void _updateSystemUIColors(bool isDark) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
      systemNavigationBarColor: isDark ? Colors.black : Colors.white,
      systemNavigationBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
    ));
  }
}

// Theme Definitions
class AppThemes {
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primarySwatch: Colors.blue,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      elevation: 0,
    ),
    drawerTheme: DrawerThemeData(
      backgroundColor: Colors.white,
    ),
    textTheme: TextTheme(
      bodyLarge: TextStyle(color: Colors.black87),
      bodyMedium: TextStyle(color: Colors.black87),
    ),
    iconTheme: IconThemeData(color: Colors.grey[600]),
  );

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primarySwatch: Colors.blue,
    scaffoldBackgroundColor: Colors.black,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.black,
      foregroundColor: Colors.white,
      elevation: 0,
    ),
    drawerTheme: DrawerThemeData(
      backgroundColor: Colors.grey[900],
    ),
    textTheme: TextTheme(
      bodyLarge: TextStyle(color: Colors.white),
      bodyMedium: TextStyle(color: Colors.white),
    ),
    iconTheme: IconThemeData(color: Colors.white70),
  );
}

// Extended Drawer Item Builder
class DrawerItemBuilder {
  static Widget buildDrawerItem({
    required BuildContext context,
    required IconData icon,
    required String title,
    String? value,
    required Function() onTap,
    Color? titleColor,
    Widget? trailing,
    bool showArrow = false,
    ThemeProvider? themeProvider,
  }) {
    // If this is the dark mode item, use the theme provider
    if (title == 'Dark Theme' && themeProvider != null) {
      return ListTile(
        leading: Icon(
          icon,
          color: Theme.of(context).iconTheme.color,
          size: 24,
        ),
        title: Text(
          title,
          style: TextStyle(
            color: Theme.of(context).textTheme.bodyLarge?.color,
            fontSize: 16,
            fontFamily: 'Nunito',
          ),
        ),
        trailing: Switch(
          value: themeProvider.isDarkMode,
          onChanged: (value) {
            themeProvider.toggleTheme(value);
          },
          activeColor: primary,
        ),
        onTap: () {}, // No additional action needed
      );
    }

    return ListTile(
      leading: Icon(
        icon,
        color: Theme.of(context).iconTheme.color,
        size: 24,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: titleColor ?? Theme.of(context).textTheme.bodyLarge?.color,
          fontSize: 16,
          fontFamily: 'Nunito',
        ),
      ),
      trailing: trailing ??
          (showArrow
              ? Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (value != null)
                Text(
                  value,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontFamily: 'Nunito',
                    fontSize: 14,
                  ),
                ),
              if (value != null) const SizedBox(width: 8),
              Icon(
                Icons.arrow_forward_ios,
                color: Colors.grey[400],
                size: 16,
              ),
            ],
          )
              : null),
      onTap: () {
        // Close drawer before navigation
        Navigator.pop(context);
        onTap();
      },
    );
  }
}

// Main App Wrapper
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final ThemeProvider _themeProvider = ThemeProvider();

  @override
  void initState() {
    super.initState();
    // Load saved theme on app start
    _themeProvider.loadThemeFromPrefs();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      theme: AppThemes.lightTheme,
      darkTheme: AppThemes.darkTheme,
      themeMode: _themeProvider.themeMode,
      home: MainPage(themeProvider: _themeProvider),
    );
  }
}

// Main Page with Drawer
class MainPage extends StatelessWidget {
  final ThemeProvider themeProvider;

  const MainPage({Key? key, required this.themeProvider}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My App'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            // Drawer Header (as in your original code)
            DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    spreadRadius: 1,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Profile picture and edit button (from your original code)
                  Stack(
                    children: [
                      Container(
                        width: 75,
                        height: 75,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            width: 3,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 10,
                              spreadRadius: 1,
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Image.asset(
                            'assets/logo/WhatsApp Image 2024-11-30 at 10.57.28 AM-modified.png',
                            height: 50,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      // Edit profile button
                    ],
                  ),
                  // Rest of the header content
                ],
              ),
            ),

            // Drawer Items
            DrawerItemBuilder.buildDrawerItem(
              context: context,
              icon: Icons.person_outline,
              title: 'Edit Profile',
              onTap: () {
                // Navigation logic
              },
              showArrow: true,
            ),

            // Dark Theme Item with Theme Provider
            DrawerItemBuilder.buildDrawerItem(
              context: context,
              icon: CupertinoIcons.moon,
              title: 'Dark Theme',
              themeProvider: themeProvider, onTap: () {
                ThemeProvider();
            },
            ),

            // Other drawer items...
            DrawerItemBuilder.buildDrawerItem(
              context: context,
              icon: Icons.logout,
              title: 'Logout',
              titleColor: Colors.red,
              onTap: () {
                // Logout logic
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Text('Main Page'),
      ),
    );
  }
}