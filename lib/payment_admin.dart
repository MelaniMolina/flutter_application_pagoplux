import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PaymentAdmin extends StatelessWidget {
  const PaymentAdmin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment Administration'),
      ),
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
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columns: const [
                DataColumn(label: Text('ID Number')),
                DataColumn(label: Text('Full Name')),
                DataColumn(label: Text('Email')),
                DataColumn(label: Text('Business Name')),
                DataColumn(label: Text('Payment Value')),
                DataColumn(label: Text('Status')),
                DataColumn(label: Text('Observation')),
              ],
              rows: snapshot.data!.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data = document.data() as Map<String, dynamic>;
                return DataRow(
                  cells: [
                    DataCell(Text(data['id_number'] ?? '')),
                    DataCell(Text(data['full_name'] ?? '')),
                    DataCell(Text(data['email'] ?? '')),
                    DataCell(Text(data['business_name'] ?? '')),
                    DataCell(Text(data['payment_value'] != null ? '\$${data['payment_value']}' : '')),
                    DataCell(
                      DropdownButtonFormField<String>(
                        value: data['status'] ?? 'abierto',
                        onChanged: (value) {
                          // Aquí puedes actualizar el estado en la base de datos
                          print('Selected status: $value');
                        },
                        items: ['abierto', 'rechazado', 'anulado', 'pendiente', 'fallido', 'pagado'].map<DropdownMenuItem<String>>((String value) {
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
                          // Aquí puedes actualizar la observación en la base de datos
                          print('Observation updated: $value');
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
          );
        },
      ),
    );
  }
}
