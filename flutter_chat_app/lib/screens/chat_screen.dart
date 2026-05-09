import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../widgets/message_bubble.dart';
import '../services/auth_service.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  ChatScreenState createState() => ChatScreenState();
}

class ChatScreenState extends State<ChatScreen> {
  final _messageController = TextEditingController();
  final _database = FirebaseDatabase.instanceFor(
    app: Firebase.app(),
    databaseURL:
        'https://flutter-chat-app-lap2025-default-rtdb.asia-southeast1.firebasedatabase.app',
  ).ref("messages");

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  void _sendMessage() {
    final text = _messageController.text.trim();
    if (text.isEmpty) return;

    final user = FirebaseAuth.instance.currentUser;
    final timestamp = DateTime.now().millisecondsSinceEpoch;

    _database.push().set({
      'text': text,
      'uid': user?.uid,
      'timestamp': timestamp,
    });

    _messageController.clear();
  }

  String _formatTimestamp(dynamic timestamp) {
    if (timestamp == null) return '';
    final date = DateTime.fromMillisecondsSinceEpoch(timestamp);
    final time = TimeOfDay.fromDateTime(date);
    return time.format(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chat App"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await AuthService().signOut();
              await AuthService().signInAnonymously();
              setState(() {});
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<DatabaseEvent>(
              stream: _database.orderByChild("timestamp").onValue,
              builder: (context, snapshot) {
                if (snapshot.hasData && snapshot.data!.snapshot.value != null) {
                  final messagesMap = snapshot.data!.snapshot.value as Map;
                  final messages = messagesMap.entries.toList()
                    ..sort(
                      (a, b) => (a.value['timestamp'] as int).compareTo(
                        b.value['timestamp'] as int,
                      ),
                    );

                  return ListView.builder(
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      final msg = messages[index].value;
                      final isMe =
                          msg['uid'] == FirebaseAuth.instance.currentUser?.uid;
                      return MessageBubble(
                        text: msg['text'],
                        time: _formatTimestamp(msg['timestamp']),
                        isMe: isMe,
                      );
                    },
                  );
                }
                return const Center(child: Text("No messages yet."));
              },
            ),
          ),
          const Divider(height: 1),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: const InputDecoration(
                      hintText: 'Type a message...',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: _sendMessage,
                  child: const Text("Send"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
