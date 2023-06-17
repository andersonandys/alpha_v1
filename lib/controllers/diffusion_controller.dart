import 'package:alpha/constants/app_constants.dart';
import 'package:alpha/models/diffusion_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DiffusionController {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// DANS LE CAS 'UNE LISTE DE DIFFUSIONS'
  Future<List<DiffusionModel>> getDiffusions() async {
    QuerySnapshot querySnapshot = await _db
        .collection(AppConstants.collectionDiffusionFS)
        // .where("iduser", isEqualTo: _auth.currentUser!.uid)
        .get();

    return querySnapshot.docs
        .map((doc) =>
            DiffusionModel.fromJson(doc.data() as Map<String, dynamic>))
        .toList();
  }

  /// DANS LE CAS 'UNE SEULE DIFFUSION'
  // Future<DiffusionModel> getDiffusion() async {
  //   DocumentSnapshot documentSnapshot =
  //       await _db.collection('diffusions').doc("ID_DOCUMENT").get();

  //   return DiffusionModel.fromJson(
  //       documentSnapshot.data() as Map<String, dynamic>);
  // }
}
