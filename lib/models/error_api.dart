class ErrorApi {
  String msg;
  int code;

  ErrorApi(this.msg, this.code);

  factory ErrorApi.fromJson(Map<String, dynamic> json) {
    try {
      return ErrorApi(json['msg'] ?? "", json['code'] ?? 400);
    } on Exception catch (e) {
      return ErrorApi("Unable to connect to service", 500);
    }
  }

  @override
  String toString() {
    return 'ErrorApi{msg: $msg, code: $code}';
  }
}
