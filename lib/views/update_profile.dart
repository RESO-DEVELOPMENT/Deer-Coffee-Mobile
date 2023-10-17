import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UpdateProfilePage extends StatefulWidget {
  const UpdateProfilePage({Key? key});

  @override
  _UpdateProfilePageState createState() => _UpdateProfilePageState();
}

class _UpdateProfilePageState extends State<UpdateProfilePage> {
  // Các biến để lưu giá trị nhập
  TextEditingController _hoController = TextEditingController();
  TextEditingController _tenController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  String _selectedGender = 'Nam'; 
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.coffee_outlined), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.store_outlined), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.assignment), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.segment_sharp), label: ''),
        ],
        currentIndex: _currentIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        onTap: _changeItem, // Đổi màu khi nổi lên (chọn)
      ),
      appBar: AppBar(
        title: Row(
          children: [
            Icon(Icons.arrow_back),
            SizedBox(width: 90),
            Text(
              "Cập nhật thông tin",
              style: GoogleFonts.inter( // Đặt font family là 'Inter' cho tiêu đề
                fontSize: 16,
                fontWeight: FontWeight.bold, // Đặt fontWeight
              ),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 18, 
            ),
            Center(
              child: SizedBox(
                height: 104,
                width: 104,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage("assets/images/1.png"),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 2,
                      child: SizedBox(
                        height: 50,
                        width: 50,
                        child: ElevatedButton(
                          onPressed: () {}, // Gọi hàm xử lý khi người dùng bấm vào biểu tượng máy ảnh
                          child: Icon(
                            Icons.camera_alt,
                            color: Colors.black, // Màu biểu tượng
                          ),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.transparent, // Đặt nền của nút là trong suốt
                            elevation: 0, // Loại bỏ bóng đổ
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20,),
            // Họ
            Container(
              height: 70,
              width: double.infinity,
              padding: EdgeInsets.all(10), // Định dạng khoảng cách
              child: TextField(
                controller: _hoController,
                decoration: InputDecoration(
                  labelText: 'Họ',
                  border: OutlineInputBorder(),
                  labelStyle: GoogleFonts.inter( // Đặt font family 'Inter' cho labelText
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: GoogleFonts.inter( // Đặt font family 'Inter' cho nội dung TextField
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            // Tên
            Container(
              height: 70,
              width: double.infinity,
              padding: EdgeInsets.all(10), 
              child: TextField(
                controller: _tenController,
                decoration: InputDecoration(
                  labelText: 'Tên',
                  border: OutlineInputBorder(),
                  labelStyle: GoogleFonts.inter( 
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: GoogleFonts.inter( 
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            // Email
            Container(
              height: 70,
              width: double.infinity,
              padding: EdgeInsets.all(10), 
              child: TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                  labelStyle: GoogleFonts.inter( 
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: GoogleFonts.inter( 
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            
            Container(
              height: 70,
              width: double.infinity,
              padding: EdgeInsets.all(10),
              child: TextFormField(
                readOnly: true,
                onTap: () {
                  // _selectDate(context);
                },
                controller: TextEditingController(
                  text: "Ngày sinh: ${_selectedDate.toLocal()}".split(' ')[0],
                ),
                decoration: InputDecoration(
                  labelText: 'Ngày ',
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.calendar_month),
                  labelStyle: GoogleFonts.inter( 
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: GoogleFonts.inter( 
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
           
            Container(
              height: 80,
              width: double.infinity,
              padding: EdgeInsets.all(10), 
              child: DropdownButtonFormField<String>(
                value: _selectedGender,
                onChanged: (newValue) {
                  setState(() {
                    _selectedGender = newValue!;
                  });
                },
                items: ['Nam', 'Nữ', 'Khác'].map<DropdownMenuItem<String>>(
                  (String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: GoogleFonts.inter( 
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  },
                ).toList(),
                decoration: InputDecoration(
                  labelText: 'Giới tính',
                  border: OutlineInputBorder(),
                  labelStyle: GoogleFonts.inter( 
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10,),
            Container(
              height: 50,
              width: 375,
              child: ElevatedButton(
                onPressed: () {
                 
                },
                child: Text(
                  'Cập Nhật Tài Khoản',
                  style: GoogleFonts.inter( 
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.grey, 
                  textStyle: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            SizedBox(height: 0,),
            Container(
              height: 80,
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      // Xử lý xóa tài khoản ở đây
                    },
                    icon: Icon(Icons.delete_outline),
                  ),
                  SizedBox(width: 0,), 
                  Text(
                    'Xóa tài khoản',
                    style: GoogleFonts.inter( 
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _changeItem(int value) {
    print(value);
    setState(() {
      _currentIndex = value;
    });
  }
}
