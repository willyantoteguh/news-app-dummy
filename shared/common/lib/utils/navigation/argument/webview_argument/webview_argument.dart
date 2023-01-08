import 'package:dependencies/equatable/equatable.dart';

class WebviewArgument extends Equatable {
  final String title;
  final String url;
 

  const WebviewArgument({
    required this.title,
    required this.url,

  });

  @override
  List<Object?> get props => [
     title,
     url
      ];
}
