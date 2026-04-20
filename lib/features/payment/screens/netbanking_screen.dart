import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

class NetbankingScreen extends StatefulWidget {
  const NetbankingScreen({super.key});

  @override
  State<NetbankingScreen> createState() => _NetbankingScreenState();
}

class _NetbankingScreenState extends State<NetbankingScreen> {
  final List<String> _allBanks = [
    "Bank Of india",
    "Bank Of Maharasthra",
    "Canara Bank",
    "HDFC Bank",
    "IDFC Bank",
    "Catholic Syrian Bank",
    "Catholic Syrian Bank",
    "Central Bank of India",
    "City Union Bank",
    "Corporation Bank",
    "Cosmos Bank",
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark
          ? AppColors.darkBackground
          : AppColors.lightBackground,
      appBar: AppBar(
        backgroundColor: isDark ? AppColors.darkCardBackground : Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        titleSpacing: 16,
        title: Container(
          height: 40,
          decoration: BoxDecoration(
            color: isDark
                ? AppColors.darkBackground
                : AppColors.lightBackground,
            borderRadius: BorderRadius.circular(4),
          ),
          child: TextField(
            style: TextStyle(
              color: isDark ? Colors.white : Colors.black,
              fontSize: 15,
            ),
            decoration: InputDecoration(
              hintText: "Search by bank name",
              hintStyle: TextStyle(
                color: isDark ? Colors.white54 : Colors.black38,
                fontSize: 15,
              ),
              prefixIcon: const Icon(
                Icons.search,
                color: AppColors.primary,
                size: 22,
              ),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(vertical: 10),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
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
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Popular Banks",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 24),
                  GridView.count(
                    crossAxisCount: 3,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    childAspectRatio: 1.1,
                    children: [
                      _buildBankIcon(
                        Icons.attach_money_rounded,
                        const Color(0xFFE3F2FD),
                        const Color(0xFFFF8F00),
                        isDark,
                      ),
                      _buildBankIcon(
                        Icons.account_balance_rounded,
                        const Color(0xFFE8F5E9),
                        const Color(0xFF26A69A),
                        isDark,
                      ),
                      _buildBankIcon(
                        Icons.monetization_on_outlined,
                        const Color(0xFFFCE4EC),
                        const Color(0xFFE91E63),
                        isDark,
                      ),
                      _buildBankIcon(
                        Icons.assured_workload_rounded,
                        const Color(0xFFFFF3E0),
                        const Color(0xFFE65100),
                        isDark,
                      ),
                      _buildBankTransferCard(
                        const Color(0xFFF5F5F5),
                        Colors.black87,
                        isDark,
                      ),
                      _buildBankIcon(
                        Icons.currency_bitcoin_rounded,
                        const Color(0xFFFFF8E1),
                        const Color(0xFFFF6F00),
                        isDark,
                      ),
                      _buildBankIcon(
                        Icons.manage_search_rounded,
                        const Color(0xFFE8EAF6),
                        const Color(0xFF3F51B5),
                        isDark,
                      ),
                      _buildBankTransferCard(
                        const Color(0xFF263238),
                        Colors.white,
                        isDark,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            Text(
              "All Banks",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : Colors.black87,
              ),
            ),
            const SizedBox(height: 16),

            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 4,
                crossAxisSpacing: 8,
                mainAxisSpacing: 0,
              ),
              itemCount: _allBanks.length,
              itemBuilder: (context, index) {
                return Row(
                  children: [
                    const Icon(
                      Icons.arrow_forward,
                      color: AppColors.primary,
                      size: 14,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        _allBanks[index],
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primary,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                );
              },
            ),

            const SizedBox(height: 40),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: OutlinedButton.icon(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(
                  Icons.arrow_back,
                  color: AppColors.primary,
                  size: 18,
                ),
                label: const Text(
                  "Return",
                  style: TextStyle(
                    fontSize: 16,
                    color: AppColors.primary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: AppColors.primary),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildBankIcon(
    IconData icon,
    Color bgColor,
    Color iconColor,
    bool isDark,
  ) {
    return Center(
      child: Container(
        width: 65,
        height: 65,
        decoration: BoxDecoration(
          color: isDark ? iconColor.withOpacity(0.15) : bgColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isDark ? iconColor.withOpacity(0.3) : Colors.grey.shade200,
            width: 0.5,
          ),
        ),
        child: Center(child: Icon(icon, color: iconColor, size: 32)),
      ),
    );
  }

  Widget _buildBankTransferCard(Color bgColor, Color textColor, bool isDark) {
    return Center(
      child: Container(
        width: 65,
        height: 65,
        decoration: BoxDecoration(
          color: isDark ? textColor.withOpacity(0.12) : bgColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isDark ? textColor.withOpacity(0.25) : Colors.grey.shade200,
            width: 0.5,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.swap_horiz_rounded, color: textColor, size: 18),
              const SizedBox(height: 2),
              Text(
                "BANK",
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w900,
                  color: textColor,
                  letterSpacing: 1.0,
                ),
              ),
              Text(
                "TRANSFER",
                style: TextStyle(
                  fontSize: 7,
                  fontWeight: FontWeight.w600,
                  color: textColor.withOpacity(0.7),
                  letterSpacing: 1.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
