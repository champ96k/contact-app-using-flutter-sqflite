class Contact {

  int _id;
  String _name;
  String _email;
  String _number;


  Contact(this._name,this._number,this._email,);
  Contact.withID(this._id,this._name,this._number,this._email);

  int get id =>_id;
  String get name =>_name;
  String get email => _email;
  String get number => _number;

  set name(String newName) {
    if(newName.length<=255)
    {
      this._name= newName;
    }
  }

    set email(String newEmail) {
    if(newEmail.length<=255)
    {
      this._email= newEmail;
    }
    }

    set number(String newNumber) {
      if(newNumber.length<=255)
      {
        this._number= newNumber;
      }
      
  }

    
    //convertor a node object into a map object
    Map<String,dynamic> toMap() {
      var map = Map <String, dynamic >();
      if(id!=null)
      {
        map['id']=_id;
      }
      map['name']=_name;
      map['email']=_email;
      map['number']=_number;
      return map;
    }

    //Extracted a node object from a Map Object

    Contact.fromMapObject(Map<String,dynamic> map) {
      this._id=map['id'];
      this._name=map['name'];
      this._email=map['email'];
      this._number=map['number'];
    }


  }





