import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../../../../core/constant/api_constants.dart';
import '../../../../core/exceptions/exceptions.dart';
import '../../../../core/header_provider/header_provider.dart';
import '../../../../core/resources/error_msg_res.dart';
import '../model/food_recipe_search_response.dart';

abstract class FoodRecipeSearchRemote {
  Future<FoodRecipeSearchResponseModel> foodRecipeSearch(
      String query, int offset);
}

class FoodRecipeSearchRemoteImpl implements FoodRecipeSearchRemote {
  static const foodRecipeSearchEndpoint =
      '${ApiConstants.baseApiUrl}${ApiConstants.commonExtUrl}${ApiConstants.searchUrl}';

  final HeaderProvider _headerProvider;

  FoodRecipeSearchRemoteImpl(this._headerProvider);

  @override
  Future<FoodRecipeSearchResponseModel> foodRecipeSearch(
      String query, int offset) async {
    final url =
        Uri.parse('$foodRecipeSearchEndpoint?query=$query&offset=$offset');

    final headers = _headerProvider();

    try {
      final response = await http.get(url, headers: headers);
      return _handleResponse(response);
    } catch (e) {
      throw ServerException(message: ErrorMsgRes.kServerError);
    }
  }

  FoodRecipeSearchResponseModel _handleResponse(http.Response response) {
    final statusCode = response.statusCode;
    final jsonBody = jsonDecode(response.body);
  

    if (statusCode == HttpStatus.ok) {
      return FoodRecipeSearchResponseModel.fromJson(jsonBody);
    }

    final errorMessage = _getErrorMsgForStatusCode(statusCode);
    throw ServerException(message: errorMessage, statusCode: statusCode);
  }

  String _getErrorMsgForStatusCode(int statusCode) {
    return {
          HttpStatus.noContent: ErrorMsgRes.kNoContent,
          HttpStatus.badRequest: ErrorMsgRes.kBadRequest,
          HttpStatus.unauthorized: ErrorMsgRes.kUnauthorized,
          HttpStatus.notFound: ErrorMsgRes.kNotFound,
          HttpStatus.requestTimeout: ErrorMsgRes.kRequestTimeOut,
          HttpStatus.tooManyRequests: ErrorMsgRes.kTooManyRequest,
          HttpStatus.internalServerError: ErrorMsgRes.kServerError,
          HttpStatus.serviceUnavailable: ErrorMsgRes.kServiceUnavailable,
        }[statusCode] ??
        'Unknown error occurred';
  }
}
