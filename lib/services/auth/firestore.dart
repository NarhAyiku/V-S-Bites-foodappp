import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {

  // get collection of order 
  final  CollectionReference order = FirebaseFirestore.instance.collection('orders');

  // save to db 
  Future<void> saveOrderToDatabase(String receipt) async {
      await order.add({
        'data':DateTime.now(),
        'order': receipt,
        // add more fields as needed...
      });
    }
  }
