class RemotePost {
  
  int userId;
  
  int id;
  
  String title;
  
  String body;

  RemotePost.fromMap(Map<String, dynamic> map)
      :
        userId = map['userId'],
        id = map['id'],
        title = map['title'],
        body = map['body'];

}