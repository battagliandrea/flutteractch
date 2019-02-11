import 'package:flutter/material.dart';
import 'package:flutter_architecture/ui/presenter/post_list_presenter.dart';
import 'package:flutter_architecture/ui/views/post_list_component.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new PostListPage(new PostListPresenterImpl(), title: 'Flutter Demo Home Page'),
    );
  }
}


