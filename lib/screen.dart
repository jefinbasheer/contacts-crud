import 'dart:ffi';

import 'package:crud_1/contact.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Contact> contacts = List.empty(growable: true);
  TextEditingController namecontroller = TextEditingController();
  TextEditingController numbercontroller = TextEditingController();

  int selectedIndex = -1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Contact List',
          style: TextStyle(
              color: Colors.white,
              fontFamily: AutofillHints.creditCardName,
              fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 24, 24, 24),
      ),
      backgroundColor: Color.fromRGBO(248, 243, 243, 1),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // text field for name
            TextField(
              controller: namecontroller,
              decoration: InputDecoration(
                  hintText: 'Enter your Name',
                  hintStyle: TextStyle(color: Colors.amberAccent),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  icon: Icon(
                    Icons.person_2_rounded,
                    color: Colors.amberAccent,
                  )),
            ),

            SizedBox(
              height: 5.0,
            ),
            // text field for number
            TextField(
              controller: numbercontroller,
              decoration: InputDecoration(
                  hintText: 'Enter your Phone',
                  hintStyle: TextStyle(color: Colors.amberAccent),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  icon: Icon(
                    Icons.dialer_sip_rounded,
                    color: Colors.amberAccent,
                  )),
              maxLength: 10,
              keyboardType: TextInputType.number,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    String name = namecontroller.text.trim();
                    String contact = numbercontroller.text.trim();
                    if (name.isNotEmpty && contact.isNotEmpty) {
                      setState(() {
                        namecontroller.text = " ";
                        numbercontroller.text = ' ';
                        contacts.add(Contact(name: name, number: contact));
                      });
                    }
                  },
                  child: Text("save"),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.amberAccent),
                ),
                SizedBox(
                  width: 5.0,
                ),
                ElevatedButton(
                  onPressed: () {
                    String name = namecontroller.text.trim();
                    String contact = numbercontroller.text.trim();
                    if (name.isNotEmpty && contact.isNotEmpty) {
                      setState(() {
                        namecontroller.text = " ";
                        numbercontroller.text = ' ';
                        contacts[selectedIndex].name = name;
                        contacts[selectedIndex].number = contact;
                        selectedIndex = -1;
                      });
                    }
                  },
                  child: Text('Update'),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.amberAccent),
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            contacts.isEmpty
                ? Text(
                    "No contacts ",
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.amberAccent),
                  )
                : Expanded(
                    child: ListView.builder(
                      itemCount: contacts.length,
                      itemBuilder: (context, index) => getRow(index),
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  Widget getRow(int index) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: index % 2 == 0 ? Colors.blue : Colors.brown,
          foregroundColor: Colors.cyanAccent,
          child: Text(
            contacts[index].name[0],
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              contacts[index].name,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              contacts[index].number,
              style: TextStyle(fontWeight: FontWeight.bold),
            )
          ],
        ),
        trailing: SizedBox(
          width: 70,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                  onTap: () {
                    namecontroller.text = contacts[index].name;
                    numbercontroller.text = contacts[index].number;
                    setState(() {
                      selectedIndex = index;
                    });
                  },
                  child: Icon(Icons.edit)),
              SizedBox(
                width: 2.0,
              ),
              InkWell(
                  onTap: () {
                    setState(() {
                      contacts.removeAt(index);
                    });
                  },
                  child: Icon(Icons.delete))
            ],
          ),
        ),
      ),
    );
  }
}
