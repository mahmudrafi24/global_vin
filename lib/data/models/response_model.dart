class ResponseModel<T> {
  final bool success;
  final String? message;
  final T? data;

  ResponseModel({
    required this.success,
    this.message,
    this.data,
  });

  factory ResponseModel.fromJson(
    Map<String, dynamic> json,
    T Function(dynamic)? fromJsonT,
  ) {
    return ResponseModel(
      success: json['success'] as bool? ?? false,
      message: json['message'] as String?,
      data: json['data'] != null && fromJsonT != null
          ? fromJsonT(json['data'])
          : null,
    );
  }
}
