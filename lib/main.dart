import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Profile(),
    debugShowCheckedModeBanner: false,
  ));
}

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('EatNFit'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  Text(
                    'User Profile',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Icon(Icons.person, size: 100),
                ],
              ),
            ),
            SizedBox(height: 30),
            Text(
              'Name',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text('Franz Janrey O. Ciriaco'),
            SizedBox(height: 20),
            Text(
              'Email',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text('22-11880@g.batstate-u.edu.ph'),
            SizedBox(height: 20),
            Text(
              'Company',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text('Batangas State University TNEU Balayan'),
            SizedBox(height: 20),
            Text(
              'Contact Number',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text('09917227993'),

            Spacer(),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Logged out')),
                  );
                },
                child: Text('Logout'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}




