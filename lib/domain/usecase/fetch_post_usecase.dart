import 'dart:async';

import 'package:flutter_architecture/data/repository/repository.dart';
import 'package:flutter_architecture/data/model/model.dart';

import 'package:flutter_architecture/presentation/model/model.dart';

class FetchPostsUseCase {
  PostRepository postRepository;

  FetchPostsUseCase(PostRepository postRepository) {
    this.postRepository = postRepository;
  }

  Future<List<Post>> fetchPosts() async {
    List<RemotePost> result = await postRepository.fetchPosts();

    return asUIContent(result);
  }

  //TODO: move into datasource
  List<Post> asUIContent(List<RemotePost> resultSource) {
    List<Post> resultList = new List<Post>();
    if (resultSource != null) {
      resultSource.forEach((u) => resultList.add(new Post(u)));
    }
    return resultList;
  }
}