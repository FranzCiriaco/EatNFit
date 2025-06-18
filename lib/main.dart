import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: const Text('EatNFit' , style: TextStyle(
          fontSize: 35,
        ),),
        backgroundColor: Colors.blue[500]
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Franz 1', style: TextStyle(
              fontSize: 60,
                  fontWeight: FontWeight.w900
            )),
            Text('Franz 2', style: TextStyle(
              fontSize: 90,
                  fontWeight: FontWeight.w900
            )),
            Text('Franz 3', style: TextStyle(
              fontSize: 60,
                  fontWeight: FontWeight.w900
            )),
        ]
      ),
    )
  )
  ));
}
