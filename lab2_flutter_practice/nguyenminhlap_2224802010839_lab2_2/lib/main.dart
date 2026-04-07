import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ResponsiveHomePage(),
    ); // MaterialApp
  }
}

class ResponsiveHomePage extends StatelessWidget {
  const ResponsiveHomePage({super.key});

  // Định nghĩa màu sắc và kiểu chữ (từ ảnh 2)
  static const colorCodes = {
    'body': Color(0xFFF8E287), // Sweet Corn
    'navigation': Color(0XFFC5ECCE), // Padua
    'pane': Color(0XFFEEE2BC), // Chamois
  };

  static const _style = TextStyle(fontSize: 20, fontWeight: FontWeight.bold);
  static const body = Center(child: Text('Body', style: _style));
  static const navigation = Center(child: Text('Navigation', style: _style));
  static const panes = Center(child: Text('Pane', style: _style));

  @override
  Widget build(BuildContext context) {
    // Lấy chiều rộng màn hình (từ ảnh 2)
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: () {
          // Logic thay đổi tiêu đề dựa trên chiều rộng (IIFE)
          if (screenWidth < 600) {
            return const Text('Responsive UI - Phone');
          } else if (screenWidth < 840) {
            return const Text('Responsive UI - Tablet');
          } else if (screenWidth < 1200) {
            return const Text('Responsive UI - Landscape');
          } else {
            return const Text('Responsive UI - Large Desktop');
          }
        }(),
      ), // AppBar
      body: () {
        // Logic chọn hàm xây dựng màn hình (từ ảnh 3)
        if (screenWidth < 600) {
          return buildCompactScreen();
        } else if (screenWidth < 840) {
          return buildMediumScreen();
        } else if (screenWidth < 1200) {
          return buildExpandedScreen();
        } else {
          return buildLargeScreen();
        }
      }(),
    ); // Scaffold
  }

  // Màn hình điện thoại (từ ảnh 3)
  Widget buildCompactScreen() {
    return Column(
      children: [
        Expanded(
          child: Container(color: colorCodes['body'], child: body),
        ), // Expanded
        Container(
          height: 80,
          color: colorCodes['navigation'],
          child: navigation,
        ),
      ],
    ); // Column
  }

  // Màn hình Tablet (từ ảnh 4)
  Widget buildMediumScreen() {
    return Row(
      children: [
        Container(
          width: 80,
          color: colorCodes['navigation'],
          child: navigation,
        ),
        Expanded(
          child: Container(color: colorCodes['body'], child: body),
        ), // Expanded
      ],
    ); // Row
  }

  // Màn hình Landscape (từ ảnh 4)
  Widget buildExpandedScreen() {
    return Row(
      children: [
        Container(
          width: 80,
          color: colorCodes['navigation'],
          child: navigation,
        ),
        Container(width: 360, color: colorCodes['body'], child: body),
        Expanded(
          child: Container(color: colorCodes['pane'], child: panes),
        ), // Expanded
      ],
    ); // Row
  }

  // Màn hình Desktop lớn (từ ảnh 4)
  Widget buildLargeScreen() {
    return Row(
      children: [
        Container(
          color: colorCodes['navigation'],
          width: 360,
          child: navigation,
        ),
        Container(width: 360, color: colorCodes['body'], child: body),
        Expanded(
          child: Container(color: colorCodes['pane'], child: panes),
        ), // Expanded
      ],
    ); // Row
  }
}
