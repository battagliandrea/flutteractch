import 'dart:async';
import 'dart:convert';

import 'package:flutter_architecture/ui/viewmodel/post_list_viewmodel.dart';
import 'package:flutter_architecture/ui/views/post_list_view.dart';
import 'package:flutter_architecture/ui/model/post.dart';

import 'package:http/http.dart' as http;

class PostListPresenter {

    void fetchPosts() {}

    set postListView(PostListView value) {}
}

class PostListPresenterImpl implements PostListPresenter {

    PostListViewModel _mViewModel;
    PostListView _mView;

    PostListPresenterImpl() {
        this._mViewModel = new PostListViewModel();
    }

    @override
    void fetchPosts() {
        _fetchPost();
    }

    @override
    set postListView(PostListView value) {
        _mView = value;
        this._mView.render(this._mViewModel);
        _fetchPost();
    }

    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //          UTILS METHOD
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    _fetchPost() async {
        final response = await http.get('https://jsonplaceholder.typicode.com/posts');
        _mViewModel.isLoading = false;

        if (response.statusCode == 200) {
            _mViewModel.data = _fromJson(json.decode(response.body));
            this._mView.render(this._mViewModel);
        } else {
            throw Exception('Failed to load post');
        }
    }


    List<Post> _fromJson(List<dynamic> json) {
        List<Post> data = new List();

        for (var j in json) {
            var p = new Post(
                userId: j['userId'],
                id: j['id'],
                title: j['title'],
                body: j['body'],
            );
            data.add(p);
        }

        return data;
    }
}
