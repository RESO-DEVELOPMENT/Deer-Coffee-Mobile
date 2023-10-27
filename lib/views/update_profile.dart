import 'package:deer_coffee/enums/view_status.dart';
import 'package:deer_coffee/models/user.dart';
import 'package:deer_coffee/view_models/account_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';
import 'package:scoped_model/scoped_model.dart';

class UpdateProfilePage extends StatefulWidget {
  const UpdateProfilePage({Key? key});

  @override
  _UpdateProfilePageState createState() => _UpdateProfilePageState();
}

class _UpdateProfilePageState extends State<UpdateProfilePage> {
  // Các biến để lưu giá trị nhập
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  String _selectedGender = 'Nam';
  UserModel? user;

  @override
  void initState() {
    user = Get.find<AccountViewModel>().user;
    _nameController.setText(user?.userInfo?.fullName ?? '');
    _emailController.setText(user?.userInfo?.email ?? '');
    _phoneController.setText(user?.userInfo?.phoneNumber ?? '');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cập nhật thông tin", style: Get.textTheme.titleLarge),
        centerTitle: true,
      ),
      body: ScopedModel<AccountViewModel>(
        model: Get.find<AccountViewModel>(),
        child: ScopedModelDescendant<AccountViewModel>(
            builder: (context, build, model) {
          if (model.status == ViewStatus.Loading) {
            return Center(child: CircularProgressIndicator());
          }

          if (user == null) {
            return Center(
              child: Text("Không có user"),
            );
          }
          return SingleChildScrollView(
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
                          backgroundImage:
                              NetworkImage(user?.userInfo?.urlImg ?? ""),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 2,
                          child: SizedBox(
                            height: 50,
                            width: 50,
                            child: ElevatedButton(
                              onPressed:
                                  () {}, // Gọi hàm xử lý khi người dùng bấm vào biểu tượng máy ảnh
                              child: Icon(
                                Icons.camera_alt,
                                color: Colors.black, // Màu biểu tượng
                              ),
                              style: ElevatedButton.styleFrom(
                                primary: Colors
                                    .transparent, // Đặt nền của nút là trong suốt
                                elevation: 0, // Loại bỏ bóng đổ
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                // Họ

                // Tên
                Container(
                  height: 70,
                  width: double.infinity,
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelText: 'Họ và tên',
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
                  child: TextField(
                    readOnly: true,
                    controller: _phoneController,
                    decoration: InputDecoration(
                      labelText: 'Họ và tên',
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

                // Container(
                //   height: 70,
                //   width: double.infinity,
                //   padding: EdgeInsets.all(10),
                //   child: TextFormField(
                //     readOnly: true,
                //     onTap: () {
                //       // _selectDate(context);
                //     },
                //     controller: TextEditingController(
                //       text:
                //           "Ngày sinh: ${_selectedDate.toLocal()}".split(' ')[0],
                //     ),
                //     decoration: InputDecoration(
                //       labelText: 'Ngày ',
                //       border: OutlineInputBorder(),
                //       suffixIcon: Icon(Icons.calendar_month),
                //       labelStyle: GoogleFonts.inter(
                //         fontWeight: FontWeight.bold,
                //       ),
                //     ),
                //     style: GoogleFonts.inter(
                //       fontWeight: FontWeight.bold,
                //     ),
                //   ),
                // ),

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
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 50,
                  width: 375,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      'Cập Nhật Tài Khoản',
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Color.fromARGB(255, 230, 230, 230),
                      textStyle: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 0,
                ),
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
                      SizedBox(
                        width: 0,
                      ),
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
          );
        }),
      ),
    );
  }
}
