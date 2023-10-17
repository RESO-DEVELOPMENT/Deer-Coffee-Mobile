import 'package:flutter/material.dart';

class Drip extends StatefulWidget {
  const Drip({Key? key}) : super(key: key);

  @override
  State<Drip> createState() => _DripState();
}

class _DripState extends State<Drip> {
  int quantityContainer1 = 0;
  int quantityContainer2 = 0;
  int myCurrentIndex = 0;

  void incrementQuantityContainer1() {
    setState(() {
      quantityContainer1++;
    });
  }

  void decrementQuantityContainer1() {
    if (quantityContainer1 > 0) {
      setState(() {
        quantityContainer1--;
      });
    }
  }

  void incrementQuantityContainer2() {
    setState(() {
      quantityContainer2++;
    });
  }

  void decrementQuantityContainer2() {
    if (quantityContainer2 > 0) {
      setState(() {
        quantityContainer2--;
      });
    }
  }

  void onTabTapped(int index) {
    setState(() {
      myCurrentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60.0,
        backgroundColor: Colors.white,
        elevation: 10.0,
        title: Center(
          child: Text(
            'Đổi Drips',
            style: TextStyle(
              color: Colors.black,
              fontSize: 20.0,
            ),
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.check,
              color: Colors.black,
            ),
            onPressed: () {
              // Xử lý sự kiện nút kiểm tra
            },
          ),
        ],
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black,
              blurRadius: 25,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: BottomNavigationBar(
            backgroundColor: Colors.white,
            selectedItemColor: Colors.black,
            unselectedItemColor: Colors.grey,
            currentIndex: myCurrentIndex,
            onTap: onTabTapped,
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home, size: 40), label: ""),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person_outline, size: 40), label: ""),
              BottomNavigationBarItem(
                  icon: Icon(Icons.note, size: 40), label: ""),
            ],
          ),
        ),
      ),
      body: Container(
        color: Color(0xFFF5F5F5),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'DRIPS',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Card(
                margin: const EdgeInsets.all(
                  12.0, // Điều chỉnh lề xung quanh Card
                ),
                child: Container(
                  width: 400.0, // Điều chỉnh chiều rộng của Container
                  height: 140.0, // Điều chỉnh chiều cao của Container
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Phần thưởng khả dụng',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25.0),
                      color: Colors.white,
                    ),
                    child: DropdownButton<String>(
                      items: <String?>[null, 'Option 1', 'Option 2', 'Option 3']
                          .map((String? value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value ?? 'Xem tất cả',
                            style: TextStyle(color: Colors.lightBlue),
                          ),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        if (newValue != null) {
                          // Xử lý khi lựa chọn một tùy chọn trong Dropdown
                        }
                      },
                      underline:
                          Container(), // Loại bỏ đường gạch dưới DropdownButton
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    color: Colors.white,
                    margin: EdgeInsets.all(10),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Container(
                        width: 500,
                        height: 180,
                        padding: EdgeInsets.all(10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 110,
                              height: 100,
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage('path_to_your_image1'),
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Text(
                                    '20 Drips = 5000đ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18
                                    ),
                                  ),
                                ),
                                
                                SizedBox(height: 70),
                                Row(
                                  children: [
                                    Container(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(0),
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey,
                                            blurRadius: 5.0,
                                          ),
                                        ],
                                      ),
                                      child: Center(
                                        child: IconButton(
                                          icon: Icon(Icons.remove),
                                          color: Colors.lightBlue,
                                          onPressed:
                                              decrementQuantityContainer1,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                        width:
                                            15), // Điều chỉnh khoảng cách khi cần thiết
                                    Text(
                                      '$quantityContainer1',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.lightBlue,
                                      ),
                                    ),
                                    SizedBox(width: 15),
                                    Container(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(0),
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey,
                                            blurRadius: 5.0,
                                          ),
                                        ],
                                      ),
                                      child: Center(
                                        child: IconButton(
                                          icon: Icon(Icons.add),
                                          color: Colors.lightBlue,
                                          onPressed:
                                              incrementQuantityContainer1,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                        width:
                                            80), // Điều chỉnh khoảng cách khi cần thiết
                                    GestureDetector(
                                      onTap: () {
                                        // Xử lý khi chữ "đổi" được nhấn
                                        // Thêm mã xử lý ở đây, ví dụ: gọi hàm hoặc thực hiện một hành động nào đó
                                      },
                                      child: Text(
                                        'đổi',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.lightBlue,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    color: Colors.white,
                    margin: EdgeInsets.all(10),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Container(
                        width: 500,
                        height: 180,
                        padding: EdgeInsets.all(10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 110,
                              height: 110,
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage('path_to_your_image2'),
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Text(
                                    '20 DRIPS = 5000đ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                                Divider(
                                  height: 20.0,
                                  thickness: 2.0,
                                  color: Colors.grey,
                                ),
                                SizedBox(height: 50),
                                Row(
                                  children: [
                                    Container(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(0),
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey,
                                            blurRadius: 5.0,
                                          ),
                                        ],
                                      ),
                                      child: IconButton(
                                        icon: Icon(Icons.remove),
                                        color: Colors.lightBlue,
                                        onPressed: decrementQuantityContainer2,
                                      ),
                                    ),
                                    SizedBox(
                                        width:
                                            15), // Điều chỉnh khoảng cách khi cần thiết
                                    Text(
                                      '$quantityContainer2',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.lightBlue,
                                      ),
                                    ),
                                    SizedBox(width: 15),
                                    Container(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(0),
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey,
                                            blurRadius: 5.0,
                                          ),
                                        ],
                                      ),
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(right: 20),
                                        child: IconButton(
                                          icon: Icon(Icons.add),
                                          color: Colors.lightBlue,
                                          onPressed:
                                              incrementQuantityContainer2,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                        width:
                                            80), // Điều chỉnh khoảng cách khi cần thiết
                                    GestureDetector(
                                      onTap: () {
                                        // Xử lý khi chữ "đổi" được nhấn
                                        // Thêm mã xử lý ở đây, ví dụ: gọi hàm hoặc thực hiện một hành động nào đó
                                      },
                                      child: Text(
                                        'đổi',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.lightBlue,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: Drip(),
  ));
}
