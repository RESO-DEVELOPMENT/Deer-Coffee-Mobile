import 'dart:io' as io;
import 'package:deer_coffee/enums/view_status.dart';
import 'package:deer_coffee/models/user.dart';
import 'package:deer_coffee/models/user_create.dart';
import 'package:deer_coffee/utils/theme.dart';
import 'package:deer_coffee/view_models/account_view_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pinput/pinput.dart';
import 'package:scoped_model/scoped_model.dart';

class UpdateProfilePage extends StatefulWidget {
  const UpdateProfilePage({super.key});

  @override
  _UpdateProfilePageState createState() => _UpdateProfilePageState();
}

class _UpdateProfilePageState extends State<UpdateProfilePage> {
  // Các biến để lưu giá trị nhập
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  String _selectedGender = 'ORTHER';
  String? downloadURL;
  UserDetails? user;

  @override
  void initState() {
    user = Get.find<AccountViewModel>().memberShipModel;
    _nameController.setText(user?.fullName ?? '');
    _emailController.setText(user?.email ?? '');
    _phoneController.setText(user?.phoneNumber ?? '');
    _selectedGender = user?.gender ?? 'ORTHER';
    downloadURL = user?.urlImg;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Thông tin người dùng",
            style: Get.textTheme.titleMedium
                ?.copyWith(fontWeight: FontWeight.bold)),
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
              child: Text("Không có thông tin người dùng"),
            );
          }
          return SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 18,
                ),
                // Center(
                //   child: SizedBox(
                //     height: 104,
                //     width: 104,
                //     child: Stack(
                //       fit: StackFit.expand,
                //       children: [
                //         CircleAvatar(
                //           backgroundImage: NetworkImage(downloadURL ?? ""),
                //         ),
                //         Positioned(
                //           bottom: 0,
                //           right: 2,
                //           child: SizedBox(
                //             height: 50,
                //             width: 50,
                //             child: ElevatedButton(
                //               onPressed: _pickImage,
                //               style: ElevatedButton.styleFrom(
                //                 backgroundColor: Colors
                //                     .transparent, // Đặt nền của nút là trong suốt
                //                 elevation: 0, // Loại bỏ bóng đổ
                //               ), // Gọi hàm xử lý khi người dùng bấm vào biểu tượng máy ảnh
                //               child: Icon(Icons.camera_alt,
                //                   color: ThemeColor.primary // Màu biểu tượng
                //                   ),
                //             ),
                //           ),
                //         ),
                //       ],
                //     ),
                //   ),
                // ),

                // Tên
                Container(
                  height: 50,
                  width: double.infinity,
                  margin: EdgeInsets.all(8),
                  child: TextField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelText: 'Họ và tên',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      prefixIcon: Icon(Icons.person),
                    ),
                  ),
                ),
                Container(
                  height: 50,
                  width: double.infinity,
                  margin: EdgeInsets.all(8),
                  child: TextField(
                    readOnly: true,
                    controller: _phoneController,
                    decoration: InputDecoration(
                      labelText: "Số điện thoại",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      prefixIcon: Icon(Icons.phone),
                    ),
                  ),
                ),
                // Email
                Container(
                  height: 50,
                  width: double.infinity,
                  margin: EdgeInsets.all(8),
                  child: TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      prefixIcon: Icon(Icons.email),
                    ),
                  ),
                ),
                Container(
                  height: 60,
                  width: double.infinity,
                  margin: EdgeInsets.all(8),
                  child: DropdownButtonFormField<String>(
                    value: _selectedGender,
                    onChanged: (newValue) {
                      setState(() {
                        _selectedGender = newValue!;
                      });
                    },
                    items: ['MALE', 'FEMALE', 'ORTHER']
                        .map<DropdownMenuItem<String>>(
                      (String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value == "MALE"
                                ? "Nam"
                                : value == "FEMALE"
                                    ? 'Nữ'
                                    : "Khác",
                          ),
                        );
                      },
                    ).toList(),
                    decoration: InputDecoration(
                      labelText: 'Giới tính',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () async {
                      UserUpdate userUpdate = UserUpdate(
                          fullName: _nameController.text,
                          gender: _selectedGender,
                          email: _emailController.text,
                          urlImg: downloadURL);
                      await model.updateUser(userUpdate, user?.id ?? '');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ThemeColor.primary,
                      textStyle: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    child: Text('Cập Nhật Thông tin',
                        style: Get.textTheme.bodyMedium
                            ?.copyWith(color: Colors.white)),
                  ),
                ),
                // Container(
                //   height: 80,
                //   width: double.infinity,
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.center,
                //     crossAxisAlignment: CrossAxisAlignment.center,
                //     children: [
                //       IconButton(
                //         onPressed: () {
                //           // Xử lý xóa tài khoản ở đây
                //         },
                //         icon: Icon(Icons.delete_outline),
                //       ),
                //       SizedBox(
                //         width: 0,
                //       ),
                //       Text(
                //         'Xóa tài khoản',
                //         style: GoogleFonts.inter(
                //           fontWeight: FontWeight.bold,
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
              ],
            ),
          );
        }),
      ),
    );
  }

  // void _pickImage() async {
  //   io.File? image = await pickImage();
  //   if (image != null) {
  //     await uploadImage(image);
  //   }
  // }

  Future<io.File?> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      return io.File(pickedFile.path);
    } else {
      if (kDebugMode) {
        print('No image selected.');
      }
      return null;
    }
  }

  // Future<UploadTask?> uploadImage(io.File imageFile) async {
  //   try {
  //     UploadTask uploadTask;
  //     String fileName = DateTime.now().millisecondsSinceEpoch.toString();
  //     Reference reference =
  //         FirebaseStorage.instance.ref().child('files').child('/$fileName.jpg');

  //     final metadata = SettableMetadata(
  //       contentType: 'image/jpeg',
  //       customMetadata: {'files': imageFile.path},
  //     );
  //     if (GetPlatform.isWeb) {
  //       uploadTask = reference.putData(await imageFile.readAsBytes(), metadata);
  //     } else {
  //       uploadTask = reference.putFile(io.File(imageFile.path), metadata);
  //     }
  //     final url = await reference.getDownloadURL();
  //     setState(() {
  //       downloadURL = url;
  //     });

  //     print('Image uploaded. Download URL: $url');
  //   } catch (e) {
  //     print('Error uploading image: $e');
  //   }
  // }
}
