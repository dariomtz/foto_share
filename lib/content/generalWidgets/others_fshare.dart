import 'dart:io';

import 'package:flutter/material.dart';
import 'package:foto_share/data/fshare.dart';
import 'package:foto_share/storage/fshare_repository.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:http/http.dart' as http;

class OthersShare extends StatelessWidget {
  final FShare fshare;
  final String fshareId;
  const OthersShare({Key? key, required this.fshare, required this.fshareId})
      : super(key: key);

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
                fshare.picture,
                fit: BoxFit.cover,
              ),
            ),
            ListTile(
              title: Text(fshare.title),
              subtitle: Text("${fshare.uploadedAt.toLocal()}"),
              trailing: IconButton(
                  onPressed: () async {
                    final url = Uri.parse(fshare.picture);
                    final response = await http.get(url);
                    final bytes = response.bodyBytes;

                    final temp = await getTemporaryDirectory();
                    final path = '${temp.path}/image.jpg';
                    File(path).writeAsBytesSync(bytes);

                    await Share.shareFiles([path], text: fshare.title);
                  },
                  icon: Icon(Icons.share)),
            )
          ],
        ),
      ),
    );
  }
}
