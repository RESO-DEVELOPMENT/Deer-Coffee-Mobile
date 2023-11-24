import 'package:flutter/material.dart';

class MembershipBenefitsScreen extends StatelessWidget {
  const MembershipBenefitsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Membership Benefits'),
      ),
      body: Column(
        children: [
          ListTile(
            leading: Icon(Icons.star),
            title: Text('Free shipping on all orders'),
          ),
          ListTile(
            leading: Icon(Icons.star),
            title: Text('Exclusive discounts on products'),
          ),
          ListTile(
            leading: Icon(Icons.star),
            title: Text('Early access to new product launches'),
          ),
          ListTile(
            leading: Icon(Icons.star),
            title: Text('24/7 customer support'),
          ),
        ],
      ),
    );
  }
}
