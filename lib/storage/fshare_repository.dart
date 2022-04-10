import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:foto_share/auth/user_auth_repository.dart';
import 'package:foto_share/data/fshare.dart';
import 'package:foto_share/storage/image_repository.dart';
import 'package:image_picker/image_picker.dart';

class FShareRepository {
  final CollectionReference<FShare> fshareRef = FirebaseFirestore.instance
      .collection("fshare")
      .withConverter<FShare>(
          fromFirestore: (snap, _) => FShare.fromJson(snap.data()!),
          toFirestore: (user, _) => user.toJson());

  final ImageRepository imageRepo = ImageRepository();
  final UserAuthRepository authRepo = UserAuthRepository();

  Future<void> create(String title, XFile image, bool public) async {
    final String userId = authRepo.getCurrentUserID();
    final String imageURL = await imageRepo.upload(
      image,
      userId,
    );
    FShare fshare = FShare(
        picture: imageURL,
        public: public,
        uploadedAt: DateTime.now(),
        likes: 0,
        title: title,
        user: userId);
    fshareRef.add(fshare);
  }

  Future<void> updatePublic(String id, bool public) async {
    Map<String, dynamic> changes = {"public": public};
    if (public) {
      changes["uploadedAt"] = Timestamp.fromDate(DateTime.now());
    }
    await fshareRef.doc(id).update(changes);
  }

  Future<Map<String, FShare>> _retrievePosts(
      bool Function(FShare) filter) async {
    var snap = await fshareRef.get();
    var values = snap.docs.map((doc) => doc.data()).where(filter).toList();
    var keys = snap.docs
        .where((doc) => filter(doc.data()))
        .map((doc) => doc.id)
        .toList();
    return Map.fromIterables(keys, values);
  }

  Future<Map<String, FShare>> retrieveFeed() {
    return _retrievePosts((fshare) =>
        fshare.user != authRepo.getCurrentUserID() && fshare.public == true);
  }

  Future<Map<String, FShare>> retrieveMyPosts({public}) {
    return _retrievePosts((fshare) =>
        fshare.user == authRepo.getCurrentUserID() && fshare.public == public);
  }
}
