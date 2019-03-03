import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter_architecture/framework/http/client.dart';
import 'package:flutter_architecture/data/model/remote_post.dart';

class RemoteDataSource{
  Client _client = new Client(baseUrl: "https://jsonplaceholder.typicode.com");
  String endpoint = "/posts";

  RemoteDataSource({Client client}) {
    _client = client != null ? client : _client;
  }

  Future<List<RemotePost>> fetchPosts() async {
    try {
      Uri url = Uri.parse(_client.baseUrl + endpoint);
      List <dynamic> res = await this._client.get(url);
      List<RemotePost> posts = res
          .map((p) => new RemotePost.fromMap(p))
          .toList();
      return posts;
    } on HttpException catch (e) {
      return [];
    } catch (err) {
      return [];
    }
  }
}