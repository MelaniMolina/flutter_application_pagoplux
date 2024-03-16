import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PaymentHistory extends StatelessWidget {
  final String currentUserEmail;

  const PaymentHistory({Key? key, required this.currentUserEmail}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/chica.jpg'), 
            fit: BoxFit.cover, 
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              Text(
                'Payment History',
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),
              Text(
                'Carefully review your payment history status',
                style: TextStyle(fontSize: 15, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('payments')
                    .where('email', isEqualTo: currentUserEmail)
                    .snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (snapshot.hasError) {
                    return Center(
                      child: Text('Error: ${snapshot.error}'),
                    );
                  }
                  if (snapshot.data!.docs.isEmpty) {
                    return Center(
                      child: Text('No payment history available'),
                    );
                  }
                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      headingRowColor: MaterialStateColor.resolveWith((states) => Colors.lightGreen[100]!), // Color de fondo de la fila de encabezado
                      dataRowColor: MaterialStateColor.resolveWith((states) => Colors.lightGreen[50]!), // Color de fondo de las filas de datos
                      columns: const [
                        DataColumn(label: Text('Company Name', style: TextStyle(fontWeight: FontWeight.bold))),
                        DataColumn(label: Text('Phone Number', style: TextStyle(fontWeight: FontWeight.bold))),
                        DataColumn(label: Text('Description', style: TextStyle(fontWeight: FontWeight.bold))),
                        DataColumn(label: Text('Payment Value', style: TextStyle(fontWeight: FontWeight.bold))),
                        DataColumn(label: Text('Status', style: TextStyle(fontWeight: FontWeight.bold))),
                        DataColumn(label: Text('Observation', style: TextStyle(fontWeight: FontWeight.bold))),
                      ],
                      rows: snapshot.data!.docs.map((DocumentSnapshot document) {
                        Map<String, dynamic> data = document.data() as Map<String, dynamic>;
                        return DataRow(
                          cells: [
                            DataCell(Text(data['business_name'] ?? '')),
                            DataCell(Text(data['phone_number'] ?? '')),
                            DataCell(Text(data['description'] ?? '')),
                            DataCell(Text(data['payment_value'] != null ? '\$${data['payment_value']}' : '')),
                            DataCell(Text(data['status'] ?? '')),
                            DataCell(Text(data['observation'] ?? '')),
                          ],
                        );
                      }).toList(),
                    ),
                  );
                },
              ),
              SizedBox(height: 20),
              Image.asset('assets/chica.jpg'), // Aquí se agrega la imagen al final del contenido
            ],
          ),
        ),
      ),
    );
  }
}
