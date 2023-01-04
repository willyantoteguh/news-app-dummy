class HomeRequestEntity {
  final String q;
  final dynamic language;
  final int pageSize;
  final int page;

  HomeRequestEntity({
    required this.q,
    required this.language,
    required this.pageSize,
    required this.page,
  });
}
