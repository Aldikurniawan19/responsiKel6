import 'package:flutter/material.dart';
import '../../../core/widgets/page_transition.dart';
import '../../../core/theme/app_colors.dart';
import '../../onboarding/screens/onboarding_screen.dart';
import '../../../screens/main_screen.dart';
import 'edit_profile.dart';
import 'saved_addresses.dart';
import '../../coupons/screens/coupons_screen.dart';
import '../../orders/screens/orders_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      // --- APPBAR ---
      appBar: AppBar(
        backgroundColor: isDark ? AppColors.darkCardBackground : Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: isDark ? Colors.white : Colors.black,
          ),
          onPressed: () {
            MainScreen.mainKey.currentState?.switchTab(0);
          },
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
                  backgroundImage: AssetImage('assets/images/profil.png'),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Paijo',
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
                  // Navigasi ke EditProfileScreen
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const EditProfileScreen(),
                      ),
                    );
                  },
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
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const OrdersScreen(),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildQuickAction(
                    Icons.favorite_border,
                    'Wishlist',
                    isDark,
                    onTap: () {
                      MainScreen.mainKey.currentState?.switchTab(2);
                    },
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
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CouponsScreen(),
                        ),
                      );
                    },
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

            // Navigasi ke EditProfileScreen dari settings tile
            _buildSettingsTile(
              Icons.person_outline,
              'Edit Profile',
              isDark,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const EditProfileScreen(),
                  ),
                );
              },
            ),
            _buildSettingsTile(
              Icons.location_on_outlined,
              'Saved Addresses',
              isDark,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SavedAddressesScreen(),
                  ),
                );
              },
            ),
            _buildSettingsTile(
              Icons.text_fields,
              'Select Language',
              isDark,
              onTap: () {
                _showLanguageDialog(context, isDark);
              },
            ),
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
                  LoadingPageRoute(page: const OnboardingScreen()),
                  (route) => false,
                );
              },
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  // Helper Widget: Kotak Quick Action
  Widget _buildQuickAction(
    IconData icon,
    String label,
    bool isDark, {
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
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
      ),
    );
  }

  //Baru
  void _showLanguageDialog(BuildContext context, bool isDark) {
    final languages = [
      {'flag': '🇮🇩', 'name': 'Indonesian'},
      {'flag': '🇺🇸', 'name': 'English'},
      {'flag': '🇮🇳', 'name': 'Indian'},
      {'flag': '🇩🇪', 'name': 'German'},
      {'flag': '🇮🇹', 'name': 'Italian'},
      {'flag': '🇪🇸', 'name': 'Spanish'},
    ];

    showModalBottomSheet(
      context: context,
      backgroundColor: isDark ? AppColors.darkBackground : Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.only(top: 12, bottom: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Drag handle
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: isDark
                      ? AppColors.darkInputBorder
                      : AppColors.lightInputBorder,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                'Select Language',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.white : Colors.black87,
                ),
              ),
            ),
            const SizedBox(height: 8),

            // Daftar bahasa
            ...languages.asMap().entries.map((entry) {
              final i = entry.key;
              final lang = entry.value;
              final isLast = i == languages.length - 1;
              return Column(
                children: [
                  ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 24),
                    leading: Text(
                      lang['flag']!,
                      style: const TextStyle(fontSize: 24),
                    ),
                    title: Text(
                      lang['name']!,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: isDark ? Colors.white : Colors.black87,
                      ),
                    ),
                    trailing: Icon(
                      Icons.chevron_right,
                      color: isDark ? Colors.white38 : Colors.black38,
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            '${lang['name']} selected',
                            style: const TextStyle(color: Colors.white),
                          ),
                          backgroundColor: AppColors.primary,
                          duration: const Duration(seconds: 1),
                        ),
                      );
                    },
                  ),
                  if (!isLast)
                    Divider(
                      indent: 24,
                      endIndent: 24,
                      height: 1,
                      color: isDark
                          ? AppColors.darkInputBorder
                          : Colors.grey.shade200,
                    ),
                ],
              );
            }),
          ],
        ),
      ),
    );
  }

  //end baru

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
}
