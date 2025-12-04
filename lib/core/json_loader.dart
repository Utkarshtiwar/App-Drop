import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import '../models/page_model.dart';

class JsonLoader {

  static Future<PageModel> loadPageFromAsset(String assetPath) async {
    final raw = await rootBundle.loadString(assetPath);
    final Map<String, dynamic> data = json.decode(raw) as Map<String, dynamic>;
    return PageModel.fromJson(data['page'] as Map<String, dynamic>);
  }


  static PageModel pageFromString(String rawJson) {
    final Map<String, dynamic> data = json.decode(rawJson) as Map<String, dynamic>;
    return PageModel.fromJson(data['page'] as Map<String, dynamic>);
  }
}
