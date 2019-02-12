import 'dart:async';

import 'package:flutter_architecture/data/repository/post_repository.dart';
import 'package:flutter_architecture/data/model/remote_post.dart';
import 'package:flutter_architecture/ui/model/post.dart';


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