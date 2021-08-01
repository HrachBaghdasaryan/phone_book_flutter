import 'package:flutter/material.dart';
import 'package:phone_book/di/injector.dart';
import 'package:phone_book/model/contact_resource.dart';
import 'package:phone_book/service/contact_service.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final ContactService _contactService = injector<ContactService>();

  TextEditingController controller = new TextEditingController();
  List<ContactResource> _searchResult = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Column(
        children: <Widget>[
          new Container(
            color: Theme.of(context).primaryColor,
            child: new Padding(
              padding: const EdgeInsets.all(8.0),
              child: new Card(
                child: new ListTile(
                  leading: new Icon(Icons.search),
                  title: new TextField(
                    controller: controller,
                    decoration: new InputDecoration(
                        hintText: 'Փնտրել', border: InputBorder.none),
                    onChanged: onSearchTextChanged,
                  ),
                  trailing: new IconButton(
                    icon: new Icon(Icons.cancel),
                    onPressed: () {
                      controller.clear();
                      onSearchTextChanged('');
                    },
                  ),
                ),
              ),
            ),
          ),
          getElement("Անուն", "Ազգանուն", "Քաղաքային", "Բջջային", "Էլ. հասցե"),
          new Expanded(
              child: new ListView.builder(
            itemCount: _searchResult.length,
            itemBuilder: (context, i) {
              return new Card(
                child: new ListTile(
                    title: getElement(
                        _searchResult[i].name,
                        _searchResult[i].surname,
                        _searchResult[i].phoneNumber,
                        _searchResult[i].mobileNumber,
                        _searchResult[i].email)),
                margin: const EdgeInsets.all(0.0),
              );
            },
          )),
        ],
      ),
    );
  }

  onSearchTextChanged(String text) async {
    _searchResult = List.empty();
    if (text.isEmpty) {
      setState(() {});
      return;
    }
    _contactService
        .getList(text)
        .then((value) => {_searchResult = value, setState(() {})})
        .catchError((error) => showCloseableDialog("Եթե կրկնվի կապնվել մասնագետի հետ"));
  }

  Future<dynamic> showCloseableDialog(String error) {
    return showDialog(
      context: context,
      builder: (_) =>
          AlertDialog(
            title: Text("Տեղի է ունեցել սխալ"),
            content: Text(error),
            actions: [
              FlatButton(
                child: Text("Փակել"),
                onPressed: () =>
                {Navigator.of(context).pop()},
              )
            ],
            elevation: 24.0,
            backgroundColor: Colors.white70,
          ),
    );
  }

  Widget getElement(String name, String surname, String phoneNumber,
      String number, String email) {
    return Container(
        child: Row(children: [
      Expanded(child: Container(
        alignment: Alignment.center,
          child: Text(name, style: TextStyle(fontSize: 20),))),
      Expanded(child: Container(
          alignment: Alignment.center,
          child: Text(surname, style: TextStyle(fontSize: 20),))),
      Expanded(child: Container(
          alignment: Alignment.center,
          child: Text(phoneNumber, style: TextStyle(fontSize: 20),))),
      Expanded(child: Container(
          alignment: Alignment.center,
          child: Text(number, style: TextStyle(fontSize: 20),))),
      Expanded(child: Container(
          alignment: Alignment.center,
          child: Text(email, style: TextStyle(fontSize: 20),))),
    ]));
  }
}
