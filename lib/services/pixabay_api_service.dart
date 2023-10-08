import 'dart:convert';
import 'package:flutter_pixabay_api_search_app/models/pixabay_data_model.dart';
import 'package:http/http.dart' as http;

class PixabayApiService {
  final String _apiKey = '19895183-11fcdb8a3468162339de8bd48';
  final String _apiDomain = 'pixabay.com';
  final String _apiPath = '/api/';

  /// [requestPictures] is the main method for sending requests for pictures
  /// only to the pixabay RESTful interface api, it does this using basic http/s
  /// request with query parameters
  Future<PixabayResultsModel> requestPictures({
    String? query,
    String imageType = 'photo',
    int resultLimit = 50,
  }) async {
    // TODO - Part 1 - Implement pixabay api to fetch data

    return PixabayResultsModel();
  }
}
