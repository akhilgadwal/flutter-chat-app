import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Chatscreen extends StatelessWidget {
  const Chatscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('chats/kNbPvxrfgqQNte0PU65Y/messages')
            .snapshots(),
        builder: (context, streamsnapshot) {
          if (streamsnapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          final documents = streamsnapshot.data?.docs;
          return ListView.builder(
              itemCount: documents!.length,
              itemBuilder: (context, index) => Container(
                    padding: const EdgeInsets.all(10),
                    child: Text(documents[index]['text']),
                  ));
        },
      ),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            FirebaseFirestore.instance
                .collection('chats/kNbPvxrfgqQNte0PU65Y/messages')
                .add({'text': 'This text was added by click of button'});
          }),
    );
  }
}
