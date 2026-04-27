import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CrudServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Lấy uid của user hiện tại
  String get _uid => _auth.currentUser!.uid;

  // Thêm danh bạ mới
  Future<void> addContact({
    required String name,
    required String phone,
    required String email,
  }) async {
    try {
      await _firestore.collection('contacts').add({
        'name': name,
        'phone': phone,
        'email': email,
        'uid': _uid,
        'createdAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print('Lỗi thêm danh bạ: $e');
    }
  }

  // Đọc danh sách danh bạ của user hiện tại (realtime stream)
  Stream<QuerySnapshot> getContacts() {
    return _firestore
        .collection('contacts')
        .where('uid', isEqualTo: _uid)
        .orderBy('createdAt', descending: false)
        .snapshots();
  }

  // Cập nhật danh bạ
  Future<void> updateContact({
    required String docId,
    required String name,
    required String phone,
    required String email,
  }) async {
    try {
      await _firestore.collection('contacts').doc(docId).update({
        'name': name,
        'phone': phone,
        'email': email,
      });
    } catch (e) {
      print('Lỗi cập nhật danh bạ: $e');
    }
  }

  // Xóa danh bạ
  Future<void> deleteContact(String docId) async {
    try {
      await _firestore.collection('contacts').doc(docId).delete();
    } catch (e) {
      print('Lỗi xóa danh bạ: $e');
    }
  }
}
