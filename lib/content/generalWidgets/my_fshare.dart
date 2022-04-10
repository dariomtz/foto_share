import 'package:flutter/material.dart';
import 'package:foto_share/data/fshare.dart';
import 'package:foto_share/storage/fshare_repository.dart';

class MyFShare extends StatefulWidget {
  final FShare fshare;
  final String fshareId;
  const MyFShare({Key? key, required this.fshare, required this.fshareId})
      : super(key: key);

  @override
  State<MyFShare> createState() => _MyFShareState();
}

class _MyFShareState extends State<MyFShare> {
  FShareRepository fshareRepo = FShareRepository();
  bool _switchValue = false;
  @override
  void initState() {
    _switchValue = widget.fshare.public;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Image.network(
                widget.fshare.picture,
                fit: BoxFit.cover,
              ),
            ),
            SwitchListTile(
              title: Text(widget.fshare.title),
              subtitle: Text("${widget.fshare.uploadedAt.toLocal()}"),
              value: _switchValue,
              onChanged: (newVal) {
                fshareRepo.updatePublic(widget.fshareId, newVal);
                setState(() {
                  _switchValue = newVal;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
