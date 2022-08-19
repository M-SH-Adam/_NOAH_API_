class EndPoints {
  static const String loginEndpoint = "auth/local/login?role=user";
  static  String userById(userId) => "users/$userId";
  static const String attendance = "attendance";
  static const String activeAttendance = "attendance/active";
  static String updateAttendance(attendanceId) => "attendance/$attendanceId";
  static const String getAudits = "audits";
  static const String createReport = "reports";
  static const String createLeaves = "leaves";


  static String registerEndpoint = "auth/local/register";
  static String verifyEndpoint = "auth/local/verify";
  static const forgetPasswordEndpoint = 'auth/local/reset-password';
  static const verifyResetPassword = 'auth/local/verify-password';
  static String userEndPoint(userId) => "/users/$userId";
  static  updateFCMToken (userId) => '/users/$userId/fcm-token';
}
