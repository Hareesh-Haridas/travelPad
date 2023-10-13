import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:travel_pad/Screens/add_screen.dart';

class ContactSelectionDialog extends StatefulWidget {
  const ContactSelectionDialog({super.key, required this.contacts});
  final List<Contact> contacts;

  @override
  ContactSelectionDialogState createState() => ContactSelectionDialogState();
}

List<String> selectedContactIds = [];
List<Contact> selectedContacts = [];

class ContactSelectionDialogState extends State<ContactSelectionDialog> {
  List<String> tempSelectedContactIds = [];

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Select contacts'),
      content: SizedBox(
        width: double.maxFinite,
        child: ListView.builder(
          itemCount: widget.contacts.length,
          itemBuilder: (BuildContext context, int index) {
            final contact = widget.contacts[index];
            final contactId = contact.identifier ?? '';

            return ListTile(
              title: Text(contact.displayName ?? ''),
              leading: Checkbox(
                activeColor: Colors.green,
                checkColor: Colors.blue,
                value: selectedContactIds.contains(contactId),
                onChanged: (bool? value) {
                  setState(() {
                    if (value == true) {
                      selectedContactIds.add(contactId);
                      selectedContacts.add(contact);
                    } else {
                      selectedContactIds.remove(contactId);
                      selectedContacts
                          .removeWhere((c) => c.identifier == contactId);
                    }
                    print("Selected Contacts: $selectedContacts");
                    // selectedContacts = getIds(selectedContactIds);
                  });
                },
              ),
            );
          },
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Ok'),
        ),
        TextButton(
          onPressed: () {
            setState(() {
              selectedContactIds.clear();
              selectedContactIds.addAll(tempSelectedContactIds);
            });
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        )
      ],
    );
  }
}
