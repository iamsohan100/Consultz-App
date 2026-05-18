class ResponseModel {
  final int statusCode;
  final bool isSuccess;
  final String? message;
  final dynamic responseData;

  ResponseModel({
    required this.statusCode,
    required this.isSuccess,
    required this.message,
    required this.responseData,
  });
}