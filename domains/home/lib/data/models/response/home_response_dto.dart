import 'package:core/network/models/base_response.dart';

class HomeResponseDto extends BaseResponse {
  HomeResponseDto({this.articles});

  List<Article>? articles;

  factory HomeResponseDto.fromJson(Map<String, dynamic> json) {
    return HomeResponseDto()..articles = List<Article>.from(json["articles"].map((x) => Article.fromJson(x)));
  }
}

class Article {
  Article({
    // required this.source,
    required this.author,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.content,
  });

  // final Source? source;
  final String? author;
  final String? title;
  final String? description;
  final String? url;
  final String? urlToImage;
  final String? publishedAt;
  final String? content;

  Article copyWith({
    // Source? source,
    String? author,
    String? title,
    String? description,
    String? url,
    String? urlToImage,
    String? publishedAt,
    String? content,
  }) =>
      Article(
        // source: source ?? this.source,
        author: author ?? this.author,
        title: title ?? this.title,
        description: description ?? this.description,
        url: url ?? this.url,
        urlToImage: urlToImage ?? this.urlToImage,
        publishedAt: publishedAt ?? this.publishedAt,
        content: content ?? this.content,
      );

  factory Article.fromJson(Map<String, dynamic> json) => Article(
        // source: json["source"] == null ? null : Source.fromJson(json["source"]),
        author: json["author"] == null ? null : json["author"],
        title: json["title"] == null ? null : json["title"],
        description: json["description"] == null ? null : json["description"],
        url: json["url"] == null ? null : json["url"],
        urlToImage: json["urlToImage"] == null ? null : json["urlToImage"],
        publishedAt: json["publishedAt"] == null ? null : json["publishedAt"],
        content: json["content"] == null ? null : json["content"],
      );

  Map<String, dynamic> toJson() => {
        // "source": source == null ? null : source?.toJson(),
        "author": author == null ? null : author,
        "title": title == null ? null : title,
        "description": description == null ? null : description,
        "url": url == null ? null : url,
        "urlToImage": urlToImage == null ? null : urlToImage,
        "publishedAt": publishedAt == null ? null : publishedAt,
        "content": content == null ? null : content,
      };
}

// class Source {
//   Source({
//     required this.id,
//     required this.name,
//   });

//   final String? id;
//   final String? name;

//   Source copyWith({
//     String? id,
//     String? name,
//   }) =>
//       Source(
//         id: id ?? this.id,
//         name: name ?? this.name,
//       );

//   factory Source.fromJson(Map<String, dynamic> json) => Source(
//         id: json["id"] == null ? null : json["id"],
//         name: json["name"] == null ? null : json["name"],
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id == null ? null : id,
//         "name": name == null ? null : name,
//       };
//}
