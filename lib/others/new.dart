// // ignore_for_file: unused_local_variable, prefer_const_constructors, use_super_parameters, use_key_in_widget_constructors, library_private_types_in_public_api, sort_child_properties_last

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// // Theme Provider to manage app-wide theme
// class ThemeProvider extends ChangeNotifier {
//   ThemeMode _themeMode = ThemeMode.light;
//   bool _isDarkMode = false;

//   ThemeMode get themeMode => _themeMode;
//   bool get isDarkMode => _isDarkMode;

//   // Load theme from local storage
//   Future<void> loadThemeFromPrefs() async {
//     final prefs = await SharedPreferences.getInstance();
//     _isDarkMode = prefs.getBool('isDarkMode') ?? false;
//     _themeMode = _isDarkMode ? ThemeMode.dark : ThemeMode.light;
//     // notifyListeners();
//   }

//   // Toggle theme
//   void toggleTheme(bool isDark) async {
//     _isDarkMode = isDark;
//     _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;

//     // Save theme preference
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setBool('isDarkMode', _isDarkMode);

//     // Update system UI colors
//     _updateSystemUIColors(isDark);

//     notifyListeners();
//   }

//   // Update system UI colors based on theme
//   void _updateSystemUIColors(bool isDark) {
//     SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
//       statusBarColor: Colors.transparent,
//       statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
//       systemNavigationBarColor: isDark ? Colors.black : Colors.white,
//       systemNavigationBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
//     ));
//   }
// }

// // Custom App Theme
// class AppThemes {
//   // Light Theme
//   static final ThemeData lightTheme = ThemeData(
//     brightness: Brightness.light,
//     primarySwatch: Colors.blue,
//     scaffoldBackgroundColor: Colors.white,
//     appBarTheme: AppBarTheme(
//       backgroundColor: Colors.white,
//       foregroundColor: Colors.black,
//       elevation: 0,
//     ),
//     textTheme: TextTheme(
//       bodyLarge: TextStyle(color: Colors.black),
//       bodyMedium: TextStyle(color: Colors.black),
//     ),
//   );

//   // Dark Theme
//   static final ThemeData darkTheme = ThemeData(
//     brightness: Brightness.dark,
//     primarySwatch: Colors.blue,
//     scaffoldBackgroundColor: Colors.black,
//     appBarTheme: AppBarTheme(
//       backgroundColor: Colors.black,
//       foregroundColor: Colors.white,
//       elevation: 0,
//     ),
//     textTheme: TextTheme(
//       bodyLarge: TextStyle(color: Colors.white),
//       bodyMedium: TextStyle(color: Colors.white),
//     ),
//   );
// }

// // Theme Switch Widget (can be used in drawer or settings)
// class ThemeSwitchWidget extends StatelessWidget {
//   final ThemeProvider themeProvider;

//   const ThemeSwitchWidget({Key? key, required this.themeProvider}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return SwitchListTile(
//       title: Text('Dark Mode'),
//       secondary: Icon(
//         themeProvider.isDarkMode ? Icons.dark_mode : Icons.light_mode,
//       ),
//       value: themeProvider.isDarkMode,
//       onChanged: (bool value) {
//         themeProvider.toggleTheme(value);
//       },
//     );
//   }
// }

// // Main App Widget with Theme Support
// class MyApp extends StatefulWidget {
//   @override
//   _MyAppState createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   final ThemeProvider _themeProvider = ThemeProvider();

//   @override
//   void initState() {
//     super.initState();
//     // Load saved theme on app start
//     _themeProvider.loadThemeFromPrefs();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'My App',
//       theme: AppThemes.lightTheme,
//       darkTheme: AppThemes.darkTheme,
//       themeMode: _themeProvider.themeMode,
//       home: MainAppStructure(themeProvider: _themeProvider),
//     );
//   }
// }

// // Main App Structure with Theme Switch
// class MainAppStructure extends StatelessWidget {
//   final ThemeProvider themeProvider;

//   const MainAppStructure({Key? key, required this.themeProvider}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//       appBar: AppBar(
//         title: Text('My App'),
//         actions: [
//           // Theme switch in app bar
//           Switch(
//             value: themeProvider.isDarkMode,
//             onChanged: (bool value) {
//               themeProvider.toggleTheme(value);
//             },
//           ),
//         ],
//       ),
//       drawer: Drawer(
//         child: ListView(
//           children: [
//             DrawerHeader(
//               child: Text('App Menu'),
//               decoration: BoxDecoration(
//                 color: Theme.of(context).primaryColor,
//               ),
//             ),
//             // Theme switch in drawer
//             ThemeSwitchWidget(themeProvider: themeProvider),
//           ],
//         ),
//       ),
//       body: LoginScreen(themeProvider: themeProvider),
//     );
//   }
// }

// // Modified LoginScreen to accept ThemeProvider
// class LoginScreen extends StatefulWidget {
//   final ThemeProvider themeProvider;

//   const LoginScreen({Key? key, required this.themeProvider}) : super(key: key);

//   @override
//   _LoginScreenState createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     final screenHeight = MediaQuery.of(context).size.height;

//     return Scaffold(
//       backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//       appBar: AppBar(
//         backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back_ios, color: Theme.of(context).textTheme.bodyLarge?.color),
//           onPressed: () {/* Navigation logic */},
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             // Existing login screen content
//             // Use Theme.of(context) for colors to support dark mode
//             Text(
//               'Login with',
//               style: TextStyle(
//                 fontFamily: 'Nunito',
//                 fontSize: screenWidth * 0.07,
//                 fontWeight: FontWeight.bold,
//                 color: Theme.of(context).textTheme.bodyLarge?.color,
//               ),
//             ),
//             // Rest of your login screen content...
//           ],
//         ),
//       ),
//     );
//   }
// }