import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:foto_share/auth/user_auth_repository.dart';
import 'package:foto_share/data/fshare.dart';

class FShareRepository {
  final fshareRef = FirebaseFirestore.instance
      .collection("fshare")
      .withConverter<FShare>(
          fromFirestore: (snap, _) => FShare.fromJson(snap.data()!),
          toFirestore: (user, _) => user.toJson());

  Future<void> create(String title, String image, bool public) async {
    UserAuthRepository authRepo = UserAuthRepository();
    FShare fshare = FShare(
        picture: image,
        public: public,
        uploadedAt: DateTime.now(),
        likes: 0,
        title: title,
        user: authRepo.getCurrentUserID());
    fshareRef.add(fshare);
  }

  Future<void> makePublic(String id) async {
    fshareRef.doc(id).update({"public": true});
  }

  Future<void> makePrivate(String id) async {
    fshareRef.doc(id).update({"public": false});
  }
}
