class Follow{
  int? statusCode;
  String? message;

  Follow({required this.statusCode,required this.message});

  factory Follow.fromJson(Map<String,dynamic>json){
    return Follow(statusCode: json['status_code']??0, message: json['message']??'');
  }

}