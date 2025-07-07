import 'package:flutter/material.dart';

class ChooseLocation extends StatefulWidget {
  @override
  State<ChooseLocation> createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation> {

  void getData() async {

    // simulate network request for a username
    String username = await Future.delayed(Duration(seconds: 3), () {
      return 'Franz';
    });

     // simulate network request to get bio of the username
    String bio = await Future.delayed(Duration(seconds: 2), () {
      return 'Basketball player na pogi';
    });

    print('$username - $bio');

  }

  int counter = 0;

  @override
  void initState() {
    super.initState();
    getData();
    print('Hello madlang people!');
  }


  @override
  Widget build(BuildContext context) {
     print('build function ran');
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: Text('Choose a location'),
        centerTitle: true,
        elevation: 0,
      ),
      body: ElevatedButton(
        onPressed: () {
          setState(() {
            counter += 1;
          });
        },
        child: Text('counter is $counter'),
      ),
    );
  }
}
