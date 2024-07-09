import 'package:flutter/material.dart';
import 'package:contacts_service/contacts_service.dart';

class MyContactsPage extends StatefulWidget {
  @override
  _MyContactsPageState createState() => _MyContactsPageState();
}

class _MyContactsPageState extends State<MyContactsPage> {
  List<Contact> _contacts = [];

  @override
  void initState() {
    super.initState();
    fetchContacts(); // Fetch contacts when the page initializes
  }

  Future<void> fetchContacts() async {
    Iterable<Contact> contacts = await ContactsService.getContacts();
    setState(() {
      _contacts = contacts.toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Contacts'),
      ),
      body: ListView.builder(
        itemCount: _contacts.length,
        itemBuilder: (context, index) {
          Contact contact = _contacts[index];
          return ListTile(
            leading: (contact.avatar != null && contact.avatar!.isNotEmpty)
                ? CircleAvatar(
                    backgroundImage: MemoryImage(contact.avatar!),
                  )
                : CircleAvatar(
                    child: Text(contact.initials()),
                  ),
            title: Text(contact.displayName ?? 'No name'),
            subtitle: Text(
              contact.phones != null && contact.phones!.isNotEmpty
                  ? contact.phones!.first.value ?? 'No phone number'
                  : 'No phone number',
            ),
          );
        },
      ),
    );
  }
}
