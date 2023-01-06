class HomeRequestDto {
  final String? q;
  final String? category;
  final dynamic language;
  final int? pageSize;
  final int? page;

  HomeRequestDto({
    this.q,
    this.category,
    this.language,
    this.pageSize,
    this.page,
  });

  Map<String, dynamic> toJson() {
    return {
      'q': q,
      'category': category,
      'language': language,
      'pageSize': pageSize,
      'page': page,
    };
  }
}
