import 'package:objectbox/objectbox.dart';

@Entity()
class ContactModel {
  @Id()
  int? id;
  String? name;
  String? email;

  ContactModel();

  ContactModel.construct({this.id, this.name, this.email});

  @override
  String toString() => 'ContactModel(id: $id, name: $name, email: $email)';
}
