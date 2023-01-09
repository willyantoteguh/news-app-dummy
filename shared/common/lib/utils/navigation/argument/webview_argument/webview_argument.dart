import 'package:dependencies/equatable/equatable.dart';

class WebviewArgument extends Equatable {
  final String title;
  final String url;
  final String urlToImage;
  final String publishedAt;

  const WebviewArgument({
    required this.title,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
  });

  @override
  List<Object?> get props => [title, url, urlToImage, publishedAt];
}
