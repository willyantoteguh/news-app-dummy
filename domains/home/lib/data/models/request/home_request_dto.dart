class HomeRequestDto {
  final String? q;
  final dynamic language;
  final int? pageSize;
  final int? page;

  HomeRequestDto({
    this.q,
    this.language,
    this.pageSize,
    this.page,
  });

  Map<String, dynamic> toJson() {
    return {
      'q': q,
      'language': language,
      'pageSize': pageSize,
      'page': page,
    };
  }
}
