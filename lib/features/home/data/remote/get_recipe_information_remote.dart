import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../../../../core/constant/api_constants.dart';
import '../../../../core/exceptions/exceptions.dart';
import '../../../../core/header_provider/header_provider.dart';
import '../../../../core/resources/error_msg_res.dart';
import '../model/get_recipe_information_response.dart';

abstract class GetRecipeInformationRemote {
  Future<GetRecipeInformationResponseModel> getRecipeDetailInformation(int id);
}

class GetRecipeInformationRemoteImpl implements GetRecipeInformationRemote {
  static const getRecipeInformationEndpoint =
      '${ApiConstants.baseApiUrl}${ApiConstants.commonExtUrl}';

  final HeaderProvider _headerProvider;

  GetRecipeInformationRemoteImpl(this._headerProvider);

  @override
  Future<GetRecipeInformationResponseModel> getRecipeDetailInformation(
      int id) async {
    final url = Uri.parse(
        '$getRecipeInformationEndpoint/$id${ApiConstants.detailsUrl}');

    final headers = _headerProvider();

    try {
      final response = await http.get(url, headers: headers);
      return _handleResponse(response);
    } catch (e) {
      throw ServerException(message: ErrorMsgRes.kServerError);
    }
  }

  GetRecipeInformationResponseModel _handleResponse(http.Response response) {
    final statusCode = response.statusCode;
    final jsonBody = jsonDecode(response.body);

    log(json.encode(jsonBody));

    if (statusCode == HttpStatus.ok) {
      return GetRecipeInformationResponseModel.fromJson(jsonBody);
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
