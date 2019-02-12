import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter_architecture/ui/viewmodel/post_list_viewmodel.dart';
import 'package:flutter_architecture/ui/views/post_list_view.dart';
import 'package:flutter_architecture/ui/model/post.dart';

import 'package:http/http.dart' as http;

import 'package:rxdart/rxdart.dart';

import 'package:flutter_architecture/framework/http/client.dart';


class PostListPresenter {

    void fetchPosts() {}

    set postListView(PostListView value) {}
}

class PostListPresenterImpl implements PostListPresenter {

    Client _client = new Client(baseUrl: "https://jsonplaceholder.typicode.com");
    String endpoint = "/posts";

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

        Uri url = Uri.parse(_client.baseUrl + endpoint);
        var response = await this._client.get(url);

        _mViewModel.data = _fromJson(response);
        _mViewModel.isLoading = false;
        this._mView.render(this._mViewModel);

//        final response = await http.get('https://jsonplaceholder.typicode.com/posts');
//        _mViewModel.isLoading = false;
//
//        if (response.statusCode == 200) {
//            _mViewModel.data = _fromJson(json.decode(response.body));
//            this._mView.render(this._mViewModel);
//        } else {
//            throw Exception('Failed to load post');
//        }

//        var list = new List<String>();
//        list.add("prova1");
//        list.add("prova2");
//        list.add("prova3");
//        list.add("prova4");
//        list.add("prova5");
//
//        new Observable(new Stream.fromIterable(list))
//            .interval(new Duration(seconds: 2))
//            .listen((s) => print(s));
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
