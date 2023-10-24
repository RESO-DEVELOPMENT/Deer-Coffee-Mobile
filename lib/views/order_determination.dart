import 'package:deer_coffee/view_models/menu_view_model.dart';
import 'package:deer_coffee/view_models/product_view_model.dart';
import 'package:deer_coffee/views/cart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/product.dart';

class Option extends StatefulWidget {
  final String id;

  const Option({Key? key, required this.id}) : super(key: key);

  @override
  State<Option> createState() => _OptionState();
}

class _OptionState extends State<Option> {
  Product? product;
  @override
  void initState() {
    // TODO: implement initState
    product = Get.find<MenuViewModel>().getProductById(widget.id);
    super.initState();
  }

  int quantity = 1;
  String notes = '';
  void increaseQuantity() {
    setState(() {
      quantity++;
    });
  }

  void decreaseQuantity() {
    if (quantity > 1) {
      setState(() {
        quantity--;
      });
    }
  }

  double percent = 0;

  void increasePercent() {
    setState(() {
      if (percent < 100) {
        percent += 1;
      }
    });
  }

  void decreasePercent() {
    setState(() {
      if (percent > 0) {
        percent -= 1;
      }
    });
  }

  double percent1 = 0;

  void increasePercent1() {
    setState(() {
      if (percent1 < 100) {
        percent1 += 1;
      }
    });
  }

  void decreasePercent1() {
    setState(() {
      if (percent1 > 0) {
        percent1 -= 1;
      }
    });
  }

  int selectedSizeIndex = 1;
  List<String> sizes = ['S', 'M', 'L'];

  void increaseSize() {
    setState(() {
      if (selectedSizeIndex < sizes.length - 1) {
        selectedSizeIndex++;
      }
    });
  }

  void decreaseSize() {
    setState(() {
      if (selectedSizeIndex > 0) {
        selectedSizeIndex--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text(product?.name ?? 'Sản phẩm', style: Get.textTheme.titleMedium),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.network(
                    product?.picUrl ?? '',
                    width: Get.width * 0.9,
                    height: 160,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        product?.name ?? '',
                        style: Get.textTheme.bodyLarge
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      Container(
                        height: 30,
                        width: 80,
                        padding: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Colors.grey)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: decreaseQuantity,
                              child: Icon(CupertinoIcons.minus),
                            ),
                            Text('$quantity'),
                            GestureDetector(
                              onTap: increaseQuantity,
                              child: Icon(CupertinoIcons.plus),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Divider(
                    color: Colors.grey[300],
                    thickness: 1,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Text(
                        'Đá',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Spacer(),
                      Container(
                        height: 30,
                        width: 80,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: decreasePercent,
                              child: Icon(CupertinoIcons.minus),
                            ),
                            Text('${percent.toInt()}%'),
                            GestureDetector(
                              onTap: increasePercent,
                              child: Icon(CupertinoIcons.plus),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Divider(
                    color: Colors.grey[300],
                    thickness: 1,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Text(
                        'Đường',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Spacer(),
                      Container(
                        height: 30,
                        width: 80,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: decreasePercent1,
                              child: Icon(CupertinoIcons.minus),
                            ),
                            Text('${percent1.toInt()}%'),
                            GestureDetector(
                              onTap: increasePercent1,
                              child: Icon(CupertinoIcons.plus),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Divider(
                    color: Colors.grey[300],
                    thickness: 1,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Text(
                        'Kích thước',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Spacer(),
                      Container(
                        height: 30,
                        width: 80,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: decreaseSize,
                              child: Icon(CupertinoIcons.minus),
                            ),
                            Text(sizes[selectedSizeIndex]),
                            GestureDetector(
                              onTap: increaseSize,
                              child: Icon(CupertinoIcons.plus),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Divider(
                    color: Colors.grey[300],
                    thickness: 1,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Topping',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Checkbox(
                                activeColor: Color.fromARGB(255, 59, 158, 238),
                                value: true,
                                onChanged: (value) {},
                              ),
                              Text(
                                'Trân châu',
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Spacer(),
                      Text(
                        '5000đ',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Checkbox(
                            activeColor: Color.fromARGB(255, 59, 158, 238),
                            value: false,
                            onChanged: (value) {},
                          ),
                          Text(
                            'Trân châu',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        '5000đ',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Checkbox(
                            activeColor: Color.fromARGB(255, 59, 158, 238),
                            value: false,
                            onChanged: (value) {},
                          ),
                          Text(
                            'Trân châu',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        '5000đ',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Checkbox(
                            activeColor: Color.fromARGB(255, 59, 158, 238),
                            value: false,
                            onChanged: (value) {},
                          ),
                          Text(
                            'Trân châu',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        '5000đ',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Divider(
                    color: Colors.grey[300],
                    thickness: 1,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Text(
                          'Yêu cầu khác', // Đây là tiêu đề yêu cầu khác
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Text(
                          'Ghi chú',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Spacer(),
                        Container(
                          height: 50,
                          width: 270,
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 216, 215, 215),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 5.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextField(
                                    decoration: InputDecoration(
                                      hintText: 'Hãy nói gì đó...',
                                      border:
                                          InputBorder.none, // Bỏ gạch dưới chân
                                    ),
                                    onChanged: (value) {
                                      setState(() {
                                        notes =
                                            value; // Cập nhật ghi chú khi người dùng thay đổi
                                      });
                                    },
                                  ),
                                ),
                                SizedBox(
                                    width:
                                        10), // Tạo khoảng cách giữa văn bản và icon
                                Icon(
                                  Icons.edit, // Icon cây viết
                                  color: Colors.grey, // Màu của icon
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Tổng Cộng',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          '39000đ',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) =>
                                      CartScreen(), // Replace with your VoucherQr page
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Color.fromARGB(
                                  255, 59, 158, 238), // Màu nền của nút
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    30.0), // Độ bo góc của nút
                              ),
                              minimumSize: Size(double.infinity,
                                  60), // Chiều rộng và chiều cao của nút
                            ),
                            child: Text(
                              'Chọn',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white, // Màu văn bản của nút
                              ),
                            ),
                          ),
                        ),
                      ],
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
