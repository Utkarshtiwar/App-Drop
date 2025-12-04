import 'component_model.dart';

class PageModel {
  final List<ComponentModel> components;

  PageModel({required this.components});

  factory PageModel.fromJson(Map<String, dynamic> json) {
    final comps = <ComponentModel>[];
    if (json['components'] is List) {
      for (final c in json['components'] as List<dynamic>) {
        final map = c as Map<String, dynamic>;
        final model = ComponentModel.fromJson(map);
        if (model != null) comps.add(model);
      }
    }
    return PageModel(components: comps);
  }
}
