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
        statusCode: json['status_code']??0,
        message: json['message']??'',
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
  int id;
  String name;
  String username;
  String bio;
  String links;
  String userprofileimageurl;
  int postsCount;
  int followersCount;
  int followingCount;

  AfterExecution({
    required this.id,
    required this.name,
    required this.username,
    required this.bio,
    required this.links,
    required this.userprofileimageurl,
    required this.postsCount,
    required this.followersCount,
    required this.followingCount,
  });
  factory AfterExecution.fromJson(Map<String, dynamic> json) {
    return AfterExecution(
id:json['userid']??0,
        name: json['Name']??'',
        username: json['UserName']??'',
        bio: json['Bio']??'',
        links: json['Links']??'',
        userprofileimageurl: json['UserProfileImageURL']??'',
        postsCount: json['PostsCount']??0,
        followersCount: json['FollowersCount']??0,
        followingCount: json['FollowingCount']??0,
        );
  }

 AfterExecution copyWith({
    String? name,
    String? username,
    int? postsCount,
    int? followersCount,
    int? followingCount,
  }) {
    return AfterExecution(
      id: id,
      name: name ?? this.name,
      username: username ?? this.username,
      bio: bio,
      links: links,
      userprofileimageurl: userprofileimageurl,
      postsCount: postsCount ?? this.postsCount,
      followersCount: followersCount ?? this.followersCount,
      followingCount: followingCount ?? this.followingCount,
    );
  }

}
