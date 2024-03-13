import 'package:flutter/material.dart';

class PaymentForm extends StatelessWidget {
  const PaymentForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Payment Form',
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                MyForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MyForm extends StatefulWidget {
  @override
  _MyFormState createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _fullNameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _paymentValueController = TextEditingController();
  TextEditingController _idController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _fullNameController,
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'SFUIDisplay',
            ),
            decoration: InputDecoration(
              labelText: 'NAMES',
              prefixIcon: Icon(Icons.person),
              labelStyle: TextStyle(fontSize: 12),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your names';
              }
              return null;
            },
          ),
          SizedBox(height: 16),
          TextFormField(
            controller: _phoneController,
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'SFUIDisplay',
            ),
            decoration: InputDecoration(
              labelText: 'PHONE NUMBER',
              prefixIcon: Icon(Icons.phone),
              labelStyle: TextStyle(fontSize: 12),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your phone number';
              }
              // Puedes agregar más validaciones según tus necesidades
              return null;
            },
          ),
          SizedBox(height: 16),
          TextFormField(
            controller: _addressController,
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'SFUIDisplay',
            ),
            decoration: InputDecoration(
              labelText: 'ADDRESS',
              prefixIcon: Icon(Icons.location_on),
              labelStyle: TextStyle(fontSize: 12),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your address';
              }
              return null;
            },
          ),
          SizedBox(height: 16),
          TextFormField(
            controller: _emailController,
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'SFUIDisplay',
            ),
            decoration: InputDecoration(
              labelText: 'EMAIL',
              prefixIcon: Icon(Icons.email),
              labelStyle: TextStyle(fontSize: 12),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your email';
              } else if (!value.contains('@')) {
                return 'Enter a valid email address';
              }
              return null;
            },
          ),
          SizedBox(height: 16),
          TextFormField(
            controller: _paymentValueController,
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'SFUIDisplay',
            ),
            decoration: InputDecoration(
              labelText: 'PAYMENT VALUE',
              prefixIcon: Icon(Icons.attach_money),
              labelStyle: TextStyle(fontSize: 12),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter the payment value';
              }
              // Puedes agregar más validaciones según tus necesidades
              return null;
            },
          ),
          SizedBox(height: 16),
          TextFormField(
            controller: _idController,
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'SFUIDisplay',
            ),
            decoration: InputDecoration(
              labelText: 'ID NUMBER',
              prefixIcon: Icon(Icons.credit_card),
              labelStyle: TextStyle(fontSize: 12),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your ID';
              }
              // Puedes agregar más validaciones según tus necesidades
              return null;
            },
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                // Procesa los datos del formulario
                // Puedes guardar los datos en una base de datos o realizar otras acciones necesarias
              }
            },
            child: Text('Send'),
          ),
        ],
      ),
    );
  }
}

