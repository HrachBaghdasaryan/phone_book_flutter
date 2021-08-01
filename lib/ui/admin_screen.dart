import 'dart:html';

import 'package:flutter/material.dart';
import 'package:phone_book/di/injector.dart';
import 'package:phone_book/model/contact_entity_resource.dart';
import 'package:phone_book/model/contact_resource.dart';
import 'package:phone_book/service/admin_service.dart';
import 'package:phone_book/service/contact_service.dart';

import 'create/request.dart';

class AdminPanel extends StatefulWidget {
  @override
  _AdminPanelState createState() => _AdminPanelState();
}

class _AdminPanelState extends State<AdminPanel> {
  final AdminService _adminService = injector<AdminService>();

  TextEditingController controller = TextEditingController();
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  List<ContactEntityResource> _searchResult = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            color: Theme
                .of(context)
                .primaryColor,
            child: Row(
              children: [
                Expanded(
                  flex: 10,
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          child: Padding(
                            padding: const EdgeInsets.only(
                                right: 8.0, left: 8.0, top: 8.0),
                            child: Card(
                              child: ListTile(
                                title: TextField(
                                  controller: username,
                                  decoration: InputDecoration(
                                      hintText: 'Մուտքանուն',
                                      border: InputBorder.none),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          child: Padding(
                            padding: const EdgeInsets.only(
                                right: 8.0, left: 8.0, top: 8.0),
                            child: Card(
                              child: ListTile(
                                title: TextField(
                                  controller: password,
                                  obscureText: true,
                                  enableSuggestions: false,
                                  autocorrect: false,
                                  decoration: InputDecoration(
                                      hintText: 'Գաղտնաբառ',
                                      border: InputBorder.none),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(flex: 3, child: Container()),
                Expanded(
                  flex: 3,
                  child: Container(
                    alignment: Alignment.centerRight,
                    child: Padding(
                        padding: const EdgeInsets.only(
                            right: 8.0, left: 8.0, top: 8.0),
                        child: TextButton(
                          child: Card(
                              child: Container(
                                height: 57,
                                width: 100,
                                child: Icon(
                                  Icons.add,
                                  size: 50,
                                ),
                              )),
                          onPressed: () => _startAdd(context),
                        )),
                  ),
                )
              ],
            ),
          ),
          Container(
            color: Theme
                .of(context)
                .primaryColor,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: ListTile(
                  leading: Icon(Icons.search),
                  title: TextField(
                    controller: controller,
                    decoration: InputDecoration(
                        hintText: 'Փնտրել', border: InputBorder.none),
                    onChanged: onSearchTextChanged,
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.cancel),
                    onPressed: () {
                      controller.clear();
                      onSearchTextChanged('');
                    },
                  ),
                ),
              ),
            ),
          ),
          getElement(
              "Անուն",
              "Հայրանուն / Ազգանուն",
              "Ստորաբաժանում",
              "Ներքին",
              "Պաշտոն / Էլ. հասցե",
              true,
              0),
          Expanded(
              child: ListView.builder(
                itemCount: _searchResult.length,
                itemBuilder: (context, i) {
                  return Card(
                    child: ListTile(
                        title: getElement(
                            _searchResult[i].name,
                            _searchResult[i].surname,
                            _searchResult[i].phoneNumber,
                            _searchResult[i].mobileNumber,
                            _searchResult[i].email,
                            false,
                            _searchResult[i].id)),
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
    _adminService
        .getList(text, "${username.value.text}:${password.value.text}")
        .then((value) => {_searchResult = value, setState(() {})})
        .catchError((error) => showCloseableDialog(error.toString()));
  }

  Widget getElement(String name, String surname, String phoneNumber,
      String number, String email, bool title, int index) {
    return Container(
        child: Row(children: [
          Expanded(
              child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    name,
                    style: TextStyle(fontSize: 20),
                  ))),
          Expanded(
              child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    surname,
                    style: TextStyle(fontSize: 20),
                  ))),
          Expanded(
              child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    phoneNumber,
                    style: TextStyle(fontSize: 20),
                  ))),
          Expanded(
              child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    number,
                    style: TextStyle(fontSize: 20),
                  ))),
          Expanded(
              child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    email,
                    style: TextStyle(fontSize: 20),
                  ))),
          Expanded(
              child: title
                  ? Container()
                  : Container(
                alignment: Alignment.centerRight,
                child: Padding(
                    padding: const EdgeInsets.only(
                        right: 8.0, left: 8.0, top: 8.0),
                    child: TextButton(
                        style: ButtonStyle(
                          backgroundColor:
                          MaterialStateProperty.all(Colors.white),
                        ),
                        child: Container(
                          height: 57,
                          width: 100,
                          child: Icon(
                            Icons.delete_outline,
                            size: 50,
                            color: Colors.red,
                          ),
                        ),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (_) =>
                                AlertDialog(
                                  title: Text("Հաստատեք հեռացնելը"),
                                  content: Text("Անունը: $name"),
                                  actions: [
                                    FlatButton(
                                      child: Text("Հերքել"),
                                      onPressed: () =>
                                      {Navigator.of(context).pop()},
                                    ),
                                    FlatButton(
                                      child: Text("Հաստատել"),
                                      onPressed: () {
                                        deleteContact(index);
                                        Navigator.of(context).pop();
                                      },
                                    )
                                  ],
                                  elevation: 24.0,
                                  backgroundColor: Colors.white70,
                                ),
                          );
                        })),
              )),
        ]));
  }

  void deleteContact(int index) {
    _adminService
        .delete(index, "${username.value.text}:${password.value.text}")
        .then((value) => onSearchTextChanged(controller.value.text))
        .catchError((error) => showCloseableDialog(error.toString()));
    onSearchTextChanged(controller.value.text);
  }

  Future<dynamic> showCloseableDialog(error) {
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

  void _startAdd(BuildContext ctx) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: CreateContactRequest(_create),
          behavior: HitTestBehavior.deferToChild,
        );
      },
    );
  }

  void _create(ContactResource contactResource) {
    _adminService
        .create(
        contactResource, "${username.value.text}:${password.value.text}")
        .then((value) => onSearchTextChanged(controller.value.text))
        .catchError((error) => showCloseableDialog(error.toString()));
    onSearchTextChanged(controller.value.text);
  }
}
