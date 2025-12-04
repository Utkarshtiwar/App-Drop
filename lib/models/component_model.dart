import 'package:flutter/material.dart';

abstract class ComponentModel {
  String type;
  double? padding;
  double? height;

  ComponentModel({
    required this.type,
    this.padding,
    this.height,
  });

  /// Factory that returns the correct subclass based on "type" field.
  static ComponentModel? fromJson(Map<String, dynamic> json) {
    final type = (json['type'] as String?)?.toLowerCase().trim();
    if (type == null) return null;

    switch (type) {
      case 'banner':
        return BannerModel.fromJson(json);
      case 'carousel':
        return CarouselModel.fromJson(json);
      case 'grid':
        return GridModel.fromJson(json);
      case 'video':
        return VideoModel.fromJson(json);
      case 'text':
        return TextModel.fromJson(json);
      default:
        return null;
    }
  }
}

/// Banner
class BannerModel extends ComponentModel {
  final String image;
  final double? radius;

  BannerModel({
    required this.image,
    this.radius,
    double? padding,
    double? height,
  }) : super(type: 'banner', padding: padding, height: height);

  factory BannerModel.fromJson(Map<String, dynamic> json) {
    return BannerModel(
      image: json['image'] as String? ?? '',
      radius: (json['radius'] != null) ? (json['radius'] as num).toDouble() : 0.0,
      padding: (json['padding'] != null) ? (json['padding'] as num).toDouble() : 0.0,
      height: (json['height'] != null) ? (json['height'] as num).toDouble() : 180.0,
    );
  }
}

/// Carousel
class CarouselModel extends ComponentModel {
  final List<String> images;
  final bool autoPlay;
  final double spacing;

  CarouselModel({
    required this.images,
    this.autoPlay = false,
    this.spacing = 8.0,
    double? padding,
    double? height,
  }) : super(type: 'carousel', padding: padding, height: height);

  factory CarouselModel.fromJson(Map<String, dynamic> json) {
    final imgs = <String>[];
    if (json['images'] is List) {
      for (final i in json['images'] as List<dynamic>) {
        imgs.add(i.toString());
      }
    }
    return CarouselModel(
      images: imgs,
      autoPlay: json['autoPlay'] == true,
      spacing: (json['spacing'] != null) ? (json['spacing'] as num).toDouble() : 8.0,
      padding: (json['padding'] != null) ? (json['padding'] as num).toDouble() : 8.0,
      height: (json['height'] != null) ? (json['height'] as num).toDouble() : 200.0,
    );
  }
}

/// Grid
class GridModel extends ComponentModel {
  final List<String> images;
  final int columns;
  final double spacing;

  GridModel({
    required this.images,
    this.columns = 2,
    this.spacing = 8.0,
    double? padding,
    double? height,
  }) : super(type: 'grid', padding: padding, height: height);

  factory GridModel.fromJson(Map<String, dynamic> json) {
    final imgs = <String>[];
    if (json['images'] is List) {
      for (final i in json['images'] as List<dynamic>) {
        imgs.add(i.toString());
      }
    }
    return GridModel(
      images: imgs,
      columns: (json['columns'] != null) ? (json['columns'] as num).toInt() : 2,
      spacing: (json['spacing'] != null) ? (json['spacing'] as num).toDouble() : 8.0,
      padding: (json['padding'] != null) ? (json['padding'] as num).toDouble() : 8.0,
    );
  }
}

/// Video
class VideoModel extends ComponentModel {
  final String url;
  final bool autoPlay;
  final bool loop;

  VideoModel({
    required this.url,
    this.autoPlay = false,
    this.loop = false,
    double? padding,
    double? height,
  }) : super(type: 'video', padding: padding, height: height);

  factory VideoModel.fromJson(Map<String, dynamic> json) {
    return VideoModel(
      url: json['url'] as String? ?? '',
      autoPlay: json['autoPlay'] == true,
      loop: json['loop'] == true,
      padding: (json['padding'] != null) ? (json['padding'] as num).toDouble() : 8.0,
      height: (json['height'] != null) ? (json['height'] as num).toDouble() : 200.0,
    );
  }
}

/// Text
class TextModel extends ComponentModel {
  final String value;
  final double size;
  final String? font;
  final String weight;
  final String align;

  TextModel({
    required this.value,
    this.size = 14,
    this.font,
    this.weight = 'normal',
    this.align = 'left',
    double? padding,
    double? height,
  }) : super(type: 'text', padding: padding, height: height);

  factory TextModel.fromJson(Map<String, dynamic> json) {
    return TextModel(
      value: json['value'] as String? ?? '',
      size: (json['size'] != null) ? (json['size'] as num).toDouble() : 14.0,
      font: json['font'] as String?,
      weight: (json['weight'] as String?)?.toLowerCase() ?? 'normal',
      align: (json['align'] as String?)?.toLowerCase() ?? 'left',
      padding: (json['padding'] != null) ? (json['padding'] as num).toDouble() : 8.0,
    );
  }
}
