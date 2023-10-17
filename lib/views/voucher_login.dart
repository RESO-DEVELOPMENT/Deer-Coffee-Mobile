import 'package:flutter/material.dart';

class VoucherLogin extends StatefulWidget {
  const VoucherLogin({Key? key}) : super(key: key);

  @override
  State<VoucherLogin> createState() => _VoucherLoginState();
}

class _VoucherLoginState extends State<VoucherLogin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
      
          return Column(
            children: [
           Container(
            height: 300,
            decoration: BoxDecoration(
              color: Colors.blue,
              image: DecorationImage(image: AssetImage(''))
            ),
           )
            ],
          );
        },
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: VoucherLogin(),
  ));
}
