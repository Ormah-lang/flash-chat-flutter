import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flutter/material.dart';

import 'message_bubble.dart';

class MessagesStream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: ChatScreen.firestore.collection('messages').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.lightBlueAccent,
              ),
            );
          }
          final List<QueryDocumentSnapshot<Map>> messages = snapshot.data.docs;
          List<MessageBubble> messageBubbles = [];
          for (var message in messages) {
            final messageText = message.data()['text'] ?? '';
            final messageSender = message.data()['sender'] ?? '';
            final messageBubble = MessageBubble(
              sender: messageSender,
              text: messageText,
            );
            messageBubbles.add(messageBubble);
          }
          return Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
              children: messageBubbles,
            ),
          );
        });
  }
}
