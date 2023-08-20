import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StickyBottomWidget extends StatelessWidget {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sticky Bottom Widget Example'),
      ),
      body: ListView.builder(
        controller: _scrollController,
        itemCount: 50,
        itemBuilder: (context, index) {
          return ListTile(title: Text('Item $index'));
        },
      ),
      bottomNavigationBar:
          StickyBottomContainer(scrollController: _scrollController),
    );
  }
}

class StickyBottomContainer extends GetView {
  final ScrollController scrollController;

  const StickyBottomContainer({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    bool showStickyContainer = scrollController.position.pixels ==
        scrollController.position.maxScrollExtent;

    return Visibility(
      visible: showStickyContainer,
      child: Container(
        color: Colors.blue, // Ganti dengan warna atau dekorasi yang sesuai
        height: 50,
        child: Center(
          child: Text(
            'Sticky Container',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(GetMaterialApp(
    home: StickyBottomWidget(),
  ));
}
