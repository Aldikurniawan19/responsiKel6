import 'package:flutter/material.dart';
import '../core/theme/app_colors.dart';
import '../core/widgets/rounded_hexagon_border.dart';
import '../core/widgets/page_transition.dart';
import '../features/home/screens/home_screen.dart';
import '../features/categories/screens/categories_screen.dart';
import '../features/wishlist/screens/wishlist_screen.dart';
import '../features/profile/screens/profile_screen.dart';
import '../features/cart/screens/cart_screen.dart';

/// Shell utama aplikasi.
/// Bottom navigation bar dan FAB hexagon hanya di-build SATU KALI di sini.
/// Body berupa IndexedStack sehingga perpindahan tab tidak rebuild seluruh halaman
/// dan animasi navigasi tidak terlihat seperti reload satu halaman.
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  /// GlobalKey agar child screen bisa mengakses state MainScreen
  /// dan berpindah tab secara programatis.
  static final GlobalKey<MainScreenState> mainKey = GlobalKey<MainScreenState>();

  @override
  State<MainScreen> createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  /// Pindah ke tab tertentu berdasarkan index (0=Home, 1=Categories, 2=Wishlist, 3=Profile)
  void switchTab(int index) {
    if (_currentIndex != index) {
      setState(() {
        _currentIndex = index;
      });
    }
  }

  // Daftar halaman tab — dipertahankan di memori agar state tidak hilang
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
      // Body menggunakan IndexedStack agar halaman yang tidak aktif tetap hidup
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),

      // --- FAB HEXAGON CART (PERSISTEN) ---
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

      // --- BOTTOM NAVIGATION BAR (PERSISTEN) ---
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
                const SizedBox(width: 56), // Ruang tengah untuk FAB
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

  // Helper widget untuk item nav bawah dengan animasi halus
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
              transitionBuilder: (child, animation) => ScaleTransition(
                scale: animation,
                child: child,
              ),
              child: Icon(
                isActive ? filledIcon : outlineIcon,
                key: ValueKey<bool>(isActive),
                color: isActive
                    ? AppColors.primary
                    : (isDark ? AppColors.darkTextBody : AppColors.lightTextBody),
                size: 24,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: isActive
                    ? AppColors.primary
                    : (isDark ? AppColors.darkTextBody : AppColors.lightTextBody),
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
