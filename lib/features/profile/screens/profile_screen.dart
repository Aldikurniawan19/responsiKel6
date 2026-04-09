import 'dart:math';
import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../home/screens/home_screen.dart';
import '../../categories/screens/categories_screen.dart';
import '../../wishlist/screens/wishlist_screen.dart';
import '../../onboarding/screens/onboarding_screen.dart';
import '../../cart/screens/cart_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class RoundedHexagonBorder extends ShapeBorder {
  const RoundedHexagonBorder();

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.zero;

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) =>
      getOuterPath(rect, textDirection: textDirection);

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    final cx = rect.center.dx;
    final cy = rect.center.dy;
    final r = rect.shortestSide / 2;
    final cornerRadius = r * 0.25;

    // 6 titik hexagon (flat-top, dirotasi 90°)
    final angles = List.generate(
      6,
      (i) => (i * 60 - 90) * (3.141592653589793 / 180),
    );
    final points = angles
        .map((a) => Offset(cx + r * cos(a), cy + r * sin(a)))
        .toList();

    final path = Path();
    for (int i = 0; i < 6; i++) {
      final curr = points[i];
      final next = points[(i + 1) % 6];
      final prev = points[(i + 5) % 6];

      final toCurr = (curr - prev);
      final toNext = (next - curr);

      final len1 = toCurr.distance;
      final len2 = toNext.distance;

      final p1 =
          curr -
          Offset(
            toCurr.dx / len1 * cornerRadius,
            toCurr.dy / len1 * cornerRadius,
          );
      final p2 =
          curr +
          Offset(
            toNext.dx / len2 * cornerRadius,
            toNext.dy / len2 * cornerRadius,
          );

      if (i == 0) {
        path.moveTo(p1.dx, p1.dy);
      } else {
        path.lineTo(p1.dx, p1.dy);
      }
      path.quadraticBezierTo(curr.dx, curr.dy, p2.dx, p2.dy);
    }
    path.close();
    return path;
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {}

  @override
  ShapeBorder scale(double t) => this;
}

class _ProfileScreenState extends State<ProfileScreen> {
  int _currentIndex = 3;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      // --- APPBAR ---
      appBar: AppBar(
        backgroundColor: isDark
            ? AppColors.darkBackground
            : AppColors.lightBackground,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: isDark ? Colors.white : Colors.black,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Profile',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: isDark ? Colors.white : Colors.black,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              Icons.more_vert,
              color: isDark ? Colors.white : Colors.black,
            ),
            onPressed: () {},
          ),
        ],
      ),

      // --- BODY ---
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. AREA INFO USER
            Row(
              children: [
                const CircleAvatar(
                  radius: 36,
                  backgroundImage: AssetImage(
                    'assets/images/profil.png',
                  ), // Foto profil mock
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Thomas Djono',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: isDark ? Colors.white : Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'ID 02123141',
                        style: TextStyle(
                          fontSize: 14,
                          color: isDark
                              ? AppColors.darkTextBody
                              : AppColors.lightTextBody,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(
                    Icons.edit_outlined,
                    color: AppColors.primary,
                  ),
                  onPressed: () {},
                ),
              ],
            ),
            const SizedBox(height: 30),

            // 2. AREA QUICK ACTIONS (4 Kotak)
            Row(
              children: [
                Expanded(
                  child: _buildQuickAction(
                    Icons.inventory_2_outlined,
                    'Order',
                    isDark,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildQuickAction(
                    Icons.favorite_border,
                    'Wishlist',
                    isDark,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildQuickAction(
                    Icons.card_giftcard,
                    'Coupons',
                    isDark,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildQuickAction(
                    Icons.headset_mic_outlined,
                    'Help Center',
                    isDark,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),

            // 3. AREA ACCOUNT SETTINGS
            Text(
              'Account Settings',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : Colors.black87,
              ),
            ),
            const SizedBox(height: 16),

            _buildSettingsTile(Icons.person_outline, 'Edit Profile', isDark),
            _buildSettingsTile(
              Icons.location_on_outlined,
              'Saved Addresses',
              isDark,
            ),
            _buildSettingsTile(Icons.text_fields, 'Select Language', isDark),
            _buildSettingsTile(
              Icons.notifications_none,
              'Notification Setting',
              isDark,
              badgeCount: 5,
            ),
            _buildSettingsTile(
              Icons.logout,
              'Log Out',
              isDark,
              onTap: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const OnboardingScreen(),
                  ),
                  (route) => false,
                );
              },
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),

      // --- BOTTOM NAVIGATION BAR KUSTOM ---
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Transform.translate(
        offset: const Offset(0, 16), // Turunkan posisi
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
                  MaterialPageRoute(builder: (context) => const CartScreen()),
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

      // BottomAppBar tanpa notch agar navbar tetap solid dan FAB benar-benar di depan
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
            height: 64,
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

  // Helper Widget: Kotak Quick Action
  Widget _buildQuickAction(IconData icon, String label, bool isDark) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkCardBackground : Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: isDark
            ? []
            : [
                BoxShadow(
                  color: Colors.black.withOpacity(0.03),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
        border: isDark ? Border.all(color: AppColors.darkInputBorder) : null,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: AppColors.primary, size: 24),
          const SizedBox(width: 12),
          Text(
            label,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: isDark ? Colors.white : Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  // Helper Widget: Baris Account Settings
  Widget _buildSettingsTile(
    IconData icon,
    String title,
    bool isDark, {
    int badgeCount = 0,
    VoidCallback? onTap,
  }) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(
        icon,
        color: isDark ? AppColors.darkTextBody : Colors.black54,
        size: 24,
      ),
      title: Row(
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: isDark ? Colors.white : Colors.black87,
            ),
          ),
          if (badgeCount > 0) ...[
            const SizedBox(width: 12),
            Container(
              padding: const EdgeInsets.all(6),
              decoration: const BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
              ),
              child: Text(
                badgeCount.toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ],
      ),
      trailing: Icon(
        Icons.chevron_right,
        color: isDark ? AppColors.darkTextBody : Colors.black38,
      ),
      onTap: onTap ?? () {},
    );
  }

  // Helper widget untuk item nav bawah
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
        if (index == 0) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const HomeScreen()),
          );
        } else if (index == 1) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const CategoriesScreen()),
          );
        } else if (index == 2) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const WishlistScreen()),
          );
        } else {
          setState(() {
            _currentIndex = index;
          });
        }
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            isActive ? filledIcon : outlineIcon,
            color: isActive
                ? AppColors.primary
                : (isDark ? AppColors.darkTextBody : AppColors.lightTextBody),
            size: 24,
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
    );
  }
}
