# AppDrop - Dynamic Widget Rendering Engine (Flutter)

## Overview
This Flutter project implements a small "schema → UI" engine: a Flutter app that renders an entire page from a JSON description. It supports:
- Image Banner
- Image Carousel
- Image Grid
- Video Player
- Text Block

All UI is generated from JSON; there is no hardcoded layout.

## Project structure
lib/
├─ core/
│ ├─ json_loader.dart
│ └─ widget_factory.dart
├─ models/
│ ├─ page_model.dart
│ └─ component_models.dart
├─ screens/
│ └─ home_screen.dart
├─ widgets/
│ ├─ banner_widget.dart
│ ├─ carousel_widget.dart
│ ├─ grid_widget.dart
│ ├─ video_widget.dart
│ └─ text_widget.dart
assets/
└─ sample.json

## How JSON maps to UI
- `page.components` — list of components
- each component has `type` field: `banner`, `carousel`, `grid`, `video`, `text`
- common properties:
  - `padding` — external wrapper padding (applied as `EdgeInsets.all`)
  - `height` — visual height where applicable
- type-specific props:
  - banner: `image`, `height`, `radius`
  - carousel: `images`, `height`, `autoPlay`, `spacing`
  - grid: `images`, `columns`, `spacing`
  - video: `url`, `autoPlay`, `loop`, `height`
  - text: `value`, `size`, `font`, `weight`, `align`

## How to run
1. `flutter pub get`
2. `flutter run` or build APK `flutter build apk`

## Extending with a new component
1. Add a new model in `component_models.dart` and update the `ComponentModel.fromJson` factory.
2. Create a widget in `widgets/your_widget.dart`.
3. Add mapping to `WidgetFactory.build`.

## Notes & assumptions
- The app uses `cached_network_image`, `carousel_slider`, `video_player`.
- JSON validation is minimal; missing fields use safe defaults.
- Replace sample asset URLs with your own if needed.
