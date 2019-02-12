import 'dart:async';

import 'package:flutter_architecture/data/model/remote_post.dart';
import 'package:flutter_architecture/data/datasource/remote_data_source.dart';

abstract class PostRepository {
  Future<List<RemotePost>> fetchPosts();
}

class PostRepositoryImpl implements PostRepository {

  RemoteDataSource remoteDataSource;

  PostRepositoryImpl(RemoteDataSource remoteDataSource) {
    this.remoteDataSource = remoteDataSource;
  }

  @override
  Future<List<RemotePost>> fetchPosts() async {
    List<RemotePost> users = await remoteDataSource.fetchPosts();

    if (users.length > 0) {
      return users;
    } else {
      return new List<RemotePost>();
    }
  }
}