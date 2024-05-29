import 'dart:io' as io;

import 'package:deer_coffee/enums/view_status.dart';
import 'package:deer_coffee/models/pointify/membership_info.dart';
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
  String? _selectedGender = "3";
  MembershipInfo? user;
  int? gender;

  @override
  void initState() {
    user = Get.find<AccountViewModel>().memberShipModel;
    _nameController.setText(user?.fullname ?? '');
    _emailController.setText(user?.email ?? '');
    _phoneController.setText(user?.phoneNumber ?? '');
    _selectedGender = user?.gender.toString() ?? "3";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Thông tin cá nhân",
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
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: Get.width * 0.1,
                    vertical: 15.0,
                  ),
                  child: TextFormField(
                    controller: _nameController,
                    keyboardType: TextInputType.name,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: InputDecoration(
                      labelText: 'Họ và tên',
                      prefixIcon: const Icon(Icons.person),
                      suffixIcon: IconButton(
                        onPressed: () {
                          _nameController.clear();
                        },
                        icon: const Icon(Icons.clear),
                      ),
                      hintStyle: Get.textTheme.bodyMedium,
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      filled: true,
                      isDense: true,
                      labelStyle: Get.textTheme.labelLarge,
                      fillColor: Get.theme.colorScheme.background,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: ThemeColor.primary,
                          width: 2.0,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: ThemeColor.primary,
                          width: 2.0,
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: ThemeColor.primary,
                          width: 2.0,
                        ),
                      ),
                      contentPadding: const EdgeInsets.all(16),
                      isCollapsed: true,
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: Get.theme.colorScheme.error,
                          width: 2.0,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: Get.width * 0.1,
                    vertical: 15.0,
                  ),
                  child: TextFormField(
                    readOnly: true,
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: InputDecoration(
                      labelText: 'Số điện thoại',
                      prefixIcon: const Icon(Icons.phone),
                      suffixIcon: IconButton(
                        onPressed: () {
                          _nameController.clear();
                        },
                        icon: const Icon(Icons.clear),
                      ),
                      hintStyle: Get.textTheme.bodyMedium,
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      filled: true,
                      isDense: true,
                      labelStyle: Get.textTheme.labelLarge,
                      fillColor: Get.theme.colorScheme.background,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: ThemeColor.primary,
                          width: 2.0,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: ThemeColor.primary,
                          width: 2.0,
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: ThemeColor.primary,
                          width: 2.0,
                        ),
                      ),
                      contentPadding: const EdgeInsets.all(16),
                      isCollapsed: true,
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: Get.theme.colorScheme.error,
                          width: 2.0,
                        ),
                      ),
                    ),
                  ),
                ),
                // Email
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: Get.width * 0.1,
                    vertical: 15.0,
                  ),
                  child: TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: InputDecoration(
                      labelText: 'E-mail',
                      prefixIcon: const Icon(Icons.email),
                      suffixIcon: IconButton(
                        onPressed: () {
                          _nameController.clear();
                        },
                        icon: const Icon(Icons.clear),
                      ),
                      hintStyle: Get.textTheme.bodyMedium,
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      filled: true,
                      isDense: true,
                      labelStyle: Get.textTheme.bodyLarge,
                      fillColor: Get.theme.colorScheme.background,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: ThemeColor.primary,
                          width: 2.0,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: ThemeColor.primary,
                          width: 2.0,
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: ThemeColor.primary,
                          width: 2.0,
                        ),
                      ),
                      contentPadding: const EdgeInsets.all(16),
                      isCollapsed: true,
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: Get.theme.colorScheme.error,
                          width: 2.0,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: Get.width * 0.1,
                    vertical: 15.0,
                  ),
                  child: Container(
                    child: DropdownButtonFormField<String>(
                      value: _selectedGender,
                      onChanged: (newValue) {
                        setState(() {
                          _selectedGender = newValue;
                        });
                      },
                      items: ['1', '2', '3'].map<DropdownMenuItem<String>>(
                        (String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              (value == '1')
                                  ? 'Nam'
                                  : (value == '2')
                                      ? 'Nữ'
                                      : 'Khác',
                              style: Get.textTheme.bodyMedium,
                            ),
                          );
                        },
                      ).toList(),
                      decoration: InputDecoration(
                        labelText: 'Giới tính',
                        hintStyle: Get.textTheme.bodyMedium,
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        filled: true,
                        isDense: true,
                        labelStyle: Get.textTheme.labelLarge,
                        fillColor: Get.theme.colorScheme.background,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            color: ThemeColor.primary,
                            width: 2.0,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            color: ThemeColor.primary,
                            width: 2.0,
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            color: ThemeColor.primary,
                            width: 2.0,
                          ),
                        ),
                        contentPadding: const EdgeInsets.all(16),
                        isCollapsed: true,
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            color: Get.theme.colorScheme.error,
                            width: 2.0,
                          ),
                        ),
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
                          fullname: _nameController.text,
                          gender: int.parse(_selectedGender ?? "3"),
                          email: _emailController.text);
                      await model.updateUser(
                          userUpdate, user?.membershipId ?? '');
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
