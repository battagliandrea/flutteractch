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
        this._mViewModel = new PostListViewModel(_fetchPost());
    }

    @override
    void fetchPosts() {
        _fetchPost();
    }

    @override
    set postListView(PostListView value) {
        _mView = value;
        this._mView.populateList(this._mViewModel);
    }

    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //          UTILS METHOD
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    Future<List<Post>> _fetchPost() async {
        final response =
        await http.get('https://jsonplaceholder.typicode.com/posts');

        if (response.statusCode == 200) {
            return _fromJson(json.decode(response.body));
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
//    @override
//    void onButton1Clicked() {
//       this._counterViewModel.counter++;
//       this._counterView.refreshCounter(this._counterViewModel);
//    }
//
//    @override
//    set counterView(PostListView value) {
//        _mView = value;
//        this._mView.refreshCounter(this._mViewModel);
//    }


}
