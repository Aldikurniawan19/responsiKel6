import 'dart:async';
import 'package:flutter/material.dart';
import '../../../core/widgets/page_transition.dart';
import '../../../core/theme/app_colors.dart';
import '../../products/screens/products_screen.dart';

class BannerContent {
  final String imageUrl;
  final String tag;
  final String offer;
  final String description;
  final bool imageOnRight;
  final Color? backgroundColor;

  BannerContent({
    required this.imageUrl,
    required this.tag,
    required this.offer,
    required this.description,
    this.imageOnRight = false,
    this.backgroundColor,
  });
}

class PromoBannerWidget extends StatefulWidget {
  final bool isDark;

  const PromoBannerWidget({super.key, required this.isDark});

  @override
  State<PromoBannerWidget> createState() => _PromoBannerWidgetState();
}

class _PromoBannerWidgetState extends State<PromoBannerWidget> {
  final PageController _bannerController = PageController(initialPage: 0);
  int _currentBanner = 0;
  Timer? _timer;

  final List<BannerContent> _banners = [
    BannerContent(
      imageUrl: 'assets/images/4b.png',
      tag: '#WINTER SALE',
      offer: '35% Off',
      description: 'Discover our latest Products',
      backgroundColor: const Color(0xFFF5E6CC),
    ),
    BannerContent(
      imageUrl: 'assets/images/9b.png',
      tag: '#SPRING COLLECTION',
      offer: '50% Off',
      description: 'Explore New Styles',
      imageOnRight: true, // Gambar di kanan untuk slide kedua
      backgroundColor: const Color(0xFFFFF8E7), // Cream color
    ),
    BannerContent(
      imageUrl: 'assets/images/3b.png',
      tag: '#FLASH SALE',
      offer: '10% Off',
      description: 'Hurry Up! Limited Stock',
      backgroundColor: const Color(0xFFF5E6CC),
    ),
  ];

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 4), (Timer timer) {
      if (_currentBanner < _banners.length - 1) {
        _currentBanner++;
      } else {
        _currentBanner = 0; // Kembali ke awal
      }

      if (_bannerController.hasClients) {
        _bannerController.animateToPage(
          _currentBanner,
          duration: const Duration(milliseconds: 800),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _bannerController.dispose();
    super.dispose();
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentBanner = index;
    });

    // Jika sudah di slide terakhir (manual swipe), kembali ke awal setelah delay
    if (index == _banners.length - 1) {
      // Reset timer agar tidak bentrok
      _timer?.cancel();
      _timer = Timer(const Duration(seconds: 4), () {
        if (_bannerController.hasClients) {
          _bannerController.animateToPage(
            0,
            duration: const Duration(milliseconds: 800),
            curve: Curves.easeInOut,
          );
        }
        // Restart periodic timer
        _startAutoSlide();
      });
    }
  }

  void _startAutoSlide() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 4), (Timer timer) {
      if (_currentBanner < _banners.length - 1) {
        _currentBanner++;
      } else {
        _currentBanner = 0;
      }

      if (_bannerController.hasClients) {
        _bannerController.animateToPage(
          _currentBanner,
          duration: const Duration(milliseconds: 800),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 200,
      child: Stack(
        children: [
          PageView.builder(
            controller: _bannerController,
            onPageChanged: _onPageChanged,
            itemCount: _banners.length,
            itemBuilder: (context, index) {
              return Container(
                color:
                    _banners[index].backgroundColor ?? const Color(0xFFC2DAD5),
                child: _buildBannerSlide(_banners[index], widget.isDark),
              );
            },
          ),

          // Dot indicator di kanan
          Positioned(
            right: 16,
            top: 0,
            bottom: 0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _banners.length,
                (index) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: _buildDot(
                    widget.isDark,
                    isActive: index == _currentBanner,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBannerSlide(BannerContent content, bool isDark) {
    final imageWidget = Expanded(
      flex: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.asset(content.imageUrl, height: 200, fit: BoxFit.cover),
        ),
      ),
    );

    final textWidget = Expanded(
      flex: 5,
      child: Padding(
        padding: EdgeInsets.only(
          left: content.imageOnRight ? 16 : 4,
          right: content.imageOnRight ? 4 : 36,
          top: 20,
          bottom: 20,
        ),
        child: Column(
          crossAxisAlignment: content.imageOnRight
              ? CrossAxisAlignment.start
              : CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              content.tag,
              style: const TextStyle(
                color: AppColors.primary,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              content.offer,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                height: 1.1,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              content.description,
              textAlign: content.imageOnRight
                  ? TextAlign.left
                  : TextAlign.right,
              style: const TextStyle(color: Colors.black54, fontSize: 11),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 34,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    LoadingPageRoute(
                      page: ProductsScreen(
                        categoryTitle: content.tag.replaceAll('#', '').trim(),
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  'Shop Now',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: content.imageOnRight
            ? [textWidget, imageWidget]
            : [imageWidget, textWidget],
      ),
    );
  }

  Widget _buildDot(bool isDark, {required bool isActive}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: 8,
      height: isActive ? 20 : 8,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: isActive
            ? AppColors.primary
            : (isDark
                  ? AppColors.darkIndicatorInactive
                  : AppColors.lightIndicatorInactive),
      ),
    );
  }
}
