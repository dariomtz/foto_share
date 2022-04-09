import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foto_share/content/agregar/bloc/agregar_bloc.dart';

class Agregar extends StatefulWidget {
  const Agregar({Key? key}) : super(key: key);

  @override
  State<Agregar> createState() => _AgregarState();
}

class _AgregarState extends State<Agregar> {
  late TextEditingController _titleController;
  late TextEditingController _imageController;
  late bool _public;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _imageController = TextEditingController();
    _public = false;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _imageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BlocBuilder<AgregarBloc, AgregarState>(
        builder: (context, state) {
          if (state is AgregarLoading) {
            return Center(child: CircularProgressIndicator());
          }
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _imageController,
                  decoration: InputDecoration(
                      hintText: "URL de la imagen",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0))),
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
                  Text("Publicar"),
                  Switch(
                      value: _public,
                      onChanged: (newValue) {
                        setState(() {
                          _public = newValue;
                        });
                      })
                ],
              ),
              ElevatedButton(
                  onPressed: () {
                    context.read<AgregarBloc>().add(AgregarSubmit(
                        picture: _imageController.text,
                        title: _titleController.text,
                        public: _public));

                    //reset
                    _imageController.clear();
                    _titleController.clear();
                    _public = false;
                  },
                  child: Text("Guardar"))
            ],
          );
        },
      ),
    );
  }
}
