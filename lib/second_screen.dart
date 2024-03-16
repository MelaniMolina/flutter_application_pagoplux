import 'package:flutter/material.dart';
import 'payment_form.dart';
import 'payment_history.dart';
import 'package:firebase_auth/firebase_auth.dart'; 

class SecondScreen extends StatelessWidget {
  const SecondScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String currentUserEmail = FirebaseAuth.instance.currentUser?.email ?? '';
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          ),
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/cobros.jpg'), // Ruta de tu imagen de fondo
              fit: BoxFit.cover, // Ajusta la imagen al tamaño del contenedor
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 45),
              Text(
                'Welcome Customer!!!',
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Text(
                'Choose the Option you want to Perform',
                style: TextStyle(fontSize: 20, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 45),
              Center(
                child: Button(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => PaymentForm()),
                    );
                  },
                  text: 'Make payments',
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: Button(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => PaymentHistory(currentUserEmail: currentUserEmail)),
                    );
                  },
                  text: 'Payment history',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Button extends StatelessWidget {
  final String text;
  final void Function() onPressed;

  const Button({
    Key? key,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 20),
          backgroundColor: Color.fromARGB(255, 130, 190, 130),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: Color.fromARGB(255, 241, 241, 241),
            fontSize: 22,
          ),
        ),
      ),
    );
  }
}
