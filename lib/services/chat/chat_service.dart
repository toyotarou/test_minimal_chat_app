import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:test_minimal_chat_app/models/message.dart';

class ChatService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  ///
  Stream<List<Map<String, dynamic>>> getUserStream() {
    return _firestore.collection('minimal_users').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final user = doc.data();
        return user;
      }).toList();
    });
  }

  ///
  Future<void> sendMessage({required String receiverId, required String message}) async {
    final currentUserId = _auth.currentUser!.uid;
    final currentUserEmail = _auth.currentUser!.email!;
    final timestamp = Timestamp.now();

    final newMessage =
        Message(senderId: currentUserId, senderEmail: currentUserEmail, receiverId: receiverId, message: message, timestamp: timestamp);

    final ids = <String>[currentUserId, receiverId]..sort();

    final chatRoomId = ids.join('_');

    await _firestore.collection('chat_room').doc(chatRoomId).collection('messages').add(newMessage.toMap());
  }

  ///
  Stream<QuerySnapshot> getMessages({required String receiverId, required String senderId}) {
    final ids = <String>[receiverId, senderId]..sort();

    final chatRoomId = ids.join('_');

    return _firestore.collection('chat_room').doc(chatRoomId).collection('messages').orderBy('timestamp', descending: false).snapshots();
  }
}
