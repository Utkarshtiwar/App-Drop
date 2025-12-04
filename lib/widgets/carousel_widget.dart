import 'dart:async';
import 'package:flutter/material.dart';

import '../models/component_model.dart';


class CarouselWidget extends StatefulWidget {
  final CarouselModel model;

  const CarouselWidget(this.model, {super.key});

  @override
  State<CarouselWidget> createState() => _CarouselWidgetState();
}

class _CarouselWidgetState extends State<CarouselWidget> {
  late final PageController _pageController;
  int _currentIndex = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.9);

    if (widget.model.autoPlay) {
      _timer = Timer.periodic(const Duration(seconds: 3), (_) {
        if (_pageController.hasClients) {
          final next = (_currentIndex + 1) % widget.model.images.length;
          _pageController.animateToPage(
            next,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        }
      });
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final images = widget.model.images;
    final height = widget.model.height ?? 200.0;
    final spacing = widget.model.spacing;

    return Column(
      children: [
        SizedBox(
          height: height,
          child: PageView.builder(
            controller: _pageController,
            itemCount: images.length,
            onPageChanged: (index) => setState(() => _currentIndex = index),
            itemBuilder: (context, index) {
              final url = images[index];
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: spacing),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    url,
                    fit: BoxFit.cover,
                    loadingBuilder: (_, child, progress) =>
                    progress == null
                        ? child
                        : const Center(child: CircularProgressIndicator()),
                    errorBuilder: (_, __, ___) =>
                    const Center(child: Icon(Icons.broken_image)),
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            images.length,
                (index) => AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: _currentIndex == index ? 10 : 6,
              height: 6,
              margin: const EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                color: _currentIndex == index
                    ? Colors.indigo
                    : Colors.grey.shade400,
                borderRadius: BorderRadius.circular(3),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
