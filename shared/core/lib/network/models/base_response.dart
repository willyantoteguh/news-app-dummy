class BaseResponse {
  BaseResponse();

  late String status;
  late int totalResults;

  factory BaseResponse.fromJson(Map<String, dynamic> json) => _$BaseResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BaseResponseToJson(this);
}

BaseResponse _$BaseResponseFromJson(Map<String, dynamic> json) {
  return BaseResponse()
    ..status = json["status"]
    ..totalResults = json["total_results"];
}

Map<String, dynamic> _$BaseResponseToJson(BaseResponse instance) => <String, dynamic>{
      "total_count": instance.status,
      "incomplete_results": instance.totalResults,
    };
