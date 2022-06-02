import '../model/contact_model.dart';
import '../objectbox.g.dart';

class ContactController {
  late final Store _store;
  late final Box<ContactModel> _contactBox;
  // late final Query<ContactModel> _query;
  late final Stream<Query<ContactModel>> _queryStream;

  ContactController._create(this._store) {
    _contactBox = Box<ContactModel>(_store);

    final queryBuilder = _contactBox.query()
      ..order(ContactModel_.id, flags: Order.descending);
    _queryStream = queryBuilder.watch(triggerImmediately: true);
  }

  static Future<ContactController> initOpenBox() async {
    final store = await openStore();
    return ContactController._create(store);
  }

  /* ContactController(Directory directory) {
    _store =
        Store(getObjectBoxModel(), directory: '${directory.path}/objectbox');
    _contactBox = Box<ContactModel>(_store);
    final contactId = ContactModel_.id;

    // _query = _contactBox.query().order(contactId, flags: Order.descending).build();
    _query = (_contactBox.query()..order(contactId, flags: Order.descending))
        .build();
  } */

  void addContact(ContactModel contact) => _contactBox.put(contact);
  void removeContact(ContactModel contact) => _contactBox.remove(contact.id!);

  // Stream<List<ContactModel>> get queryStream => _query.findStream();
  Stream<List<ContactModel>> get queryStream =>
      _queryStream.map((event) => event.find());

  // List<ContactModel> get allContacts => _queryStream. find();

  void readContact({ContactModel? contact}) {
    final id = _contactBox.put(contact!);
    _contactBox.get(id);
  }

  /* void dispose() {
    _query.close();
    // _store.close();
  } */
}
