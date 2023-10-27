import 'package:flutter/material.dart';

class Delivering extends StatefulWidget {
  const Delivering({Key? key});

  @override
  State<Delivering> createState() => _DeliveringState();
}

class _DeliveringState extends State<Delivering> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Đơn Hàng'),
          centerTitle: true,
          bottom: TabBar(
            tabs: [
              Tab(text: 'Đang giao'),
              Tab(text: 'Lịch sử'),
            ],
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: TabBarView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 40, left: 10, right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('24 June | 12:30 PM',
                          style: TextStyle(color: Colors.grey)),
                      Text('\$3.00',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Row(
                    children: [
                      Icon(Icons.local_cafe,
                          color: Colors.brown, size: 16), // Biểu tượng cafe
                      SizedBox(width: 5),
                      Text('Flat white',
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Row(
                    children: [
                      Icon(Icons.location_on,
                          color: Colors.grey, size: 16), // Biểu tượng vị trí
                      SizedBox(width: 5),
                      Text(
                        '3 addresion Court Chino Hills, HO56824, United States',
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Divider(
                  color: Colors.grey[300],
                  thickness: 1,
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('25 June | 1:30 PM',
                          style: TextStyle(color: Colors.grey)),
                      Text('\$3.00',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Row(
                    children: [
                      Icon(Icons.local_cafe,
                          color: Colors.brown, size: 16), // Biểu tượng cafe
                      SizedBox(width: 5),
                      Text('Cappuccino',
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Row(
                    children: [
                      Icon(Icons.location_on, color: Colors.grey, size: 16),
                      SizedBox(width: 5),
                      Text(
                        '5 Elm Street San Diego, CA 12345, United States',
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Divider(
                  color: Colors.grey[300],
                  thickness: 1,
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('26 June | 2:00 PM',
                          style: TextStyle(color: Colors.grey)),
                      Text('\$3.00',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Row(
                    children: [
                      Icon(Icons.local_cafe, color: Colors.brown, size: 16),
                      SizedBox(width: 5),
                      Text('Espresso',
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Row(
                    children: [
                      Icon(Icons.location_on, color: Colors.grey, size: 16),
                      SizedBox(width: 5),
                      Text(
                        '123 Main Street New York, NY 10001, United States',
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Divider(
                  color: Colors.grey[300],
                  thickness: 1,
                ),
                SizedBox(height: 10),
                // Thêm dòng giống
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 40, left: 10, right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('24 June | 12:30 PM',
                          style: TextStyle(color: Colors.grey)),
                      Text('\$3.00',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey)),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Row(
                    children: [
                      Icon(Icons.local_cafe,
                          color: Colors.grey, size: 16), // Biểu tượng cafe
                      SizedBox(width: 5),
                      Text('Flat white',
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey)),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Row(
                    children: [
                      Icon(Icons.location_on,
                          color: Colors.grey, size: 16), // Biểu tượng vị trí
                      SizedBox(width: 5),
                      Text(
                        '3 addresion Court Chino Hills, HO56824, United States',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Divider(
                  color: Colors.grey[300],
                  thickness: 1,
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('25 June | 1:30 PM',
                          style: TextStyle(color: Colors.grey)),
                      Text('\$3.00',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey)),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Row(
                    children: [
                      Icon(Icons.local_cafe,
                          color: Colors.grey, size: 16), // Biểu tượng cafe
                      SizedBox(width: 5),
                      Text('Cappuccino',
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey)),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Row(
                    children: [
                      Icon(Icons.location_on, color: Colors.grey, size: 16),
                      SizedBox(width: 5),
                      Text(
                        '5 Elm Street San Diego, CA 12345, United States',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Divider(
                  color: Colors.grey[300],
                  thickness: 1,
                ),
                SizedBox(height: 10),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
