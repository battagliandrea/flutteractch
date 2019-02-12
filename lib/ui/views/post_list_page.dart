import 'package:flutter/material.dart';
import 'package:flutter_architecture/ui/presenter/post_list_presenter.dart';
import 'package:flutter_architecture/ui/viewmodel/post_list_viewmodel.dart';
import 'package:flutter_architecture/ui/views/post_list_view.dart';
import 'package:flutter_architecture/ui/model/post.dart';


class PostListPage extends StatefulWidget {
    final PostListPresenter presenter;

    PostListPage(this.presenter, {Key key, this.title}) : super(key: key);

    final String title;

    @override
    _PostListPageState createState() => new _PostListPageState();
}

class _PostListPageState extends State<PostListPage> implements PostListView {

    PostListViewModel _viewModel;

    final TextStyle _biggerFont = const TextStyle(fontSize: 18.0);


    @override
    void initState() {
        super.initState();
        this.widget.presenter.postListView = this;
    }
    
    @override
    void render(PostListViewModel viewModel) {
        setState(() {
            this._viewModel = viewModel;
        });
    }

    @override
    Widget build(BuildContext context) {
        return new Scaffold(
            appBar: new AppBar(
                title: new Text(widget.title),
            ),
            body: new Center(
                child: _buildListView()
            )
        );
    }

    Widget _buildListView() {
        if(_viewModel != null){
            if(_viewModel.isLoading){
                return CircularProgressIndicator();
            } else {
                return new ListView.builder(
                    padding: const EdgeInsets.all(16.0),

                    itemCount: _viewModel.data.length,

                    itemBuilder: (BuildContext _context, int i) {
                        return _buildRow(i, _viewModel.data[i]);
                    }
                );
            }
        }
    }

    Widget _buildRow(int index, Post post) {
        return new ListTile(
            title: new Text(
                "$index. ${post.title}",
                style: _biggerFont,
            )
        );
    }
}