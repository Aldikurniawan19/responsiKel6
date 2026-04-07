import 'dart:async';
import 'package:flutter/material.dart';
import '../../../core/models/product_model.dart';
import 'trending_card_widget.dart';

class TrendingCarouselWidget extends StatefulWidget {
  final List<Product> products;
  final bool isDark;

  const TrendingCarouselWidget({
    super.key,
    required this.products,
    required this.isDark,
  });

  @override
  State<TrendingCarouselWidget> createState() => _TrendingCarouselWidgetState();
}

class _TrendingCarouselWidgetState extends State<TrendingCarouselWidget> {
  final PageController _pageController = PageController(
    viewportFraction: 0.45,
    initialPage: 0,
  );
  Timer? _timer;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (_currentPage < widget.products.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
        _pageController.animateToPage(
          0,
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeInOut,
        );
        return;
      }

      if (_pageController.hasClients) {
        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 260,
      child: PageView.builder(
        controller: _pageController,
        padEnds: false,
        itemCount: widget.products.length,
        onPageChanged: (index) {
          _currentPage = index;
        },
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(left: index == 0 ? 24.0 : 8.0, right: 8.0),
            child: TrendingCardWidget(
              product: widget.products[index],
              isDark: widget.isDark,
            ),
          );
        },
      ),
    );
  }
}
