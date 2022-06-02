import 'dart:async';
import 'package:contactlist/main.dart';

import '../model/contact_model.dart';
import '../view/widgets/contact_list_widget.dart';
import 'package:flutter/material.dart';

class ContactListView extends StatefulWidget {
  const ContactListView({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ContactListViewState createState() => _ContactListViewState();
}

class _ContactListViewState extends State<ContactListView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final StreamController _listController =
      StreamController<List<ContactModel>>(sync: true);

  final TextEditingController _nameControl = TextEditingController();
  final TextEditingController _emailControl = TextEditingController();
  // final ContactController _contactController;
  // late final Stream<List<ContactModel>> _streamContact;
  final _listContactStream = StreamController<List<ContactModel>>(sync: true);
  String? _name;
  String? _email;

  @override
  void initState() {
    super.initState();
    // _streamContact = _listController.stream as Stream<List<ContactModel>>;
    // _listController.add(_contactController.allContacts);
    // _listController.addStream(_contactController.queryStream);
    _listContactStream.addStream(contactController.queryStream);
    setState(() {});
  }

  @override
  void dispose() {
    // _contactController.dispose();
    _listController.close();
    _nameControl.dispose();
    _emailControl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Contatos'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.15,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Form(
                      autovalidateMode: AutovalidateMode.disabled,
                      key: _formKey,
                      child: Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: _nameControl,
                              validator: (name) =>
                                  name!.isEmpty ? 'Nome inválido' : null,
                              decoration: const InputDecoration(
                                  labelText: 'Nome', filled: true),
                              onSaved: (name) => _name = name,
                              keyboardType: TextInputType.name,
                              textCapitalization: TextCapitalization.words,
                            ),
                          ),
                          const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 4)),
                          Expanded(
                            child: TextFormField(
                              controller: _emailControl,
                              validator: (email) =>
                                  email!.isEmpty ? 'E-mail inválido' : null,
                              decoration: const InputDecoration(
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
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState?.save();
                          contactController.addContact(ContactModel.construct(
                              name: _name, email: _email));
                        }
                        _nameControl.clear();
                        _emailControl.clear();
                      },
                      child: const Text(
                        'Adicionar',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: StreamBuilder<List<ContactModel>>(
                  stream: _listContactStream.stream,
                  builder: (_, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.data!.isEmpty) {
                      return const Center(
                        child: Text('Não há contatos em sua lista.'),
                      );
                    } else {
                      return ListView.builder(
                        itemCount: snapshot.data?.length,
                        itemBuilder: (_, index) {
                          final contact = snapshot.data?[index];
                          return ContactListWidget(
                            contact: contact,
                            onPressedEdit: () {
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState?.save();
                                contactController.addContact(
                                  ContactModel.construct(
                                    id: contact?.id,
                                    name: _name,
                                    email: _email,
                                  ),
                                );
                              }
                              _nameControl.clear();
                              _emailControl.clear();
                            },
                            onPressedDelete: () =>
                                contactController.removeContact(contact!),
                          );
                        },
                      );
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
