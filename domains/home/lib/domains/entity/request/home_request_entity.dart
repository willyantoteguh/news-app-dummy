class HomeRequestEntity {
  final String q;
  final String category;
  final dynamic language;
  final int pageSize;
  final int page;

  HomeRequestEntity({
    required this.q,
    required this.category,
    required this.language,
    required this.pageSize,
    required this.page,
  });
}
