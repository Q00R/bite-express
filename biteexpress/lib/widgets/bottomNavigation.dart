import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Import Provider package
import '../pages/home.dart';
import '../pages/search.dart';
import '../classes/Cart.dart'; // Import Cart class
import '../providers/authenticationProvider.dart'; // Import AuthenticationProvider
import '../pages/SignIn.dart'; // Import SignInWidget

class BottomNavigation extends StatelessWidget {
  final int selectedIndex;
  final void Function(int) onIndexChanged;

  BottomNavigation({
    required this.selectedIndex,
    required this.onIndexChanged,
  });

  @override
  Widget build(BuildContext context) {
    // Obtain the cart item count using Provider
    int cartItemCount = Provider.of<Cart>(context).itemCount;

    return Consumer<AuthenticationProvider>(
      builder: (context, authProvider, _) {
        if (authProvider.isAuthenticated) {
          return BottomNavigationBar(
            currentIndex: selectedIndex,
            selectedItemColor: const Color.fromARGB(255, 255, 115, 1),
            unselectedItemColor: const Color(0xff757575),
            type: BottomNavigationBarType.fixed,
            onTap: onIndexChanged,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                activeIcon: Icon(Icons.home_rounded),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search_outlined),
                activeIcon: Icon(Icons.search_outlined),
                label: 'Search',
              ),
              BottomNavigationBarItem(
                icon: Stack(
                  alignment: Alignment.center,
                  children: [
                    Icon(Icons.shopping_cart_outlined),
                    if (cartItemCount >
                        0) // Display item count if cart is not empty
                      Positioned(
                        top: 0,
                        right: 0,
                        child: Container(
                          padding: EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            cartItemCount.toString(),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
                activeIcon: Icon(Icons.shopping_cart_outlined),
                label: 'Cart',
              ),
              // More button
              if (authProvider.isAuthenticated) // Only show if authenticated
                BottomNavigationBarItem(
                  icon: Icon(Icons.menu),
                  activeIcon: Icon(Icons.menu),
                  label: 'More',
                ),
            ],
          );
        } else {
          return BottomNavigationBar(
            currentIndex: selectedIndex,
            selectedItemColor: const Color.fromARGB(255, 255, 115, 1),
            unselectedItemColor: const Color(0xff757575),
            type: BottomNavigationBarType.fixed,
            onTap: onIndexChanged,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                activeIcon: Icon(Icons.home_rounded),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search_outlined),
                activeIcon: Icon(Icons.search_outlined),
                label: 'Search',
              ),
              BottomNavigationBarItem(
                icon: IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignInWidget()),
                    );
                  },
                  icon: Icon(Icons.login_outlined), // Use login icon
                  tooltip: 'Sign In',
                ),
                label: 'Sign In',
              ),
            ],
          );
        }
      },
    );
  }
}
