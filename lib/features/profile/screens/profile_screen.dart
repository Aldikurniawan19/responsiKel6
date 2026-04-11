import 'package:flutter/material.dart';
import '../../../core/widgets/page_transition.dart';
import '../../../core/theme/app_colors.dart';
import '../../onboarding/screens/onboarding_screen.dart';
import '../../../screens/main_screen.dart';

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
