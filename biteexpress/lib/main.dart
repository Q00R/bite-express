import 'package:biteexpress/pages/MorePage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './pages/home.dart';
import './pages/search.dart';
import './pages/addProduct.dart';
import './widgets/bottomNavigation.dart';
import './providers/productsProvider.dart';
import './classes/Cart.dart';
import './pages/cartPage.dart';
import './pages/Signup.dart';
import './pages/SignIn.dart';
import './providers/authenticationProvider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProductProvider()),
        ChangeNotifierProvider(create: (_) => Cart()),
        ChangeNotifierProvider(create: (_) => AuthenticationProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 255, 115, 1)),
        useMaterial3: true,
      ),
      home: MainAppScaffold(), // Set HomePage as the initial screen
    );
  }
}

class MainAppScaffold extends StatefulWidget {
  @override
  _MainAppScaffoldState createState() => _MainAppScaffoldState();
}

class _MainAppScaffoldState extends State<MainAppScaffold> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _buildPages(context),
      ),
      bottomNavigationBar: BottomNavigation(
        selectedIndex: _selectedIndex,
        onIndexChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }

  List<Widget> _buildPages(BuildContext context) {
    final authProvider = Provider.of<AuthenticationProvider>(context);

    if (authProvider.isAuthenticated) {
      return [
        HomePage(),
        SearchPage(),
        CartPage(),
        MorePage(),
      ];
    } else {
      return [
        HomePage(),
        SearchPage(),
        SignInWidget(),
      ];
    }
  }
}
