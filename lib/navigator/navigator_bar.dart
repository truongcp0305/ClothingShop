import 'package:flutter/material.dart';
import '../screens/cart/cart_screen.dart';
import '../screens/home/home_screen.dart';
import '../screens/user/user_detail.dart';


class NavigatorBar extends StatefulWidget {
  const NavigatorBar({Key? key}) : super(key: key);

  @override
  State<NavigatorBar> createState() => _NavigatorBarState();
}

class _NavigatorBarState extends State<NavigatorBar> {
  int currentIndex = 0;
  late List<Map<String, Widget>> _pages;
  @override
  void initState(){
    _pages =[
      {
        'page' : const HomeScreen()
      },
      {
        'page' : const CartScreen()
      },
      {
        'page' : const UserDetail()
      }
    ];
    super.initState();
  }

  int selectedPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  _pages[currentIndex]['page'],
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (index) {
            setState(() {
              currentIndex = index;
            });
          },
          unselectedItemColor: Colors.black,
          selectedItemColor: Colors.green,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              tooltip: 'Home',
              label: 'Home',
              //backgroundColor: Colors.blue
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart),
                tooltip: 'Cart',
                label: 'Cart'
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.person),
                tooltip: 'User',
                label: 'User'
            ),
          ],
        ),
      ),
    );
  }
}
