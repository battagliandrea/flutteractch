import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter_architecture/framework/http/client.dart';
import 'package:flutter_architecture/data/model/remote_post.dart';

class RemoteDataSource{
  Client _client = new Client(baseUrl: "https://randomuser.me/api/");
  String endpoint = "?results=100";

  RemoteDataSource({Client client}) {
    _client = client != null ? client : _client;
  }

  Future<List<RemotePost>> fetchPosts() async {
    try {
      Uri url = Uri.parse(_client.baseUrl + endpoint);
      var res = await this._client.get(url);
      List<Map<String, dynamic>> items = res["posts"];
      List<RemotePost> posts = items
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