import 'package:contact_app/AddContact.dart';
import 'package:contact_app/Contact.dart';
import 'package:contact_app/Databasehelper.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_launch/flutter_launch.dart';



class Details extends StatefulWidget {
  final Contact note;
  const Details(this.note);

  @override
  State<StatefulWidget> createState() {
    return _DetailsState(this.note);
  }
}

class _DetailsState extends State<Details> {
  Databasehelper databaseHelper = Databasehelper();
  List<Contact> noteList;

  Contact note;
  _DetailsState(this.note); 

  void whatsAppOpen() async {
    await FlutterLaunch.launchWathsApp(phone: note.number, message: "Hello");
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Row(
            children: <Widget>[

              IconButton(
                icon: Icon(Icons.clear),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              Spacer(),
              IconButton(
                icon: Icon(Icons.more_vert),
                onPressed: () {

                },
              )
            ],
          ),

          Container(
            alignment: Alignment.bottomCenter,
            child: ListTile(
              leading: Text(note.name),
              title: Padding(
                padding: const EdgeInsets.only(left: 25),
                child: Icon(Icons.favorite_border),
              ),
              trailing: Padding(
                padding: const EdgeInsets.only(right: 25),
                child: IconButton(
                  icon: Icon(Icons.rate_review),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddContact(note)));
                  },
                ),
              ),
            ),
            height: MediaQuery.of(context).size.height * 0.42,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              leading: Text(note.number),
              title: Padding(
                padding: const EdgeInsets.only(left: 32),
                child: GestureDetector(
                  onTap: () {
                   launch("tel:${note.number}");
                  },
                  child: CircleAvatar(
                    radius: 20, 
                    backgroundColor: Colors.transparent,
                    child: Image(
                      image: AssetImage("images/pic2.png"),
                    )
                  ),
                )
              ),
              trailing: GestureDetector(
                 onTap: () {
                   launch("sms:${note.number}");
                  },
                child: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  radius: 20,
                  child: Image(
                    image: AssetImage("images/pic3.png"),
                  )
                ),
              )
            ),
          ),

           ListTile(
            leading: Text(note.email),
            trailing: GestureDetector(
               onTap: () {
                   launch("mailto:${note.email}");
                  },
              child: CircleAvatar(
                backgroundColor: Colors.transparent,
                radius: 16,
                child: Image(
                  image: AssetImage("images/pic6.png"),
                 )
                ),
            )
          ),

          ListTile(
            leading: Text("Video Call"),
            trailing: CircleAvatar(
                backgroundColor: Colors.transparent,
                radius: 16,
                child: Image(
                  image: AssetImage("images/pic5.png"),
                )),
          ),
          ListTile(
            leading: Text("WhatsaApp"),
            trailing: GestureDetector(
              onTap: () {
                whatsAppOpen();
              },
              child: CircleAvatar(
                backgroundColor: Colors.transparent,
                radius: 16,
                child: Image(
                  image: AssetImage("images/pic4.png"),
                )
              ),
            )
          ),
          Container(
            height: 0.90,
            color: Colors.grey[300],
          ),
          ListTile(
            title: Text("26 Jan 8:59 PM"),
            subtitle: Text("+919890181173"),
            trailing: Text("Incoming 1m 26s"),
          ),
          ListTile(
            title: Text("25 Jan 9:09 AM"),
            subtitle: Text("+919890181173"),
            trailing: Text("Incoming 2m 26s"),
          ),
        ],
      ),
    );
  }
}
