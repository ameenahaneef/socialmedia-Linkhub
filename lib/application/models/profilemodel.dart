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
   ProfileModel copyWith({
    int? statusCode,
    String? message,
    AfterExecution? afterExecution,
  }) {
    return ProfileModel(
      statusCode: statusCode ?? this.statusCode,
      message: message ?? this.message,
      afterExecution: afterExecution ?? this.afterExecution,
    );
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

 AfterExecution copyWith({
    String? name,
    String? username,
    int? postsCount,
    int? followersCount,
    int? followingCount,
  }) {
    return AfterExecution(
      name: name ?? this.name,
      username: username ?? this.username,
      postsCount: postsCount ?? this.postsCount,
      followersCount: followersCount ?? this.followersCount,
      followingCount: followingCount ?? this.followingCount,
    );
  }

}
