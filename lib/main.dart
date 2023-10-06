import 'package:flutter/material.dart';
import 'package:contacts_service/contacts_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Contact> contacts=[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllContacts();
  }
  getAllContacts() async{
    List<Contact> _contacts = await ContactsService.getContacts(withThumbnails: false);
    setState(() {
      contacts=_contacts;
    });
}

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              itemCount:contacts.length ,
              itemBuilder: (context,index){
                Contact contact=contacts[index];
                return ListTile(
                  title: Text((contact.displayName)!),
                  subtitle: Text(contact.phones?.isNotEmpty == true
                      ? contact.phones!.elementAt(0).value ?? 'No phone number'
                      : 'No phone number'),
                  leading: (contact.avatar != null && contact.avatar!.length > 0)
                      ? YourWidget() // Replace YourWidget with the widget you want to display
                      : null, // Set it to null if you don't want any leading widget

                );
              },
            )
          ],
        ),
      ) // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
