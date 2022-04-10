import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class ImageRepository {
  final Reference ref = FirebaseStorage.instance.ref();
  final Uuid uuid = const Uuid();

  Future<String> upload(
    XFile image,
    String userID,
  ) async {
    final metadata = SettableMetadata(
      contentType: image.mimeType,
    );
    final Reference fileRef = ref.child(userID).child(uuid.v4());
    await fileRef.putData(await image.readAsBytes(), metadata);
    final String downlaodURL = await fileRef.getDownloadURL();
    return downlaodURL;
  }
}
