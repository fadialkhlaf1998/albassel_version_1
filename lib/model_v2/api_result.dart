class ApiResult {
  final int code;
  final String message;
  final bool succ;

  ApiResult({
    required this.code,
    required this.message,
    required this.succ,
  });

  factory ApiResult.fromJson(Map<String, dynamic> json) {
    return ApiResult(
      code: json['code'] as int,
      message: json['message'] as String,
      succ: json['code']==1?true:false
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'message': message,
      'succ': succ,
    };
  }
}

