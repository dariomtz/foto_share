import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:foto_share/storage/fshare_repository.dart';
import 'package:image_picker/image_picker.dart';

part 'agregar_event.dart';
part 'agregar_state.dart';

class AgregarBloc extends Bloc<AgregarEvent, AgregarState> {
  final ImagePicker _picker = ImagePicker();

  AgregarBloc() : super(AgregarImageNotSelected()) {
    on<AgregarSelectImage>(_selectImage);
    on<AgregarSubmit>(_addPost);
  }

  Future<void> _selectImage(AgregarSelectImage event, emit) async {
    emit(AgregarLoading());
    print("this is getting called");
    XFile? image;
    try {
      image = await _picker.pickImage(source: ImageSource.gallery);
      print(image);
    } catch (e) {
      print(e);
    }

    if (image == null) {
      print("Hey this mf is returning null :S");
      emit(AgregarImageNotSelected());
    } else {
      print("Hey this mf is working :S");
      emit(AgregarImageSelected(image: image));
    }
  }

  Future<void> _addPost(AgregarSubmit event, emit) async {
    FShareRepository fshareRepo = FShareRepository();
    emit(AgregarLoading());
    await fshareRepo.create(event.title, event.picture, event.public);
    emit(AgregarImageNotSelected());
  }
}
