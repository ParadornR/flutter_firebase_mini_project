import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Detail extends StatefulWidget {
  final String id;
  final Map<String, dynamic> data;
  const Detail({super.key, required this.id, required this.data});

  @override
  State<Detail> createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  final menu = FirebaseFirestore.instance.collection('foodMenu');
  // ลบข้อมูล
  Future<void> deleteUser(String docId) {
    return menu.doc(docId).delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              deleteUser(widget.id);
              Navigator.pop(context);
            },
            icon: Icon(Icons.delete),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.3,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: Colors.grey.shade300,
                  strokeAlign: BorderSide.strokeAlignOutside,
                ),
              ),
              child: Image.network(
                widget.data['url'],
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(child: CircularProgressIndicator());
                },
                errorBuilder: (context, error, stackTrace) {
                  return Center(child: Icon(Icons.error));
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 8),
                  Text(widget.data["chef"], style: TextStyle(fontSize: 16)),
                  SizedBox(height: 8),
                  Text(
                    widget.data["menu"],
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    widget.data["ingredients"],
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
