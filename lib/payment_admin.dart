import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PaymentAdmin extends StatelessWidget {
  const PaymentAdmin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('payments').snapshots(),
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
              child: Text('No payment data available'),
            );
          }
          return Column(
            children: [
              SizedBox(height: 20),
              Text(
                'Payment Administration',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),
              Text(
                'Payment status confirmation window',
                style: TextStyle(fontSize: 15, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 30),
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    headingRowColor: MaterialStateColor.resolveWith((states) =>
                        Colors.lightGreen[
                            100]!), // Color de fondo de la fila de encabezado
                    dataRowColor: MaterialStateColor.resolveWith((states) =>
                        Colors.lightGreen[
                            50]!), // Color de fondo de las filas de datos
                    columns: const [
                      DataColumn(
                          label: Text('ID Number',
                              style: TextStyle(fontWeight: FontWeight.bold))),
                      DataColumn(
                          label: Text('Full Name',
                              style: TextStyle(fontWeight: FontWeight.bold))),
                      DataColumn(
                          label: Text('Email',
                              style: TextStyle(fontWeight: FontWeight.bold))),
                      DataColumn(
                          label: Text('Business Name',
                              style: TextStyle(fontWeight: FontWeight.bold))),
                      DataColumn(
                          label: Text('Payment Value',
                              style: TextStyle(fontWeight: FontWeight.bold))),
                      DataColumn(
                          label: Text('Status',
                              style: TextStyle(fontWeight: FontWeight.bold))),
                      DataColumn(
                          label: Text('Observation',
                              style: TextStyle(fontWeight: FontWeight.bold))),
                    ],
                    rows: snapshot.data!.docs.map((DocumentSnapshot document) {
                      Map<String, dynamic> data =
                          document.data() as Map<String, dynamic>;
                      String documentID = document.id;

                      return DataRow(
                        cells: [
                          DataCell(Text(data['id_number'] ?? '')),
                          DataCell(Text(data['full_name'] ?? '')),
                          DataCell(Text(data['email'] ?? '')),
                          DataCell(Text(data['business_name'] ?? '')),
                          DataCell(Text(data['payment_value'] != null
                              ? '\$${data['payment_value']}'
                              : '')),
                          DataCell(
                            DropdownButtonFormField<String>(
                              value: (data['status'] != null &&
                                      [
                                        'abierto',
                                        'rechazado',
                                        'anulado',
                                        'pendiente',
                                        'fallido',
                                        'pagado'
                                      ].contains(data['status']))
                                  ? data['status']
                                  : 'abierto',
                              onChanged: (value) {
                                // Actualizar el estado en la colección de Firestore
                                FirebaseFirestore.instance
                                    .collection('payments')
                                    .doc(documentID)
                                    .update({'status': value});
                              },
                              items: [
                                'abierto',
                                'rechazado',
                                'anulado',
                                'pendiente',
                                'fallido',
                                'pagado'
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ),
                          DataCell(
                            TextFormField(
                              initialValue: data['observation'] ?? '',
                              onChanged: (value) {
                                // Actualizar la observación en la colección de Firestore
                                FirebaseFirestore.instance
                                    .collection('payments')
                                    .doc(documentID)
                                    .update({'observation': value});
                              },
                              decoration: InputDecoration(
                                hintText: 'Enter observation...',
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                ),
              ),
             
               
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('The changes were saved successfully.'),
                      backgroundColor: Colors.green,
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  );
                },
                child: Text('Save Changes'),
              ),
            ],
          );
        },
      ),
    );
  }
}
