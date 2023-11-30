import 'package:flutter/material.dart';

class PolicyPage extends StatelessWidget {
  const PolicyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chính Sách Quyền Riêng Tư',style: TextStyle(fontWeight: FontWeight.bold),),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Điều Khoản Dịch Vụ',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text(
              'Điều khoản sử dụng của ứng dụng Deer Coffee. Ứng dụng đặt đồ và giao đồ ăn và thức uống',
            ),
            SizedBox(height: 12.0),
            Text(
              'Chính sách quyền riêng tư của ứng dụng tích điểm thành viên Deer Coffee',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text(
              'Deer Coffee tôn trọng và bảo vệ quyền riêng tư của khách hàng. Chính sách quyền riêng tư này nhằm giải thích cách chúng tôi thu thập, sử dụng, chia sẻ và bảo vệ thông tin cá nhân của bạn khi bạn sử dụng ứng dụng tích điểm thành viên Deer Coffee (sau đây gọi là "Ứng dụng"). Bằng cách sử dụng Ứng dụng, bạn đồng ý với các điều khoản và điều kiện của chính sách quyền riêng tư này.',
            ),
            SizedBox(height: 12.0),
            Text(
              'Thông tin cá nhân mà chúng tôi thu thập',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text(
              'Khi bạn đăng ký và sử dụng Ứng dụng, chúng tôi có thể yêu cầu bạn cung cấp một số thông tin cá nhân, bao gồm:',
            ),
            Padding(
              padding: EdgeInsets.only(left: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('- Họ và tên'),
                  Text('- Số điện thoại'),
                  Text('- Địa chỉ email'),
                  Text('- Ngày sinh'),
                  Text('- Giới tính'),
                  Text('- Ảnh đại diện'),
                ],
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'Chúng tôi cũng có thể thu thập thông tin về cách bạn sử dụng Ứng dụng, bao gồm:',
            ),
            Padding(
              padding: EdgeInsets.only(left: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('- Lịch sử giao dịch'),
                  Text('- Số điểm tích lũy'),
                  Text('- Số phiếu mua hàng'),
                  Text('- Sở thích và lựa chọn của bạn'),
                ],
              ),
            ),
            SizedBox(height: 12.0),
            Text(
              'Mục đích thu thập thông tin cá nhân',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text(
              'Chúng tôi thu thập thông tin cá nhân của bạn với các mục đích sau:',
            ),
            Padding(
              padding: EdgeInsets.only(left: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('- Để xác minh danh tính và tài khoản của bạn'),
                  Text('- Để cung cấp cho bạn các tính năng và dịch vụ của Ứng dụng'),
                  Text('- Để nâng cao chất lượng và trải nghiệm của bạn khi sử dụng Ứng dụng'),
                  Text('- Để gửi cho bạn các thông báo, tin tức, khuyến mãi và ưu đãi liên quan đến Ứng dụng và Deer Coffee'),
                  Text('- Để phân tích hành vi và xu hướng của người dùng để cải thiện Ứng dụng và sản phẩm của Deer Coffee'),
                  Text('- Để tuân thủ các quy định pháp luật có liên quan'),
                ],
              ),
            ),
            SizedBox(height: 12.0),
            Text(
              'Cách chúng tôi chia sẻ thông tin cá nhân',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text(
              'Chúng tôi không bán, cho thuê hoặc chuyển nhượng thông tin cá nhân của bạn cho bất kỳ bên thứ ba nào mà không có sự đồng ý của bạn. Chúng tôi chỉ chia sẻ thông tin cá nhân của bạn với các bên sau:',
            ),
            Padding(
              padding: EdgeInsets.only(left: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('- Các đối tác, nhà cung cấp hoặc nhà thầu của chúng tôi, để hỗ trợ chúng tôi trong việc cung cấp Ứng dụng và các dịch vụ liên quan. Các bên này phải tuân thủ các cam kết bảo mật tương đương hoặc cao hơn với chúng tôi.'),
                  Text('- Các cơ quan nhà nước hoặc pháp luật, khi được yêu cầu theo quy định của pháp luật hoặc để bảo vệ quyền lợi hợp pháp của chúng tôi hoặc người khác.'),
                  Text('- Các bên liên quan trong trường hợp chúng tôi tham gia vào một giao dịch kinh doanh như sáp nhập, mua bán hoặc thoái vốn.'),
                ],
              ),
            ),
            SizedBox(height: 12.0),
            Text(
              'Cách chúng tôi bảo vệ thông tin cá nhân',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text(
              'Chúng tôi sử dụng các biện pháp kỹ thuật, hành chính và vật lý hợp lý để bảo vệ thông tin cá nhân của bạn khỏi truy cập, sử dụng hoặc tiết lộ trái phép. Tuy nhiên, bạn cũng nên thực hiện các bước cần thiết để bảo vệ thông tin cá nhân của bạn, bao gồm:',
            ),
            Padding(
              padding: EdgeInsets.only(left: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('- Không chia sẻ mật khẩu hoặc thông tin đăng nhập của bạn với bất kỳ ai'),
                  Text('- Đăng xuất khỏi Ứng dụng khi không sử dụng'),
                  Text('- Cập nhật Ứng dụng lên phiên bản mới nhất'),
                  Text('- Sử dụng các phần mềm chống vi-rút và bảo mật trên thiết bị của bạn'),
                ],
              ),
            ),
            SizedBox(height: 12.0),
            Text(
              'Quyền và trách nhiệm của bạn',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text(
              'Bạn có quyền truy cập, sửa đổi, xóa hoặc yêu cầu ngừng sử dụng thông tin cá nhân của bạn bằng cách liên hệ với chúng tôi theo địa chỉ email deercoffee@gmail.com. Chúng tôi sẽ xử lý yêu cầu của bạn trong thời gian sớm nhất có thể, trừ khi việc làm đó vi phạm các quy định pháp luật hoặc ảnh hưởng đến quyền lợi hợp pháp của chúng tôi.',
            ),
            SizedBox(height: 12.0),
            Text(
              'Bạn có trách nhiệm cung cấp thông tin cá nhân chính xác, đầy đủ và cập nhật khi sử dụng Ứng dụng. Bạn cũng có trách nhiệm tuân thủ các điều khoản và điều kiện sử dụng Ứng dụng và các quy định pháp luật có liên quan.',
            ),
            SizedBox(height: 12.0),
            Text(
              'Thay đổi chính sách quyền riêng tư',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text(
              'Chúng tôi có thể thay đổi chính sách quyền riêng tư này theo thời gian để phù hợp với các hoạt động kinh doanh và yêu cầu pháp luật. Khi có thay đổi, chúng tôi sẽ thông báo cho bạn qua Ứng dụng hoặc email. Bằng cách tiếp tục sử dụng Ứng dụng sau khi có thông báo, bạn đồng ý với các thay đổi đó.',
            ),
            SizedBox(height: 12.0),
            Text(
              'Liên hệ với chúng tôi',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text(
              'Nếu bạn có bất kỳ câu hỏi, ý kiến hoặc khiếu nại về chính sách quyền riêng tư này hoặc cách chúng tôi xử lý thông tin cá nhân của bạn, vui lòng liên hệ với chúng tôi theo địa chỉ email deercoffee@gmail.com. Chúng tôi sẽ cố gắng giải quyết mọi vấn đề một cách nhanh chóng và hiệu quả.',
            ),
          ],
        ),
      ),
    );
  }
}
