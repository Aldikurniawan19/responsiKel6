import 'package:flutter/material.dart';
import '../core/theme/app_colors.dart';
import '../core/widgets/rounded_hexagon_border.dart';
import '../core/widgets/page_transition.dart';
import '../features/home/screens/home_screen.dart';
import '../features/categories/screens/categories_screen.dart';
import '../features/wishlist/screens/wishlist_screen.dart';
import '../features/profile/screens/profile_screen.dart';
import '../features/cart/screens/cart_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  static final GlobalKey<MainScreenState> mainKey =
      GlobalKey<MainScreenState>();

  @override
  State<MainScreen> createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  void switchTab(int index) {
    if (_currentIndex != index) {
      setState(() {
        _currentIndex = index;
      });
    }
  }

  final List<Widget> _pages = const [
    HomeScreen(),
    CategoriesScreen(),
    WishlistScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: _pages),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Transform.translate(
        offset: const Offset(0, 16),
        child: Container(
          width: 72,
          height: 72,
          decoration: ShapeDecoration(
            color: isDark ? AppColors.primary : Colors.black,
            shape: const RoundedHexagonBorder(),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              customBorder: const RoundedHexagonBorder(),
              onTap: () {
                Navigator.push(
                  context,
                  LoadingPageRoute(page: const CartScreen()),
                );
              },
              child: const Icon(
                Icons.shopping_bag_outlined,
                color: Colors.white,
                size: 30,
              ),
            ),
          ),
        ),
      ),

      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: isDark ? AppColors.darkCardBackground : Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 16,
              offset: const Offset(0, -4),
            ),
          ],
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: SafeArea(
          child: SizedBox(
            height: 76,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavItem(
                  Icons.home_outlined,
                  Icons.home,
                  'Home',
                  0,
                  isDark,
                ),
                _buildNavItem(
                  Icons.grid_view_outlined,
                  Icons.grid_view,
                  'Categories',
                  1,
                  isDark,
                ),
                const SizedBox(width: 56),
                _buildNavItem(
                  Icons.favorite_border,
                  Icons.favorite,
                  'Wishlist',
                  2,
                  isDark,
                ),
                _buildNavItem(
                  Icons.person_outline,
                  Icons.person,
                  'Profile',
                  3,
                  isDark,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(
    IconData outlineIcon,
    IconData filledIcon,
    String label,
    int index,
    bool isDark,
  ) {
    bool isActive = _currentIndex == index;
    return GestureDetector(
      onTap: () {
        if (_currentIndex != index) {
          setState(() {
            _currentIndex = index;
          });
        }
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 250),
              transitionBuilder: (child, animation) =>
                  ScaleTransition(scale: animation, child: child),
              child: Icon(
                isActive ? filledIcon : outlineIcon,
                key: ValueKey<bool>(isActive),
                color: isActive
                    ? AppColors.primary
                    : (isDark
                          ? AppColors.darkTextBody
                          : AppColors.lightTextBody),
                size: 24,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: isActive
                    ? AppColors.primary
                    : (isDark
                          ? AppColors.darkTextBody
                          : AppColors.lightTextBody),
                fontSize: 10,
                fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
