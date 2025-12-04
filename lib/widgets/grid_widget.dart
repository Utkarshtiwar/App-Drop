import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/component_model.dart';


class GridWidget extends StatelessWidget {
  final GridModel model;
  const GridWidget(this.model, {super.key});

  @override
  Widget build(BuildContext context) {
    final images = model.images;
    final columns = (model.columns <= 0) ? 2 : model.columns;
    final spacing = model.spacing;
    // height is optional; we'll let it size naturally.

    if (images.isEmpty) {
      return const SizedBox.shrink();
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: images.length,
      padding: EdgeInsets.zero,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: columns,
        crossAxisSpacing: spacing,
        mainAxisSpacing: spacing,
        childAspectRatio: 1,
      ),
      itemBuilder: (context, index) {
        final url = images[index];
        return ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: CachedNetworkImage(
            imageUrl: url,
            fit: BoxFit.cover,
            placeholder: (context, url) => Container(
              color: Colors.grey.shade200,
              child: const Center(child: CircularProgressIndicator()),
            ),
            errorWidget: (context, url, error) => Container(
              color: Colors.grey.shade200,
              child: const Center(child: Icon(Icons.broken_image)),
            ),
          ),
        );
      },
    );
  }
}
