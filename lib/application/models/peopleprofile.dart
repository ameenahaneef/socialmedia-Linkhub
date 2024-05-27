class People {
  int statuscode;
  String message;
  PeopleAfter afterexecution;
  People(
      {required this.statuscode,
      required this.message,
      required this.afterexecution});
  factory People.fromJson(Map<String, dynamic> json) {
    return People(
        statuscode: json['status_code'],
        message: json['message'],
        afterexecution: PeopleAfter.fromJson(json['after execution']));
  }
}

class PeopleAfter {
  int userid;
  String name;
  String username;
  String? bio;
  String? links;
  String? userprofileimageurl;
  int postcount;
  int followerscount;
  int followingcount;
  bool followingstatus;
  PeopleAfter(
      {required this.userid,
      required this.name,
      required this.username,
       this.bio,
       this.links,
       this.userprofileimageurl,
      required this.postcount,
      required this.followerscount,
      required this.followingcount,
      required this.followingstatus});

  factory PeopleAfter.fromJson(Map<String, dynamic> json) {
    return PeopleAfter(
        userid: json['UserId'],
        name: json['Name']??'',
        username: json['UserName']??'',
        bio: json['Bio']??'',
        links: json['Links']??'',
        userprofileimageurl: json['UserProfileImageURL']??'',
        postcount: json['PostsCount']??0,
        followerscount: json['FollowersCount']??0,
        followingcount: json['FollowingCount']??0,
        followingstatus: json['Following_status']??false);
  }
}
