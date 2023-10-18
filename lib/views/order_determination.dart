import 'package:flutter/material.dart';


class Option extends StatefulWidget {
  const Option({super.key});

  @override
  State<Option> createState() => _OptionState();
}

class _OptionState extends State<Option> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF5F5F5),
      body: Stack(
        children: [
          SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            icon: Icon(
                              Icons.arrow_back,
                              color: Colors.black, // Màu của nút back
                            ),
                            onPressed: () {
                              // Xử lý khi nhấn nút back ở đây
                              Navigator.of(context).pop();
                            },
                          ),
                          Column(
                            children: [
                              Text(
                                'Tùy Chọn',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize:
                                      16, 
                                ),
                              ),
                            ],
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.shopping_cart_outlined,
                              color: Colors.black,
                            ),
                            onPressed: () {
                              // Xử lý khi nhấn nút back ở đây
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                              15),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.asset(
                            "assets/images/itembox.png",
                            width: 348,
                            height: 146,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 70,
                      ),
                      Column(
                        children: [
                          Text('Kiwi Yogurt', style: TextStyle(
                            fontWeight: FontWeight.bold
                          ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Divider(
                            color: Colors.grey,
                            thickness: 1,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text('Widget 2'),
                          Text('Widget 3'),
                        ],
                       
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
