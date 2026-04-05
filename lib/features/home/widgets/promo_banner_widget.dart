import 'dart:async';
import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

class BannerContent {
  final String imageUrl;
  final String tag;
  final String offer;
  final String description;

  BannerContent({
    required this.imageUrl,
    required this.tag,
    required this.offer,
    required this.description,
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
      imageUrl:
          'https://images.unsplash.com/photo-1549298916-b41d501d3772?q=80&w=600',
      tag: '#WINTER SALE',
      offer: '35% Off',
      description: 'Discover our latest Products',
    ),
    BannerContent(
      imageUrl:
          'https://images.unsplash.com/photo-1620799140408-edc6dcb6d633?q=80&w=600',
      tag: '#SPRING COLLECTION',
      offer: '50% Off',
      description: 'Explore New Styles',
    ),
    BannerContent(
      imageUrl:
          'https://images.unsplash.com/photo-1596755094514-f87e34085b2c?q=80&w=600',
      tag: '#FLASH SALE',
      offer: '10% Off',
      description: 'Hurry Up! Limited Stock',
    ),
  ];

  @override
  void initState() {
    super.initState();
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
  void dispose() {
    _timer?.cancel();
    _bannerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 200,
      decoration: BoxDecoration(
        color: widget.isDark ? AppColors.darkCardBackground : Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: widget.isDark
            ? []
            : [
                BoxShadow(
                  color: Colors.black.withOpacity(0.03),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
      ),
      child: Stack(
        children: [
          PageView.builder(
            controller: _bannerController,
            onPageChanged: (index) {
              setState(() {
                _currentBanner = index;
              });
            },
            itemCount: _banners.length,
            itemBuilder: (context, index) {
              return _buildBannerSlide(_banners[index], widget.isDark);
            },
          ),

          Positioned(
            right: 20,
            top: 50,
            child: Column(
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
    return Row(
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(10),
            bottomLeft: Radius.circular(10),
          ),
          child: Image.network(content.imageUrl, width: 140, fit: BoxFit.cover),
        ),
        const SizedBox(width: 15),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                const SizedBox(height: 8),
                Text(
                  content.offer,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    height: 1.1,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  content.description,
                  style: TextStyle(
                    color: isDark
                        ? AppColors.darkTextBody
                        : AppColors.lightTextBody,
                    fontSize: 11,
                  ),
                ),
                const SizedBox(height: 15),
                SizedBox(
                  height: 36,
                  child: ElevatedButton(
                    onPressed: () {},
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
        ),
        const SizedBox(width: 40),
      ],
    );
  }

  Widget _buildDot(bool isDark, {required bool isActive}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: 8,
      height: 8,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isActive
            ? AppColors.primary
            : (isDark
                  ? AppColors.darkIndicatorInactive
                  : AppColors.lightIndicatorInactive),
      ),
    );
  }
}
