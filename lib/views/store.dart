import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';

class Store extends StatefulWidget {
  const Store({Key? key}) : super(key: key);

  @override
  State<Store> createState() => _StoreState();
}

class _StoreState extends State<Store> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      "Cửa hàng",
                      style: Get.textTheme.titleLarge
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      width: 55,
                      height: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(13),
                        color: Colors.blue,
                      ),
                      child: IconButton(
                        icon: Icon(
                          Icons.confirmation_num_outlined,
                          color: Colors.white,
                        ),
                        onPressed: () {},
                      ),
                    ),
                    SizedBox(width: 03),
                    Container(
                      width: 50,
                      height: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.blue,
                      ),
                      child: IconButton(
                        icon: Icon(
                          Ionicons.notifications_outline,
                          color: Colors.white,
                        ),
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 10),
            Card(
              margin: EdgeInsets.all(10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(
                    20), // Set border radius to round the corners
                child: Container(
                  width: 500, // Set the desired width
                  height: 120, // Set the desired height
                  padding: EdgeInsets.all(10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Image widget here
                      Container(
                        width: 80, // Set the desired width for the image
                        height: 80, // Set the desired height for the image
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage(
                                'assets/images/deercoffee-logopage-0001-2.png'), // Replace with the actual image path
                          ),
                        ),
                      ),
                      SizedBox(
                          width:
                              10), // Add some space between the image and text
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Deer Coffee',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18)),
                          SizedBox(height: 5),
                          Text('1 Nguyễn Xiễn'),
                          SizedBox(height: 20),
                          Text('Đang mở'),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Card(
              margin: EdgeInsets.all(10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(
                    20), // Set border radius to round the corners
                child: Container(
                  width: 500, // Set the desired width
                  height: 120, // Set the desired height
                  padding: EdgeInsets.all(10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Image widget here
                      Container(
                        width: 80, // Set the desired width for the image
                        height: 80, // Set the desired height for the image
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage(
                                'path_to_your_image'), // Replace with the actual image path
                          ),
                        ),
                      ),
                      SizedBox(
                          width:
                              10), // Add some space between the image and text
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Deer Coffee',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18)),
                          SizedBox(height: 5),
                          Text('1 Nguyễn Xiễn'),
                          SizedBox(height: 20),
                          Text('Đang mở'),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Card(
              margin: EdgeInsets.all(10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(
                    20), // Set border radius to round the corners
                child: Container(
                  width: 500, // Set the desired width
                  height: 120, // Set the desired height
                  padding: EdgeInsets.all(10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Image widget here
                      Container(
                        width: 80, // Set the desired width for the image
                        height: 80, // Set the desired height for the image
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage(
                                'path_to_your_image'), // Replace with the actual image path
                          ),
                        ),
                      ),
                      SizedBox(
                          width:
                              10), // Add some space between the image and text
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Deer Coffee',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18)),
                          SizedBox(height: 5),
                          Text('1 Nguyễn Xiễn'),
                          SizedBox(height: 20),
                          Text('Đang mở'),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
