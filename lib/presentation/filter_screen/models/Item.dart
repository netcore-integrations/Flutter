import 'package:flutter/material.dart';

class Item {
  final int? id;
  final String? name;
  final IconData? icon;

  const Item({this.id, this.name, this.icon});
}

class StaticData {
  static const List<Item> items = [
    Item(id: 1, name: 'Category', icon: Icons.my_library_books_rounded),
    Item(id: 2, name: 'Subcategory', icon: Icons.menu),
    Item(id: 3, name: 'Keywords', icon: Icons.camera_alt_outlined),
    Item(id: 4, name: 'Brands', icon: Icons.videocam_outlined),
    // Add more items as needed
  ];
}
