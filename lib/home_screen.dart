import 'package:flutter/material.dart';
import 'sing_in.dart';
import 'sing_up.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/logo.png'),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                Color.fromARGB(255, 220, 243, 237).withOpacity(0.7),
                BlendMode.darken,
              ),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Image.asset(
              //   'assets/avion.jpg',
              //   height: 175,
              // ),
              SizedBox(height: 45),
              Center(
                child: Button(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => SignUp()),
                    );
                  },
                  text: 'Sign Up',
                ),
              ),
              SizedBox(height: 45),
              Center(
                child: Button(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => SignIn()),
                    );
                  },
                  text: 'Sign In',
                ),
              ),
       
              // Button(
              //   onPressed: () {
              //     Navigator.of(context).push(
              //       MaterialPageRoute(builder: (context) => PaymentForm()),
              //     );
              //   },
              //   text: 'Tourist Sites',
              // ),
              Padding(
                padding: const EdgeInsets.only(bottom: 30, right: 20),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => HomeScreen()),
                      );
                    },
                    child: const Text(
                      '',
                      style: TextStyle(
                        color: Colors.yellow,
                        fontSize: 26,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
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
      height: 50,
      width: 200,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
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
