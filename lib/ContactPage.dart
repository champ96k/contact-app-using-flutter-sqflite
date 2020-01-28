import 'package:contact_app/AddContact.dart';
import 'package:contact_app/Contact.dart';
import 'package:contact_app/Databasehelper.dart';
import 'package:contact_app/Details.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqlite_api.dart';

class ContactPage extends StatefulWidget {
  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  Databasehelper databaseHelper = Databasehelper();
  List<Contact> noteList;

  int count = 0;
  @override
  Widget build(BuildContext context) {
    if (noteList == null) {
      noteList = List<Contact>();
      updateListView();
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("Contact",
        style: TextStyle(
          color: Colors.black
        ),
        ),
        backgroundColor: Colors.white,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.search,color: Colors.black,),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.more_vert,color: Colors.black),
          )
        ],
      ),
      body: getNoteListView(),
      floatingActionButton: FloatingActionButton(
        elevation: 8.0,
        onPressed: () {
          navigateToDetails(Contact( '','','',));
        },
        child: Icon(Icons.add),
      ),
    );
  }

  ListView getNoteListView() {
    return  ListView.builder(
        itemCount: count,
        itemBuilder: (BuildContext context, int position) {
          return Column(
            children: <Widget>[
              Container(
                height: 65,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 22,
                      backgroundImage: AssetImage("images/pic1.png"),
                    ),
                    title: GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>Details(this.noteList[position])));
                        //navigateToDetails(this.noteList[position]);
                      },
                      child: Text(this.noteList[position].name,
                      overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        }
      );
  }

  void updateListView() {
    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((Database) {
      Future<List<Contact>> noteListFuture = databaseHelper.getNoteList();
      noteListFuture.then((noteList) {
        setState(() {
          this.noteList = noteList;
          this.count = noteList.length;
        });
      });
    });
  }

  void navigateToDetails(Contact note) async {
    bool result = await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return AddContact(note);
    }));

    if (result == true) {
      updateListView();
    }
  }
}
