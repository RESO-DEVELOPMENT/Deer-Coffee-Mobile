import 'package:flutter/material.dart';

class Reward extends StatefulWidget {
  const Reward({Key? key}) : super(key: key);

  @override
  State<Reward> createState() => _RewardState();
}

class _RewardState extends State<Reward> {
  int myCurrentIndex = 0;
  void onTabTapped(int index) {
    setState(() {
      myCurrentIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue,
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
                  icon: Icon(Icons.assignment, size: 40), label: ""),
            ],
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10.0, top: 50),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                SizedBox(width: 100),
                Text(
                  "Tích bean",
                  style: TextStyle(color: Colors.white, fontSize: 20.0,fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8.0, left: 6.0),
                child: Container(
                  padding: EdgeInsets.all(16),
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 40,
                    child: Icon(
                      Icons.person,
                      color: Colors.lightBlue,
                      size: 60,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 6),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'Nguyễn Quốc Kh...',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(width: 6),
                      Text(
                        '|',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 6),
                      Text(
                        'Thành viên',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Icon(
                        Icons
                            .archive_outlined, // Biểu tượng Achievement (thành tích)
                        color: Colors.white,
                        size: 20,
                      ),
                      SizedBox(width: 6),
                      Text(
                        'DRIPS: 0',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.wallet,
                        color: Colors.white,
                        size: 20,
                      ),
                      SizedBox(width: 6),
                      Text(
                        'Trả trước: 0đ',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(
                          width:
                              50), // Khoảng trống giữa nút và "Trả trước: 0đ"
                      ElevatedButton(
                        onPressed: () {
                          // Xử lý sự kiện khi nút "Kích hoạt" được nhấn
                        },
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.all(8), // Điều chỉnh padding
                          minimumSize:
                              Size(0, 0), // Điều chỉnh kích thước tối thiểu
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                8), // Điều chỉnh góc bo tròn
                          ),
                          primary: Colors.white, // Điều chỉnh màu nền
                        ),
                        child: Text(
                          'Kích hoạt',
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 20),
            child: Container(
              width: 350,
              height: 400,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 3,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.center, // Để căn giữa theo chiều ngang
                children: [
                  SizedBox(height: 10),
                  Image.asset(
                    'assets/images/QR.png', // Thay đổi đường dẫn tới tệp ảnh của bạn
                    width: 180, // Điều chỉnh chiều rộng của ảnh
                    height: 180, // Điều chỉnh chiều cao của ảnh
                  ),
                  SizedBox(height: 10),
                  Text(
                    'tự động cập nhật sau: 60s',
                    style: TextStyle(fontSize: 12),
                  ),
                  SizedBox(height: 30),
                  Container(
                    width: 300,
                    height: 110,
                    decoration: BoxDecoration(
                      color: Colors.lightBlue,
                      borderRadius: BorderRadius.circular(
                          20.0), // Điều chỉnh giá trị bán kính để bo góc
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Nguyễn Quốc Khánh',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                'ID: 123246',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          
                        ),
                        SizedBox(height: 20,),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('THÀNH VIÊN', style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
