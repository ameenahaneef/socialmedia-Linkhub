class FollowingInfo {
  int statusCode;
  String message;
  List<FollowingUser> afterExecution;

  FollowingInfo({
    required this.statusCode,
    required this.message,
    required this.afterExecution,
  });

  factory FollowingInfo.fromJson(Map<String, dynamic> json) {
    List<dynamic> afterExecutionJson = json['after execution']['UserData'] ?? [];
    List<FollowingUser> afterExecutionData =
        afterExecutionJson.map((data) => FollowingUser.fromJson(data)).toList();

    return FollowingInfo(
      statusCode: json['status_code'] ?? 0,
      message: json['message'] ?? '',
      afterExecution: afterExecutionData,
    );
  }
}

class FollowingUser {
  int userId;
  String name;
  String username;
  String? profileImageUrl;
  //bool followingStatus;

  FollowingUser({
    required this.userId,
    required this.name,
    required this.username,
    this.profileImageUrl
   // required this.followingStatus,
  });

  factory FollowingUser.fromJson(Map<String, dynamic> json) {
    return FollowingUser(
      userId: json['UserId'] ?? 0,
      name: json['Name'] ?? '',
      username: json['UserName'] ?? '',
      profileImageUrl: json['ProfileImageURL']??''
      //followingStatus: json['following_status'] ?? false,
    );
  }
}
