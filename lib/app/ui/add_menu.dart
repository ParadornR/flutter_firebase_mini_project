import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddMenu extends StatefulWidget {
  final CollectionReference<Map<String, dynamic>> menu;
  const AddMenu({super.key, required this.menu});

  @override
  State<AddMenu> createState() => _AddMenuState();
}

class _AddMenuState extends State<AddMenu> {
  TextEditingController chefController = TextEditingController();
  TextEditingController menuController = TextEditingController();
  TextEditingController igdController = TextEditingController();
  TextEditingController urlController = TextEditingController();

  Future<void> addMenu() async {
    final String chef = chefController.text;
    final String menu = menuController.text;
    final String ingredients = igdController.text;
    final String url = urlController.text;

    if (chef.isNotEmpty &&
        menu.isNotEmpty &&
        ingredients.isNotEmpty &&
        url.isNotEmpty) {
      chefController.clear();
      menuController.clear();
      igdController.clear();
      urlController.clear();

      // เพิ่มข้อมูล
      await widget.menu.add({
        'chef': chef,
        'menu': menu,
        'ingredients': ingredients,
        'url': url,
      });

      log('เพิ่มข้อมูล');
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('กรุณากรอกข้อมูลให้ครบถ้วน')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Menu"), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Chef Name'),
            TextField(
              controller: chefController,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 8),
            Text('Menu Name'),
            TextField(
              controller: menuController,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 8),
            Text('Ingredients'),
            TextField(
              controller: igdController,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 8),
            Text('Url image'),
            TextField(
              controller: urlController,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  addMenu();
                },
                child: Text("Add Menu To Data"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
