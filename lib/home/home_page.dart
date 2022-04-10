import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foto_share/auth/bloc/auth_bloc.dart';
import 'package:foto_share/content/agregar/agregar.dart';
import 'package:foto_share/content/espera/bloc/pending_bloc.dart';
import 'package:foto_share/content/espera/en_espera.dart';
import 'package:foto_share/content/feed/bloc/feed_bloc.dart';
import 'package:foto_share/content/feed/feed.dart';
import 'package:foto_share/content/mi_contenido/bloc/micontenido_bloc.dart';
import 'package:foto_share/content/mi_contenido/mi_contenido.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentPageIndex = 1;

  final _pagesNameList = [
    "Fotos 4U",
    "En espera",
    "Agregar",
    "Mi contenido",
  ];

  final _pagesList = [
    Feed(),
    EnEspera(),
    Agregar(),
    MiContendo(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_pagesNameList[_currentPageIndex]),
        flexibleSpace: Container(
          height: 120,
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [Colors.purple, Colors.red]),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              BlocProvider.of<AuthBloc>(context).add(SignOutEvent());
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: IndexedStack(
        index: _currentPageIndex,
        children: _pagesList,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentPageIndex,
        onTap: (index) {
          switch (index) {
            case 0:
              context.read<FeedBloc>().add(GetMyFeedEvent());
              break;
            case 1:
              context.read<PendingBloc>().add(GetAllMyDisabledFotosEvent());
              break;
            case 3:
              context.read<MicontenidoBloc>().add(GetAllMyPublicFotosEvent());
              break;
            default:
          }
          setState(() {
            _currentPageIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            label: _pagesNameList[0],
            icon: Icon(Icons.view_carousel),
          ),
          BottomNavigationBarItem(
            label: _pagesNameList[1],
            icon: Icon(Icons.query_builder),
          ),
          BottomNavigationBarItem(
            label: _pagesNameList[2],
            icon: Icon(Icons.photo_camera),
          ),
          BottomNavigationBarItem(
            label: _pagesNameList[3],
            icon: Icon(Icons.mobile_friendly),
          ),
        ],
      ),
    );
  }
}
