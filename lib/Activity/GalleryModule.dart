import 'package:flutter/material.dart';

class GalleryModule extends StatefulWidget {
  const GalleryModule({super.key});

  @override
  State<GalleryModule> createState() => _GalleryModuleState();
}

class _GalleryModuleState extends State<GalleryModule> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gallery Module'),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.camera_alt),
        onPressed: () {},
      ),
    );
  }
}
