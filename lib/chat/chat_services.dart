import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutechat/models/message.dart';

class ChatService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<List<Map<String, dynamic>>> getUsersStream() {
    return _firestore.collection("users").snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return doc.data();
      }).toList();
    });
  }

  Future<void> sendMessage(
      {required String receiverId, required String message}) async {
    final User? currentUser = _auth.currentUser;
    final String currentUserId = currentUser?.uid ?? "";
    final String userEmail = currentUser?.email ?? "";

    final Message msg = Message(
      senderId: currentUserId,
      senderEmail: userEmail,
      receiverId: receiverId,
      message: message,
      timestamp: Timestamp.now(),
    );

    final List<String> ids = [receiverId, currentUserId];
    ids.sort();
    final chatRoomId = ids.join('_');

    await _firestore
        .collection("chat_rooms")
        .doc(chatRoomId)
        .collection("messages")
        .add(msg.toMap());
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getMessages(
      {required String userId, required otherUserId}) {
    final List<String> ids = [userId, otherUserId];
    ids.sort();
    final chatRoomId = ids.join('_');

    return _firestore
        .collection("chat_rooms")
        .doc(chatRoomId)
        .collection("messages")
        .orderBy("timestamp")
        .snapshots();
  }
}
