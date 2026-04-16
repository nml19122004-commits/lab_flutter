import 'package:dio/dio.dart'; //

class ApiService {
  final Dio dio = Dio(); // Khởi tạo đối tượng Dio

  // Địa chỉ API giả bạn đã tạo từ mockapi.io
  final String baseUrl = "https://69e0674629c070e6597b6ed9.mockapi.io/api/v1/";

  // Hàm gửi dữ liệu (POST) đến một endpoint cụ thể
  Future<void> send(String endpoint, Map<String, dynamic> data) async {
    //
    try {
      // Thực hiện gọi API POST
      final response = await dio.post("$baseUrl/$endpoint", data: data); //
      print(response); // In kết quả trả về từ server
    } catch (e) {
      // Xử lý và in lỗi nếu quá trình gọi API thất bại
      print("Dio error: $e"); //
    }
  }
}
