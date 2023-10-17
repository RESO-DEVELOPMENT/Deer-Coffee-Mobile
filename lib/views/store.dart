import 'package:flutter/material.dart';

class Store extends StatefulWidget {
  const Store({Key? key}) : super(key: key);

  @override
  State<Store> createState() => _StoreState();
}

class _StoreState extends State<Store> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 120,
        backgroundColor: Colors.white60,
        elevation: 10,
        automaticallyImplyLeading: false,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Cửa hàng',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
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
                SizedBox(width: 3),
                Container(
                  width: 50,
                  height: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.blue,
                  ),
                  child: IconButton(
                    icon: Icon(
                      Icons.notifications_outlined,
                      color: Colors.white,
                    ),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(50.0),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 250, // Set the desired width
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Tìm kiếm',
                      prefixIcon: Icon(Icons.search),
                      filled: true,
                      fillColor: Colors.grey[300],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Row(
                  children: [
                    Icon(
                      Icons.map,
                      color: Colors.black,
                      size: 20,
                    ),
                    SizedBox(width: 5),
                    Text(
                      'Bản đồ',
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Các cửa hàng khác',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
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
      ),
    );
  }
}
