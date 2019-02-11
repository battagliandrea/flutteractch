import 'package:flutter_architecture/ui/model/post.dart';

class PostListViewModel {

    List<Post> data;
    bool isLoading;

    PostListViewModel(){
        this.isLoading = true;
        this.data =  new List<Post>();
    }


}