import 'package:flutter/material.dart';
import '../models/component_model.dart';


class TextBlockWidget extends StatelessWidget {
  final TextModel model;
  const TextBlockWidget(this.model, {super.key});

  TextAlign _mapAlign(String align) {
    switch (align) {
      case 'center':
        return TextAlign.center;
      case 'right':
        return TextAlign.right;
      case 'left':
      default:
        return TextAlign.left;
    }
  }

  FontWeight _mapWeight(String weight) {
    switch (weight) {
      case 'bold':
        return FontWeight.bold;
      case 'w600':
        return FontWeight.w600;
      case 'w500':
        return FontWeight.w500;
      default:
        return FontWeight.normal;
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = model.size;
    final align = _mapAlign(model.align);
    final weight = _mapWeight(model.weight);
    final fontFamily = model.font;

    return Text(
      model.value,
      textAlign: align,
      style: TextStyle(
        fontSize: size,
        fontWeight: weight,
        fontFamily: fontFamily,
        color: Colors.grey.shade900,
      ),
    );
  }
}
