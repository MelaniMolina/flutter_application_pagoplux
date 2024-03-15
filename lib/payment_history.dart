import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PaymentHistory extends StatelessWidget {
  final String currentUserEmail;

  const PaymentHistory({Key? key, required this.currentUserEmail}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment History'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('payments')
            .where('email', isEqualTo: currentUserEmail) // Filtrar por correo electrónico del usuario actual
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
              columns: const [
                DataColumn(label: Text('Company Name')),
                DataColumn(label: Text('Phone Number')),
                DataColumn(label: Text('Description')),
                DataColumn(label: Text('Payment Value')),
                DataColumn(label: Text('Status')),
                DataColumn(label: Text('Observation')),
              ],
              rows: snapshot.data!.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data = document.data() as Map<String, dynamic>;
                return DataRow(
                  cells: [
                    DataCell(Text(data['business_name'] ?? '')),
                    DataCell(Text(data['phone_number'] ?? '')),
                    DataCell(Text(data['description'] ?? '')),
                    DataCell(Text(data['payment_value'] != null
                        ? '\$${data['payment_value']}'
                        : '')),
                    DataCell(Text('Solicitud')), // Assuming all payments are paid
                    DataCell(Text('')), // Empty observation by default
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
