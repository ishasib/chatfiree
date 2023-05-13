import 'package:chatt_fireee/service/database_service.dart';
import 'package:chatt_fireee/widgets/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../group_info.dart';

class ChatPage extends StatefulWidget {
  final String UserName;
  final String groupId;
  final String groupName;
  const ChatPage(
      {Key? key,
      required this.groupId,
      required this.groupName,
      required this.UserName})
      : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  Stream<QuerySnapshot>? chats;
  String admin = "";

  @override
  void initState() {
    getChatAdmin();

    super.initState();
  }

  getChatAdmin() {
    DatabaseService().getChats(widget.groupId).then((val) {
      setState(() {
        chats = val;
      });
    });
    DatabaseService().getGroupAdmin(widget.groupId).then((val) {
      setState(() {
        admin = val;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text(widget.groupName),
        backgroundColor: Theme.of(context).primaryColor,
        actions: [
          IconButton(
              onPressed: () {
                nextScreen(
                    context,
                    GroupInfo(
                      groupId: widget.groupId,
                      groupName: widget.groupName,
                      adminName: admin,
                    ));
              },
              icon: const Icon(Icons.info))
        ],
      ),
    );
  }
}
