import 'package:contact_app/Contact.dart';
import 'package:contact_app/Databasehelper.dart';
import 'package:flutter/material.dart';

class AddContact extends StatefulWidget {
  final Contact note;

  const AddContact(this.note);

  @override
  State<StatefulWidget> createState() {
    return _AddContactState(this.note);
  }
}

class _AddContactState extends State<AddContact> {
  Databasehelper helper = Databasehelper();

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController numberController = TextEditingController();

  Contact note;
  _AddContactState(this.note);

  @override
  Widget build(BuildContext context) {
    nameController.text = note.name;
    emailController.text = note.email;
    numberController.text = note.number;

    return WillPopScope(
      onWillPop: () {
        moveToLastScreen();
      },
      child: SafeArea(
        child: Scaffold(  
          body: ListView(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: ListTile(
                  leading: Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: IconButton(icon: Icon(Icons.clear, size: 28, color: Colors.black,), 
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    )
                  ),
                  title: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 12),
                      child: Text("Save To Mi Account ▼",
                      style: TextStyle(
                        fontSize: 16, 
                        fontWeight: FontWeight.w600,
                      ),
                      ),
                    ),
                  ),

                  trailing: IconButton(
                    onPressed: () {
                      setState(() {
                        _save();
                      });
                    },
                    icon: IconButton(
                      icon: Icon(Icons.done,size: 28, color: Colors.black,),
                      onPressed: () {
                        _save();
                      },
                    )
                  ),
                  
                ),
              ),

              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 28),  
                  child: CircleAvatar(
                    radius: 25, 
                    backgroundImage: AssetImage("images/pic1.png"),
                  ),
                ),
              ),

               Container(
                 margin: EdgeInsets.only(top: 12,left: 22,right: 22),
                 height: 45, 
                 child: TextField(
                   controller: nameController,
                   onChanged: (value) {
                     updateName();
                  },
                  decoration: InputDecoration(
                    filled: true,
                  labelText: 'Name',
                  labelStyle: TextStyle(
                    fontSize: 14,
                    color: Colors.grey
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0))
                  ),
               ),
              ),


               Container(
                 margin: EdgeInsets.only(top: 12,left: 22,right: 22),
                 height: 45, 
                 child: TextField(
                    keyboardType: TextInputType.number,
                    controller: numberController,
                   onChanged: (value) {
                    updateNumber();
                  },
                  decoration: InputDecoration(
                  filled: true,
                  labelText: 'Number',
                  labelStyle: TextStyle(
                    fontSize: 14,
                    color: Colors.grey
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0))
                  ),
               ),
              ),


              Container(
                 margin: EdgeInsets.only(top: 12,left: 22,right: 22),
                 height: 45, 
                 child: TextField(
                    controller: emailController,
                  onChanged: (value) {
                       updateEmail();
                    },
                  decoration: InputDecoration(
                  filled: true,
                  labelText: 'Email',
                  labelStyle: TextStyle(
                    fontSize: 14,
                    color: Colors.grey
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0))
                  ),
               ),
              ),


               Padding(
                 padding: const EdgeInsets.only(left: 22,right: 22,top: 18,bottom: 18),
                 child: MaterialButton(
                   height: 52,
                   shape: RoundedRectangleBorder(
                     borderRadius: BorderRadius.circular(30)
                   ),
                   color: Colors.grey[300], 
                   child: Text("Delete Contact"),
                   onPressed: () {
                      setState(() {
                        _delete();
                      });
                   },
                 ),
               )
                
            ],
          )
        ),
      ),
    );
  }

  void moveToLastScreen() {
    Navigator.pop(context, true);
  }

  void updateName() {
    note.name = nameController.text;
  }

  void updateEmail() {
    note.email = emailController.text;
  }

  void updateNumber() {
    note.number = numberController.text;
  }

  void _save() async {
    moveToLastScreen();
    int result;
    if (note.id != null) {
      result = await helper.updateNote(note);
    } else {
      result = await helper.insertNote(note);
    }

    if (result != 0) {
      _showAlertDialog('Status', 'Note Saved Successfully');
    } else {
      // Failure
      _showAlertDialog('Status', 'Problem Saving Note');
    }
  }

  void _delete() async {
    moveToLastScreen();

    if (note.id == null) {
      _showAlertDialog('Status', 'No Note was deleted');
      return;
    }

    int result = await helper.deleteNode(note.id);
    if (result != 0) {
      _showAlertDialog('Status', 'Note Deleted Successfully');
    } else {
      _showAlertDialog('Status', 'Error Occured while Deleting Note');
    }
  }

  void _showAlertDialog(String title, String message) {
    AlertDialog alertDialog = AlertDialog(
      title: Text(title),
      content: Text(message),
    );
    showDialog(context: context, builder: (_) => alertDialog);
  }
}
