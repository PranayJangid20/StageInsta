class UserStory {
  String? userName;
  String? userImage;
  List<String>? stories;
  int? watched;
  bool? commenting;
  bool? likable;

  UserStory(
      {this.userName,
        this.userImage,
        this.stories,
        this.watched,
        this.commenting,
        this.likable});

  UserStory.fromJson(Map<String, dynamic> json) {
    userName = json['userName'];
    userImage = json['userImage'];
    stories = json['stories'].cast<String>();
    watched = json['watched'];
    commenting = json['commneting'];
    likable = json['likablity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userName'] = this.userName;
    data['userImage'] = this.userImage;
    data['stoyies'] = this.stories;
    data['watched'] = this.watched;
    data['commneting'] = this.commenting;
    data['likablity'] = this.likable;
    return data;
  }
}
