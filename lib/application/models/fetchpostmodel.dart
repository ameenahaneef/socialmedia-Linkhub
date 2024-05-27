class FetchModel {
  int statusCode;
  String message;
  List<After> afterExecution;

  FetchModel({
    required this.statusCode,
    required this.message,
    required this.afterExecution,
  });
  factory FetchModel.fromJson(Map<String, dynamic> json) {
    List<dynamic> afterExecutionList = json['after execution']['PostsData'] ?? [];
    List<After> afterExecutions =
        afterExecutionList.map((e) => After.fromJson(e)).toList();
    return FetchModel(
        statusCode: json['status_code'] ?? 0,
        message: json['message'] ?? '',
        afterExecution: afterExecutions);
  }
}

class After {
  int? userid;
  String? username;
  String? userprofileimageurl;
  int? postid;
  //bool? likeStatus;
  String? caption;
  //String? likesCount;
  //String? commentsCount;
  String? postAge;
  List<String>? mediaUrls;

  After({
    this.userid,
    this.username,
    this.userprofileimageurl,
    this.postid,
    //this.likeStatus,
    this.caption,
    //this.likesCount,
    //this.commentsCount,
    this.postAge,
    this.mediaUrls,
  });
  factory After.fromJson(Map<String, dynamic> json) {
    return After(
        userid: json['userId'] ?? 0,
        username: json['UserName'] ?? '',
        userprofileimageurl: json['UserProfileImageUrl'] ?? '',
        postid: json['PostId'] ?? 0,
        //likeStatus: json['like_status'] ?? false,
        caption: json['Caption'] ?? '',
        //likesCount: json['likes_count'] ?? '',
        //commentsCount: json['comments_count'] ?? '',
        postAge: json['PostAge'] ?? '',
        mediaUrls: json['MediaUrl'] != null
            ? List<String>.from(json['MediaUrl'])
            : []);
  }
}
