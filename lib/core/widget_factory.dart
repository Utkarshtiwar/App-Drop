import 'package:flutter/material.dart';
import '../models/component_model.dart';
import '../widgets/banner.dart';
import '../widgets/carousel_widget.dart';
import '../widgets/grid_widget.dart';
import '../widgets/video_widget.dart';
import '../widgets/text_widget.dart';

class WidgetFactory {
  /// Builds widget from ComponentModel and wraps with padding if provided.
  static Widget build(ComponentModel model) {
    Widget inner;
    switch (model.type) {
      case 'banner':
        inner = BannerWidget(model as BannerModel);
        break;
      case 'carousel':
        inner = CarouselWidget(model as CarouselModel);
        break;
      case 'grid':
        inner = GridWidget(model as GridModel);
        break;
      case 'video':
        inner = VideoWidget(model as VideoModel);
        break;
      case 'text':
        inner = TextBlockWidget(model as TextModel);
        break;
      default:
        inner = const SizedBox.shrink();
    }

    final pad = model.padding ?? 0.0;
    return Padding(
      padding: EdgeInsets.all(pad),
      child: inner,
    );
  }
}
