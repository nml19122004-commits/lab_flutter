import 'package:flutter/material.dart';
import 'login_screen.dart'; // Import màn hình đăng nhập làm màn hình chính

void main() {
  runApp(const MyApp()); // Khởi chạy ứng dụng
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lab 3 - Form - Login - Dio', // Tiêu đề ứng dụng
      theme: ThemeData(
        primarySwatch: Colors.blue, // Sử dụng màu xanh dương làm chủ đạo
      ),
      debugShowCheckedModeBanner: false, // Tắt biểu tượng debug ở góc màn hình
      home:
          const LoginScreen(), // Thiết lập màn hình đăng nhập là màn hình khởi đầu
    ); // MaterialApp
  }
}
