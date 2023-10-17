import 'package:flutter/material.dart';

class availableReward extends StatefulWidget {
  const availableReward({super.key});

  @override
  State<availableReward> createState() => _availableRewardState();
}

class _availableRewardState extends State<availableReward> {
  int quantityContainer1 = 0;
  int quantityContainer2 = 0;
  int quantityContainer3 = 0;
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
  
   void incrementQuantityContainer3() {
    setState(() {
      quantityContainer3++;
    });
  }

  void decrementQuantityContainer3() {
    if (quantityContainer3 > 0) {
      setState(() {
        quantityContainer3--;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        toolbarHeight: 60.0,
        backgroundColor: Colors.white,
        elevation: 10.0,
        title: Center(
          child: Text(
            'Phần thường khả dụng',
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
       
      ),
      body: Container(
        color: Color(0xFFF5F5F5),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Sẵn sàng sử dụng',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                  ],
                ),
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
                                        onPressed: decrementQuantityContainer3,
                                      ),
                                    ),
                                    SizedBox(
                                        width:
                                            15), // Điều chỉnh khoảng cách khi cần thiết
                                    Text(
                                      '$quantityContainer3',
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
                                              incrementQuantityContainer3,
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
                ],
              ),
            ],
          ),
        ),
      ),
   );
  }
}