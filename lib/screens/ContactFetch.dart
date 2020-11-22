import 'package:flutter/material.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter_chat_app/database.dart';
import 'package:flutter_chat_app/screens/chat_screen.dart';
import 'package:flutter_chat_app/screens/setting.dart';
class ContactsPage extends StatefulWidget {
  @override
  _ContactsPageState createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  var _contacts;
  final UserRepo dbmethode = new UserRepo();
  @override
  void initState() {
    getContacts();
    super.initState();
  }

  Future<void> getContacts() async {
    final Iterable<Contact> contacts = await ContactsService.getContacts();
    var mobLst = new List();
    for(var e in contacts){
      String mob = e.phones.toList()[0].value.replaceAll(new RegExp(r'\D'), "");
      mobLst.add(mob);
    }
    var userContact = await dbmethode.getMob(mobLst);
    setState(() {
      _contacts = userContact;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: (Text('All Chats')),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.settings),
            color: Colors.white,
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>Setting()));
            },
          )
        ],
      ),
      body: _contacts != null
          ?
      ListView.builder(
        itemCount: _contacts?.length ?? 0,
        itemBuilder: (BuildContext context, int index) {
          var contact = _contacts?.elementAt(index);
          return GestureDetector(
              onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ChatScreen(contact['mob']
              ),
            ),
          ),
          child:ListTile(
            contentPadding:
            const EdgeInsets.symmetric(vertical: 2, horizontal: 18),
            leading:  CircleAvatar(
              child: Text(capitalize(contact['name'][0])),
              backgroundColor: Theme.of(context).accentColor,
            ),
            title: Text(capitalize(contact['name']) ?? ''),
          ),
          );
        },
      )
          : Center(child: const CircularProgressIndicator()),
    );
  }

  String capitalize(String str) {
    if (str.length<2){
      return str.toUpperCase();
    }
    return str.split(" ").map((st) => st[0].toUpperCase()+st.substring(1)).join(" ");
  }
}