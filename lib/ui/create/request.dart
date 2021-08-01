import 'package:flutter/material.dart';
import 'package:phone_book/model/contact_resource.dart';

class CreateContactRequest extends StatefulWidget {
  final Function save;

  CreateContactRequest(this.save);

  @override
  _CreateContactRequestState createState() => _CreateContactRequestState();
}

class _CreateContactRequestState extends State<CreateContactRequest> {
  final _name = TextEditingController();
  final _surname = TextEditingController();
  final _email = TextEditingController();
  final _phoneNumber = TextEditingController();
  final _mobileNumber = TextEditingController();

  void _submitData() {
    if (_name.text.isEmpty || _surname.text.isEmpty || _mobileNumber.text.isEmpty ) {
      return;
    }

    widget.save(
       ContactResource(_name.text, _surname.text, _email.text, _phoneNumber.text, _mobileNumber.text)
    );

    Navigator.of(context).pop();
  }


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
            top: 0,
            left: 10,
            right: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 12,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Card(
                child: TextField(
                  decoration: InputDecoration(labelText: 'Անուն'),
                  controller: _name,
                ),
              ),
              SizedBox(height: 8),
              Card(
                child: TextField(
                  decoration: InputDecoration(labelText: 'Ազգանուն'),
                  controller: _surname,
                ),
              ),
              SizedBox(height: 8),
              Card(
                child: TextField(
                  decoration: InputDecoration(labelText: 'Բջջային'),
                  controller: _mobileNumber,
                ),
              ),
              SizedBox(height: 8),
              Card(
                child: TextField(
                  decoration: InputDecoration(labelText: 'Քաղաքային'),
                  controller: _phoneNumber,
                ),
              ),
              SizedBox(height: 8),
              Card(
                child: TextField(
                  decoration: InputDecoration(labelText: 'Էլ. հասցե'),
                  controller: _email,
                ),
              ),
              Container(
                alignment: Alignment.centerRight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                        margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                        child: TextButton(
                          child: new Card(
                              child: Container(
                                alignment: Alignment.center,
                                height: 57,
                                width: 120,
                                child: Text('Փակել', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.red),),
                              )),
                          onPressed: () => Navigator.of(context).pop(),
                        )
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                      child: TextButton(
                        child: new Card(
                            child: Container(
                              alignment: Alignment.center,
                              height: 57,
                              width: 120,
                              child: Text('Ավելացնել', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue),),
                            )),
                        onPressed: () => _submitData(),
                      )
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
