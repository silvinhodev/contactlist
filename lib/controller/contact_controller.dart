import 'dart:io';
import 'package:objectbox/objectbox.dart';
import '../model/contact_model.dart';
import '../objectbox.g.dart';

class ContactController {
  Store _store;
  Box<ContactModel> _contactBox;
  Query<ContactModel> _query;

  ContactController(Directory directory) {
    _store =
        Store(getObjectBoxModel(), directory: directory.path + '/objectbox');
    _contactBox = Box<ContactModel>(_store);
    final contactId = ContactModel_.id;

    _query =
        _contactBox.query().order(contactId, flags: Order.descending).build();
  }

  void addContact(ContactModel contact) => _contactBox.put(contact);
  void removeContact(ContactModel contact) => _contactBox.remove(contact.id);

  Stream<List<ContactModel>> get queryStream => _query.findStream();

  List<ContactModel> get allContacts => _query.find();

  void readContact({ContactModel contact}) {
    final id = _contactBox.put(contact);
    _contactBox.get(id);
  }

  void dispose() {
    _query.close();
    _store.close();
  }
}
