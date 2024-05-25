import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './pages/home.dart';
import './pages/search.dart';
import './pages/addProduct.dart';
import './widgets/bottomNavigation.dart';
import './providers/productsProvider.dart';
import './classes/Cart.dart'; // Import the Cart class
import './pages/cartPage.dart';
//import 'package:firebase_core/firebase_core.dart';
//import 'firebase_options.dart';

void main() {
// WidgetsFlutterBinding.ensureInitialized();
// await Firebase.initializeApp();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProductProvider()),
        ChangeNotifierProvider<Cart>(
            create: (_) => Cart()), // Add Cart provider
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
      home: const ParentWidget(),
    );
  }
}

class ParentWidget extends StatefulWidget {
  const ParentWidget({Key? key}) : super(key: key);

  @override
  State<ParentWidget> createState() => _ParentWidgetState();
}

class _ParentWidgetState extends State<ParentWidget> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          HomePage(),
          SearchPage(),
          CartPage(),
          Container(
            child: Center(child: Text('Cart Page')),
          ),
          AddProduct(),
        ],
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
}
