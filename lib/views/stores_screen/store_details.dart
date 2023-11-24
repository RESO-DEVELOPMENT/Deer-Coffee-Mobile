import 'package:flutter/material.dart';

class StoreDetailScreen extends StatefulWidget {
  final String id;
  const StoreDetailScreen({super.key, required this.id});

  @override
  _StoreDetailScreenState createState() => _StoreDetailScreenState();
}

class _StoreDetailScreenState extends State<StoreDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Store Detail'),
      ),
      body: const Column(
        children: [
          Expanded(child: Center()),
          SizedBox(height: 16),
          Text(
            'Store Name',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Store Address',
            style: TextStyle(
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
