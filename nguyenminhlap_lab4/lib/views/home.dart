import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../controllers/auth_services.dart';
import '../controllers/crud_services.dart';
import 'add_contact_page.dart';
import 'update_contact.dart';
import 'login_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final AuthServices _authServices = AuthServices();
  final CrudServices _crudServices = CrudServices();

  // Đăng xuất
  Future<void> _signOut() async {
    await _authServices.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const LoginPage()),
    );
  }

  // Xóa danh bạ
  Future<void> _deleteContact(String docId) async {
    await _crudServices.deleteContact(docId);
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Đã xóa danh bạ!')));
  }

  @override
  Widget build(BuildContext context) {
    final user = _authServices.getCurrentUser();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Danh Bạ'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Đăng xuất',
            onPressed: _signOut,
          ),
        ],
      ),

      // Hiển thị danh sách realtime
      body: Column(
        children: [
          // Hiển thị email user đang đăng nhập
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            color: Colors.blue.shade50,
            child: Text(
              'Xin chào: ${user?.email ?? ''}',
              style: const TextStyle(fontSize: 14, color: Colors.blue),
            ),
          ),

          // Danh sách danh bạ
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _crudServices.getContacts(),
              builder: (context, snapshot) {
                // Đang tải
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                // Lỗi
                if (snapshot.hasError) {
                  return Center(child: Text('Lỗi: ${snapshot.error}'));
                }

                // Không có dữ liệu
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(
                    child: Text(
                      'Chưa có danh bạ nào!\nNhấn + để thêm mới.',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey),
                    ),
                  );
                }

                // Hiển thị danh sách
                final docs = snapshot.data!.docs;
                return ListView.builder(
                  itemCount: docs.length,
                  itemBuilder: (context, index) {
                    final doc = docs[index];
                    final data = doc.data() as Map<String, dynamic>;

                    return Dismissible(
                      key: Key(doc.id),
                      direction: DismissDirection.endToStart,
                      background: Container(
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.only(right: 20),
                        color: Colors.red,
                        child: const Icon(Icons.delete, color: Colors.white),
                      ),
                      onDismissed: (_) => _deleteContact(doc.id),
                      child: ListTile(
                        leading: CircleAvatar(
                          child: Text(
                            data['name'][0].toUpperCase(),
                            style: const TextStyle(color: Colors.white),
                          ),
                          backgroundColor: Colors.blue,
                        ),
                        title: Text(data['name'] ?? ''),
                        subtitle: Text(data['phone'] ?? ''),
                        trailing: const Icon(Icons.chevron_right),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => UpdateContactPage(
                                docId: doc.id,
                                currentName: data['name'] ?? '',
                                currentPhone: data['phone'] ?? '',
                                currentEmail: data['email'] ?? '',
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),

      // Nút thêm danh bạ
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddContactPage()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
