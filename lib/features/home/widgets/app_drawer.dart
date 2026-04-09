import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_theme.dart';
import '../../onboarding/screens/onboarding_screen.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Drawer(
      backgroundColor: isDark
          ? AppColors.darkBackground
          : AppColors.lightInputBackground,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 28,
                    backgroundImage: AssetImage(
                      'assets/images/profil.png',
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'John Doe',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: isDark ? Colors.white : Colors.black,
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          'example@gmail.com',
                          style: TextStyle(
                            fontSize: 13,
                            color: AppColors.primary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    _buildMenuItem(
                      context,
                      Icons.home_outlined,
                      'Home',
                      isDark,
                      isActive: true,
                    ),
                    _buildMenuItem(
                      context,
                      Icons.layers_outlined,
                      'Products',
                      isDark,
                    ),
                    _buildMenuItem(
                      context,
                      Icons.favorite_border,
                      'Wishlist',
                      isDark,
                    ),
                    _buildMenuItem(context, Icons.sync, 'Orders', isDark),
                    _buildMenuItem(
                      context,
                      Icons.shopping_cart_outlined,
                      'My Cart',
                      isDark,
                    ),
                    _buildMenuItem(
                      context,
                      Icons.person_outline,
                      'Profile',
                      isDark,
                    ),
                    _buildMenuItem(
                      context,
                      Icons.logout,
                      'Logout',
                      isDark,
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const OnboardingScreen(),
                          ),
                          (route) => false,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),

            Divider(
              color: isDark
                  ? AppColors.darkInputBorder
                  : AppColors.lightInputBorder,
              height: 1,
            ),

            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 12.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.dark_mode_outlined,
                        color: isDark ? Colors.white : Colors.black54,
                        size: 22,
                      ),
                      const SizedBox(width: 16),
                      Text(
                        'Dark Mode',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: isDark ? Colors.white : Colors.black87,
                        ),
                      ),
                    ],
                  ),
                  Switch(
                    value: isDark,
                    activeColor: AppColors.primary,
                    onChanged: (bool value) {
                      AppTheme.themeNotifier.value = value
                          ? ThemeMode.dark
                          : ThemeMode.light;
                    },
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(
                left: 24.0,
                right: 24.0,
                bottom: 24.0,
                top: 8.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'HotDiee Fashion Store',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : Colors.black,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'App Version 1.0',
                    style: TextStyle(
                      fontSize: 12,
                      color: isDark
                          ? AppColors.darkTextBody
                          : AppColors.lightTextBody,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(
    BuildContext context,
    IconData icon,
    String title,
    bool isDark, {
    bool isActive = false,
    VoidCallback? onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8.0),
      decoration: isActive
          ? BoxDecoration(
              color: isDark ? AppColors.darkCardBackground : Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: isDark
                  ? []
                  : [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
            )
          : null,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
        leading: Icon(
          icon,
          color: isActive
              ? AppColors.primary
              : (isDark ? Colors.white70 : Colors.black87),
          size: 22,
        ),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 15,
            fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
            color: isActive
                ? (isDark ? Colors.white : Colors.black)
                : (isDark ? Colors.white70 : Colors.black87),
          ),
        ),
        trailing: Icon(
          Icons.chevron_right,
          color: isDark ? Colors.white54 : Colors.black38,
          size: 20,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        onTap:
            onTap ??
            () {
              Navigator.pop(context);
            },
      ),
    );
  }
}
