import 'dart:async';
import '../controller/contact_controller.dart';
import '../model/contact_model.dart';
import '../view/widgets/contact_list_widget.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';

class ContactListView extends StatefulWidget {
  @override
  _ContactListViewState createState() => _ContactListViewState();
}

class _ContactListViewState extends State<ContactListView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final StreamController _listController =
      StreamController<List<ContactModel>>(sync: true);

  ContactController _contactController;
  Stream<List<ContactModel>> _streamContact;
  String _name;
  String _email;

  @override
  void initState() {
    super.initState();
    getApplicationDocumentsDirectory().then((dir) {
      _contactController = ContactController(dir);
      _streamContact = _listController.stream;
      _listController.add(_contactController.allContacts);
      _listController.addStream(_contactController.queryStream);

      setState(() {});
    });
  }

  @override
  void dispose() {
    _contactController.dispose();
    _listController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Contatos'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 80,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Form(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      key: _formKey,
                      child: Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              validator: (name) =>
                                  name.isEmpty ? 'Nome inválido' : null,
                              decoration: InputDecoration(
                                  labelText: 'Nome', filled: true),
                              onSaved: (name) => _name = name,
                              keyboardType: TextInputType.name,
                              textCapitalization: TextCapitalization.words,
                            ),
                          ),
                          Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 4)),
                          Expanded(
                            child: TextFormField(
                              validator: (email) =>
                                  email.isEmpty ? 'E-mail inválido' : null,
                              decoration: InputDecoration(
                                  labelText: 'E-mail', filled: true),
                              onSaved: (email) => _email = email,
                              keyboardType: TextInputType.emailAddress,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 2,
                    child: RaisedButton(
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          _formKey.currentState.save();
                          _contactController.addContact(ContactModel.construct(
                              name: _name, email: _email));
                        }
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      child: Text(
                        'Adicionar',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: StreamBuilder<List<ContactModel>>(
                  stream: _streamContact,
                  builder: (_, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.data.isEmpty) {
                      return Center(
                        child: Text('Não há contatos em sua lista.'),
                      );
                    } else {
                      return ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (_, index) {
                            final contact = snapshot.data[index];
                            return ContactListWidget(
                              contact: contact,
                              onPressedEdit: () {
                                if (_formKey.currentState.validate()) {
                                  _formKey.currentState.save();
                                  _contactController.addContact(
                                      ContactModel.construct(
                                          id: contact.id,
                                          name: _name,
                                          email: _email));
                                }
                              },
                              onPressedDelete: () =>
                                  _contactController.removeContact(contact),
                            );
                          });
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
