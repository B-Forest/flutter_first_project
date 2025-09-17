import 'package:first_flutter_project/widgets/form.dart';
import 'package:flutter/material.dart';

class Page2 extends StatelessWidget {
  const Page2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Page 2'),
      ),
      body: Center(
        child: SimpleForm(),
      ),
    );
  }

  Future<String> _getAlbums() async {
    await Future.delayed(const Duration(seconds: 2));
    return 'Data Loaded';
  }
}
