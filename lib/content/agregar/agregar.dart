import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foto_share/content/agregar/bloc/agregar_bloc.dart';
import 'package:image_picker/image_picker.dart';

class Agregar extends StatelessWidget {
  const Agregar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BlocBuilder<AgregarBloc, AgregarState>(
        builder: (context, state) {
          if (state is AgregarLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is AgregarImageSelected) {
            return AddPostForm(image: state.image);
          }
          return const AddPostForm(
            image: null,
          );
        },
      ),
    );
  }
}

class ImagePickerField extends StatelessWidget {
  const ImagePickerField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text("Pick an image"),
        ),
        IconButton(
            onPressed: () async {
              context.read<AgregarBloc>().add(AgregarSelectImage());
            },
            icon: const Icon(Icons.image)),
      ],
    );
  }
}

class AddPostForm extends StatefulWidget {
  final XFile? image;
  const AddPostForm({Key? key, required this.image}) : super(key: key);

  @override
  State<AddPostForm> createState() => _AddPostFormState();
}

class _AddPostFormState extends State<AddPostForm> {
  late TextEditingController _titleController;
  late bool _public;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _public = false;
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: (widget.image == null)
              ? ImagePickerField()
              : AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Image.file(
                    File(widget.image!.path),
                    fit: BoxFit.cover,
                  ),
                ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: _titleController,
            decoration: InputDecoration(
                hintText: "Titulo",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0))),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Publicar"),
            Switch(
              value: _public,
              onChanged: (newValue) {
                setState(() {
                  _public = newValue;
                });
              },
              activeColor: Theme.of(context).primaryColor,
            )
          ],
        ),
        ElevatedButton(
            onPressed: (widget.image != null)
                ? (() async {
                    context.read<AgregarBloc>().add(AgregarSubmit(
                        picture: widget.image!,
                        title: _titleController.text,
                        public: _public));

                    //reset
                    _titleController.clear();
                    _public = false;
                  })
                : null,
            child: const Text("Guardar"))
      ],
    );
    ;
  }
}
