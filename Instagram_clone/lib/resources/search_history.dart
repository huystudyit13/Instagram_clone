import 'package:cloud_firestore/cloud_firestore.dart';

class SearchHistory {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addSearchHistory(String searchId, String username, String uid,
      String name, String profilePic) async {
      _firestore
          .collection('users')
          .doc(uid)
          .collection('search')
          .doc(searchId)
          .set({
        'profilePic': profilePic,
        'name': name,
        'uid': searchId,
        'username': username,
        'time': DateTime.now(),
      });
  }

}
