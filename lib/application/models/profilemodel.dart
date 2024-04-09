class ProfileModel {
  int statusCode;
  String message;
  AfterExecution? afterExecution;

  ProfileModel({
    required this.statusCode,
    required this.message,
    required this.afterExecution,
  });
  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
        statusCode: json['status_code'],
        message: json['message'],
        afterExecution: json['after execution'] != null
            ? AfterExecution.fromJson(json['after execution'])
            : null);
  }
}

class AfterExecution {
  String name;
  String username;
  int postsCount;
  int followersCount;
  int followingCount;

  AfterExecution({
    required this.name,
    required this.username,
    required this.postsCount,
    required this.followersCount,
    required this.followingCount,
  });
  factory AfterExecution.fromJson(Map<String, dynamic> json) {
    return AfterExecution(
        name: json['name'],
        username: json['username'],
        postsCount: json['posts_count'],
        followersCount: json['followers_count'],
        followingCount: json['following_count']);
  }
}
