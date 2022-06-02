import 'dart:math';
import 'package:contactlist/model/contact_model.dart';
import 'package:flutter/material.dart';

class ContactListWidget extends StatelessWidget {
  final ContactModel? contact;
  final VoidCallback? onPressedEdit, onPressedDelete;

  const ContactListWidget(
      {Key? key, this.contact, this.onPressedEdit, this.onPressedDelete}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
          backgroundColor:
              Colors.primaries[Random().nextInt(Colors.primaries.length)],
          child: Text(contact!.name!.characters.first.toUpperCase(),
              style: TextStyle(
                  color: Colors.primaries[
                                  Random().nextInt(Colors.primaries.length)]
                              .computeLuminance() >
                          0.6
                      ? Colors.black
                      : Colors.white))),
      title: Text(
        contact!.name ?? 'Nome não informado',
        style: const TextStyle(fontWeight: FontWeight.w700),
      ),
      subtitle: Text(contact!.email ?? 'E-mail não informado'),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
              visualDensity: VisualDensity.compact,
              icon: const Icon(Icons.edit),
              onPressed: onPressedEdit),
          IconButton(
              visualDensity: VisualDensity.compact,
              icon: const Icon(Icons.delete),
              onPressed: onPressedDelete)
        ],
      ),
    );
  }
}
