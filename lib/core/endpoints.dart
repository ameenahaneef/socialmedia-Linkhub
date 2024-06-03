const apikey = 'apikey@ciao';

class EndPoints {
  static String baseUrl = "https://ciao.ashkar.tech";
  static String signupUrl = "/signup";
  static String otpUrl = "/verify";
  static String loginUrl = "/login";
  static String forgotPassworUrl = "/forgotpassword";
  static String resetPasswordUrl = "/resetpassword";
  static String profileUrl = "/profile";
  static String postAddUrl = "/post/";
  static String globalPost="/explore";
  static String followinglist="/profile/following";
  static String followerslist="/profile/followers";
  static String homepost="/post/userrelatedposts";
  static String editProfile="/profile/edit";
  static String accessRegenerator='/accessgenerator';
  static String setProfile='/profile/setprofileimage';
  static String addComment='/post/comment';
  static String getComment='/post/comment/';
  static String likePost='/post/like/';
  static String socketBaseUrl="wss://ciao.ashkar.tech/chat/ws";
  static String chatSummary='/chat/recentchatprofiles';
  static String oneToOneChat='/chat/onetoonechats/';
}
