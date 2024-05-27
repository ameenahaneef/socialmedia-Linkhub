class PostsResponse {
  int statusCode;
  String message;
  List<PostData> afterExecution;

  PostsResponse({
    required this.statusCode,
    required this.message,
    required this.afterExecution,
  });

  factory PostsResponse.fromJson(Map<String, dynamic> json) {
    List<dynamic> postsDataJson = json['after execution']['PostsData'] ?? [];
    List<PostData> postsData = postsDataJson.map((data) => PostData.fromJson(data)).toList();

    return PostsResponse(
      statusCode: json['status_code'] ?? 0,
      message: json['message'] ?? '',
      afterExecution: postsData,
    );
  }
}

class PostData {
  int userId;
  String userName;
  String? userprofileimageurl;
  int postId;
  String?caption;
  String postAge;
  List<String> mediaUrl;
  int? likesCount;
  bool? likeStatus;
  int? commentsCount;

  PostData({
    required this.userId,
    required this.userName,
    this.userprofileimageurl,
    required this.postId,
    this.caption,
    required this.postAge,
    required this.mediaUrl,
    this.likesCount,
    this.likeStatus,
    this.commentsCount

  });

  factory PostData.fromJson(Map<String, dynamic> json) {
    List<String> mediaUrl = List<String>.from(json['MediaUrl'] ?? []);
    return PostData(
      userId: json['UserId'] ?? 0,
      userName: json['UserName'] ?? '',
      userprofileimageurl: json['UserProfileImgURL'],
      postId: json['PostId'] ?? 0,
      caption: json['Caption']??'',
      postAge: json['PostAge'] ?? '',
      mediaUrl: mediaUrl,
      likesCount: json['LikesCount']??0,
      likeStatus: json['LikeStatus'],
      commentsCount: json['CommentsCount']??0
    );
  }
}
