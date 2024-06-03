class ApiResponse {
  final int statusCode;
  final String message;
  final List<User> users;

  ApiResponse({
    required this.statusCode,
    required this.message,
    required this.users,
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    List<dynamic> dataList = json['after execution']['SearchResult'] ?? [];
    List<User> usersList = dataList.map((item) => User.fromJson(item)).toList();

    return ApiResponse(
      statusCode: json['status_code'] ?? 0,
      message: json['message'] ?? '',
      users: usersList,
    );
  }
}
class User {
  final int userId;
  final String name;
  final String username;
  final String? userProfileImage;
 // final bool followingStatus;

  User({
    required this.userId,
    required this.name,
    required this.username,
     this.userProfileImage
   // required this.followingStatus,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['UserId'] ?? 0,
      name: json['Name'] ?? '',
      username: json['UserName'] ?? '',
      userProfileImage: json['ProfileImageURL']
      //followingStatus: json['following_status'] ?? false,
    );
  }

}
