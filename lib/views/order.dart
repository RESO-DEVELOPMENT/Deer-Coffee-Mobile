import 'package:flutter/material.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Align(
          alignment: Alignment.center, 
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
           
                child: Image.asset('assets/images/1.png.png'),
                margin: const EdgeInsets.only(top: 80),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                "Đặt hàng thành công",
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      fontSize: 25,
                      // fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(
                  10,
                ),
                child: Text(
                  'Đơn đặt hàng của bạn đã được đặt thành công. ',
                  style: TextStyle(
                    color: Colors.grey[500],
                    fontSize: 15,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Text(
                "Để biết thêm chi tiết, đi đến đơn đặt hàng của tôi",
                style: TextStyle(
                  color: Colors.grey[500],
                  fontSize: 15,
                ),
              ),
              SizedBox(
                height: 80,
              ),
              SizedBox(
                width: 350,
                height: 40,
                child: ElevatedButton(
                  onPressed: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => Tracking(), // Thay thế "SecondPage" bằng tên trang mới của bạn
                    //   ),
                    // );
                  },
                  child: Text("Theo dõi đơn hàng của tôi",style: TextStyle(color: Colors.white),),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.lightBlue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
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
