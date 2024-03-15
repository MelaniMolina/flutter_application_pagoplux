import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'sing_up.dart';
import 'payment_admin.dart'; 
import 'second_screen.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController _emailAddressController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          currentFocus.focusedChild?.unfocus();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: Icon(Icons.arrow_back, color: Colors.black),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(20, 110, 20, 110),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Login',
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Text(
                'Please sign in to continue.',
                style: TextStyle(fontSize: 20, color: Colors.grey),
              ),
              const SizedBox(height: 40),
              TextFormField(
                controller: _emailAddressController,
                style: const TextStyle(
                    color: Colors.black, fontFamily: 'SFUDisplay'),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  labelText: 'EMAIL',
                  prefixIcon: Icon(Icons.email_outlined),
                  labelStyle: TextStyle(fontSize: 12),
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                style: const TextStyle(
                    color: Colors.black, fontFamily: 'SFUDisplay'),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  labelText: 'PASSWORD',
                  prefixIcon: const Icon(Icons.lock_outlined),
                  suffixIcon: TextButton(
                    onPressed: () {},
                    child: const Text(
                      'WELCOME!',
                      style: TextStyle(color: Colors.green),
                    ),
                  ),
                  labelStyle: const TextStyle(fontSize: 12),
                ),
              ),
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.centerRight,
                child: SizedBox(
                  height: 50,
                  child: ElevatedButton(
                    onPressed: _signIn, // Cambia el onPressed para llamar a _signIn
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0))),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Login',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(width: 5),
                        Icon(Icons.arrow_forward, size: 24.0, color: Colors.white),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: SizedBox(
          height: 60,
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(
              "Don't  have an account?",
              style: TextStyle(
                  fontFamily: 'SFUIDisplay', color: Colors.black, fontSize: 15),
            ),
            TextButton(
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => SignUp()));
                },
                child: Text(
                  'Sign Up',
                  style: TextStyle(
                      fontFamily: 'SFUIDisplay',
                      color: Colors.green,
                      fontSize: 15),
                ))
          ]),
        ),
      ),
    );
  }

  void _signIn() {
    String email = _emailAddressController.text.trim();
    String password = _passwordController.text.trim();
    print('Email: $email, Password: $password');

    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((userCredential) {
      // Verifica si el usuario es el administrador
      if (email == 'admin@gmail.com' && password == 'admin123') {
        // Si el usuario es el administrador, navega a la página PaymentAdmin
        print('Inició sesión como administrador');
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => PaymentAdmin()),
        );
      } else {
        // Si no es el administrador, navega a la página SecondScreen
        print('Inició sesión como usuario normal');
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => SecondScreen()),
        );
      }
    }).catchError((error) {
      print('Error al iniciar sesión: $error');
      // Muestra un mensaje de error
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Ocurrió un error al iniciar sesión. Por favor, inténtalo de nuevo.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    });
  }
}
