class FetchModel {
  int statusCode;
  String message;
  List<AfterExecution> afterExecution;

  FetchModel({
    required this.statusCode,
    required this.message,
    required this.afterExecution,
  });
  factory FetchModel.fromJson(Map<String, dynamic> json) {
    List<dynamic> afterExecutionList = json['after execution']??[];
    List<AfterExecution> afterExecutions =
        afterExecutionList.map((e) => AfterExecution.fromJson(e)).toList();
    return FetchModel(
        statusCode: json['status_code']??0,
        message: json['message']??'',
        afterExecution: afterExecutions);
  }

 
}

class AfterExecution {
  int? userid;
  String? username;
  String? userprofileimageurl;
  int? postid;
  bool? likeStatus;
  String? caption;
  String? likesCount;
  String? commentsCount;
  String? postAge;
  List<String>? mediaUrls;

  AfterExecution({
     this.userid,
     this.username,
     this.userprofileimageurl,
     this.postid,
     this.likeStatus,
     this.caption,
     this.likesCount,
     this.commentsCount,
     this.postAge,
     this.mediaUrls,
  });
  factory AfterExecution.fromJson(Map<String, dynamic> json) {
    return AfterExecution(
        userid: json['userid']??0,
        username: json['username']??'',
        userprofileimageurl: json['userprofileimageurl']??'',
        postid: json['postid']??0,
        likeStatus: json['like_status']??false,
        caption: json['caption']??'',
        likesCount: json['likes_count']??'',
        commentsCount: json['comments_count']??'',
        postAge: json['post-age']??'',
        mediaUrls: json['media-urls']!=null?List<String>.from(json['media-urls']):[]);
  }
}
