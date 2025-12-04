import 'package:flutter/material.dart';
import '../core/json_loader.dart';
import '../core/widget_factory.dart';
import '../models/page_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<PageModel> _pageFuture;

  @override
  void initState() {
    super.initState();
    _pageFuture = JsonLoader.loadPageFromAsset('assets/sample.json');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dynamic JSON → UI Renderer'),
      ),
      body: FutureBuilder<PageModel>(
        future: _pageFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error loading page: ${snapshot.error}'));
          }
          final page = snapshot.data!;
          if (page.components.isEmpty) {
            return const Center(child: Text('No components found in JSON'));
          }
          return SafeArea(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: page.components.length,
              itemBuilder: (context, index) {
                final comp = page.components[index];
                return WidgetFactory.build(comp);
              },
            ),
          );
        },
      ),
    );
  }
}
