import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/component_model.dart';


class BannerWidget extends StatelessWidget {
  final BannerModel model;
  const BannerWidget(this.model, {super.key});

  @override
  Widget build(BuildContext context) {
    final radius = model.radius ?? 0.0;
    final height = model.height ?? 180.0;
    final imageUrl = model.image;

    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: Container(
        height: height,
        width: double.infinity,
        color: Colors.grey.shade200,
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          fit: BoxFit.cover,
          width: double.infinity,
          placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
          errorWidget: (context, url, error) => const Center(child: Icon(Icons.broken_image)),
        ),
      ),
    );
  }
}
