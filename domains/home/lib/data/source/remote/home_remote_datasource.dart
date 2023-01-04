import 'package:common/utils/constants/app_constants.dart';
import 'package:dependencies/dio/dio.dart';
import 'package:home/data/models/request/home_request_dto.dart';
import 'package:home/data/models/response/home_response_dto.dart';

abstract class HomeRemoteDataSource {
  const HomeRemoteDataSource();

  Future<HomeResponseDto> getAllNews({required HomeRequestDto homeRequestDto});

  Future<HomeResponseDto> getNewsByCategory({required HomeRequestDto homeRequestDto});
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final Dio dio;

  HomeRemoteDataSourceImpl({required this.dio});

  @override
  Future<HomeResponseDto> getAllNews({required HomeRequestDto homeRequestDto}) async {
    try {
      final response = await dio.get(
        "${AppConstants.appApi.homeAll}${AppConstants.apiKey.myApiKey}",
        queryParameters: homeRequestDto.toJson(),
      );
      return HomeResponseDto.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<HomeResponseDto> getNewsByCategory({required HomeRequestDto homeRequestDto}) async {
    try {
      final response = await dio.get(
        "${AppConstants.appApi.homeByCategory}${AppConstants.apiKey.myApiKey}",
        queryParameters: homeRequestDto.toJson(),
      );
      return HomeResponseDto.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }
}
