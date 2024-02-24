import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:nfc_manager/nfc_manager.dart';

void main() => runApp(MyApp());


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String username = "JohnDoe";
  String id = "12345";

  @override
  void initState() {
    super.initState();
    initNFC();
  }


  Future<void> initNFC() async {
    final nfc = NfcManager.instance;

    // Start an NFC session for writing
    nfc.startSession(
      onDiscovered: (NfcTag tag) async {
        // Prepare the data you want to write to the tag
        final data = [utf8.encode(username), utf8.encode(id)];

        // Write data to the NFC tag
        try {
          // Use low-level NFC commands to write data to the tag
          // For example, for NFC Forum Type 2 tags:
          //await tag.write([...]); // Provide appropriate write commands

          print('Data written to the NFC tag: $data');
        } catch (e) {
          print('Error writing data to NFC tag: $e');
        }
      },
    );
  }



  @override
  void dispose() {
    NfcManager.instance.stopSession();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('NFC Write Example'),
      ),
      body: Center(
        child: Text('Tap an NFC tag to write data.'),
      ),
    );
  }
}
