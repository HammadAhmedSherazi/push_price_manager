import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

import '../../export_all.dart';
import 'api_exceptions.dart';

class MyHttpClient extends BaseApiServices {
  static final MyHttpClient _singleton = MyHttpClient();

  static MyHttpClient get instance => _singleton;
  @override
  Future delete(
    String url,
    body, {
    Map<String, dynamic>? params,
    Map<String, String>? headers,
    bool isToken = true,
    bool isBaseUrl = true,
    bool isJsonEncode = true,
  }) async {
    dynamic responseJson;

    var customUrl = isBaseUrl ? BaseApiServices.baseURL : "";
    var uri =
        customUrl + url + ((params != null) ? queryParameters(params) : "");
    var parsedUrl = Uri.parse(uri);
    if (kDebugMode) {
      print(parsedUrl);
    }

    try {
      final response = await http
          .delete(
            parsedUrl,
            body: isJsonEncode ? jsonEncode(body) : body,
            headers: this.headers(headers, isToken),
          )
          .timeout(const Duration(seconds: 35));

      responseJson = returnResponse(response);
    } on SocketException {
      throw _socketError();
    }
    return responseJson;
  }

  @override
  Future get(
    String url, {
    Map<String, dynamic>? params,
    Map<String, String>? headers,
    bool isToken = true,
    bool isBaseUrl = true,
    bool isCustomUrl = false,
  }) async {
    dynamic responseJson;
    String uri;
    if (isCustomUrl) {
      uri = url + ((params != null) ? queryParameters(params) : "");
    } else {
      var customUrl = isBaseUrl ? BaseApiServices.baseURL : "";
      uri = customUrl + url + ((params != null) ? queryParameters(params) : "");
    }
    var parsedUrl = Uri.parse(uri);
    if (kDebugMode) {
      print(parsedUrl);
    }

    try {
      if (kDebugMode) {
        print(this.headers(headers, isToken)['x-access-token']);
      }
      final response = await http
          .get(parsedUrl, headers: this.headers(headers, isToken))
          .timeout(
            const Duration(seconds: 35),
            // onTimeout: (){
            //   responseJson = null;
            //   return  responseJson;
            // }
          );

      responseJson = returnResponse(response);
    } on SocketException {
      throw _socketError();
    }

    return responseJson;
  }

  @override
  Future post(
    url,
    body, {
    Map<String, dynamic>? params,
    Map<String, String>? headers,
    bool isToken = true,
    bool isBaseUrl = true,
    bool isJsonEncode = true,
    bool isMultipartRequest = false,
    String? variableName,
  }) async {
    dynamic responseJson;
    print(body);

    var customUrl = isBaseUrl ? BaseApiServices.baseURL : "";
    var uri =
        customUrl + url + ((params != null) ? queryParameters(params) : "");
    var parsedUrl = Uri.parse(uri);
    if (kDebugMode) {
      print(parsedUrl);
    }

    try {
      if (isMultipartRequest) {
        final request = http.MultipartRequest('POST', parsedUrl);
        final headersMap = this.headers(headers, isToken);

        // Remove content-type header for multipart requests
        headersMap.remove('Content-Type');
        request.headers.addAll(headersMap);

        // Add files from body (assuming body contains Map with 'files' key)
        if (body['files'] != null) {
          if (body['files'] is File) {
            // Single file case
            final file = body['files'] as File;
            final filePart = await http.MultipartFile.fromPath(
              variableName!, // Use '0' as the key to match the map
              file.path,
              contentType: MediaType(
                'image',
                file.path.split(".").last,
              ), // Adjust as needed
            );
            request.files.add(filePart);
          } else if (body['files'] is List<File>) {
            final List<File> fileList = body['files'];
            for (var file in fileList) {
              final filePart = await http.MultipartFile.fromPath(
                DateTime.now().millisecondsSinceEpoch
                    .toString(), // Use '0' as the key to match the map
                file.path,
                contentType: MediaType(
                  'image',
                  file.path.split(".").last,
                ), // Adjust as needed
              );
              request.files.add(filePart);
            }
            // Multiple files case
            // for (var fileEntry
            //     in (body['files'] as Map<String, List<File>>).entries) {
            //   final List<File> fileList =
            //       fileEntry.value; // Get the list of files
            //   final String fieldName =
            //       fileEntry.key; // The field name for the files

            // }
          } else {
            throw ArgumentError(
              'Invalid type for files. Expected File or Map<String, File>.',
            );
          }
        }

        (body as Map<String, dynamic>).remove("files");
        Map<String, String> sendData = body.map(
          (key, value) {
            if (value is List) {
    return MapEntry(key, "[${value.map((e) => jsonEncode(e)).join(",")}]");
  }
            return MapEntry(key, '$value');
          },
        );
        // log((body).toString());
        request.fields.addAll(sendData);
        // Create the file map

        // Add the form fields
        if (kDebugMode) {
          print(this.headers(headers, isToken)['x-access-token']);
        }
        // Send request and handle response
        final response = await request.send();
        final responseString = await response.stream.bytesToString();
        responseJson = returnResponse(
          http.Response(responseString, response.statusCode),
        );
        
      } else {
        if (body != null && body is Map<String, dynamic>) {
          body.remove("files");
        }

        final response = await http
            .post(
              parsedUrl,
              body: isJsonEncode ? jsonEncode(body) : body,
              headers: this.headers(headers, isToken),
            )
            .timeout(const Duration(seconds: 35));

        responseJson = returnResponse(response);

        if (kDebugMode) {
          print(response);
          print(this.headers(headers, isToken)['x-access-token']);
        }
      }
    } on SocketException {
      throw _socketError();
    }

    return responseJson;
  }

  @override
  Future put(
    String url,
    body, {
    Map<String, dynamic>? params,
    Map<String, String>? headers,
    bool isToken = true,
    bool isBaseUrl = true,
    bool isJsonEncode = true,
    bool isMultipartRequest = false,
    String? variableName,
  }) async {
    dynamic responseJson;

    var customUrl = isBaseUrl ? BaseApiServices.baseURL : "";
    var uri =
        customUrl + url + ((params != null) ? queryParameters(params) : "");
    var parsedUrl = Uri.parse(uri);
    if (kDebugMode) {
      print(parsedUrl);
    }

    try {
      if (isMultipartRequest) {
        final request = http.MultipartRequest('PUT', parsedUrl);
        final headersMap = this.headers(headers, isToken);
        debugPrint(this.headers(headers, isToken)['x-access-token']);
        // Remove content-type header for multipart requests
        headersMap.remove('Content-Type');
        request.headers.addAll(headersMap);

        // Add files from body (assuming body contains Map with 'files' key)
        if (body['files'] != null) {
          if (body['files'] is File) {
            // Single file case
            final file = body['files'] as File;
            final filePart = await http.MultipartFile.fromPath(
              variableName!, // Use '0' as the key to match the map
              file.path,
              contentType: MediaType(
                'image',
                file.path.split(".").last,
              ), // Adjust as needed
            );
            request.files.add(filePart);
          } else if (body['files'] is List<File>) {
            final List<File> fileList = body['files'];
            for (var file in fileList) {
              final filePart = await http.MultipartFile.fromPath(
                DateTime.now().millisecondsSinceEpoch
                    .toString(), // Use '0' as the key to match the map
                file.path,
                contentType: MediaType(
                  'image',
                  file.path.split(".").last,
                ), // Adjust as needed
              );
              request.files.add(filePart);
            }

            // Multiple files case
            // for (var fileEntry
            //     in (body['files'] as Map<String, List<File>>).entries) {
            //   final List<File> fileList =
            //       fileEntry.value; // Get the list of files
            //   final String fieldName =
            //       fileEntry.key; // The field name for the files

            // }
          } else {
            throw ArgumentError(
              'Invalid type for files. Expected File or Map<String, File>.',
            );
          }
        }

        (body as Map<String, dynamic>).remove("files");
        Map<String, String> sendData = body.map(
          (key, value) => MapEntry(key, value),
        );
        // log((body).toString());
        request.fields.addAll(sendData);
        // Create the file map

        // Add the form fields

        // Send request and handle response
        final response = await request.send();
        final responseString = await response.stream.bytesToString();
        responseJson = returnResponse(
          http.Response(responseString, response.statusCode),
        );
      } else {
        if (body != null) {
          (body as Map<String, dynamic>).remove("files");
        }
        final response = await http
            .put(
              parsedUrl,
              body: isJsonEncode ? jsonEncode(body) : body,
              headers: this.headers(headers, isToken),
            )
            .timeout(const Duration(seconds: 35));

        responseJson = returnResponse(response);

        debugPrint(this.headers(headers, isToken)['x-access-token']);
      }
    } on SocketException {
      throw _socketError();
    }

    return responseJson;
  }

  @override
  Future patch(
    String url,
    body, {
    Map<String, dynamic>? params,
    Map<String, String>? headers,
    bool isToken = true,
    bool isBaseUrl = true,
    bool isJsonEncode = true,
  }) async {
    dynamic responseJson;

    var customUrl = isBaseUrl ? BaseApiServices.baseURL : "";
    var uri =
        customUrl + url + ((params != null) ? queryParameters(params) : "");
    var parsedUrl = Uri.parse(uri);
    if (kDebugMode) {
      print(parsedUrl);
    }

    try {
      final response = await http
          .patch(
            parsedUrl,
            body: isJsonEncode ? jsonEncode(body) : body,
            headers: this.headers(headers, isToken),
          )
          .timeout(const Duration(seconds: 35));

      responseJson = returnResponse(response);
    } on SocketException {
      throw _socketError();
    }
    return responseJson;
  }

  // Customs headers would append here or return the default values
  Map<String, String> headers(Map<String, String>? headers, bool isToken) {
    var header = {
      HttpHeaders.contentTypeHeader: 'application/json ',
      HttpHeaders.acceptHeader: 'application/json',
    };

    if (isToken) {
      if (SharedPreferenceManager.sharedInstance.hasToken()) {
        header.putIfAbsent(
          "Authorization",
          () => "Bearer ${SharedPreferenceManager.sharedInstance.getToken()}",
        );
      }
    }

    if (headers != null) {
      header.addAll(headers);
    }
    return header;
  }

  // Query Parameters
  // String queryParameters(Map<String, dynamic>? params) {
  //   if (params != null) {
  //     final jsonString = Uri(
  //       queryParameters: params.map(
  //         (key, value) => MapEntry(key, value.toString()),
  //       ),
  //     );
  //     return '?${jsonString.query}';
  //   }
  //   return '';
  // }
  String queryParameters(Map<String, dynamic> params) {
  final query = <String>[];

  params.forEach((key, value) {
    if (value == null) return;

    if (value is List) {
      // Repeated keys for list values
      for (var v in value) {
        query.add('${Uri.encodeQueryComponent(key)}=${Uri.encodeQueryComponent(v.toString())}');
      }
    } else {
      // Normal single key=value
      query.add('${Uri.encodeQueryComponent(key)}=${Uri.encodeQueryComponent(value.toString())}');
    }
  });

  return query.isEmpty ? '' : '?${query.join('&')}';
}

  dynamic returnResponse(http.Response response) {
    if (kDebugMode) {
      print("📥 Response [${response.statusCode}]: ${response.body}");
    }

    switch (response.statusCode) {
      case 200:
      case 201:
      case 203:
      case 204:
      case 404:
      //  if (json.decode(response.body.toString())['details'] ==
      //       "User Not Found") {
      //     SharedPreferenceManager.sharedInstance.clearAll();

      //     AppRouter.pushAndRemoveUntil(const LoginView());
      //     Helper.showMessage( AppRouter.navKey.currentContext!,message: "Please login again!");
      //   }
        var utf8Format = utf8.decode(response.bodyBytes);
        var responseJson = jsonDecode(utf8Format);
        return responseJson;
      case 400:
        Helper.showMessage( AppRouter.navKey.currentContext!,message: 
          json.decode(response.body.toString())['detail']??
              AppRouter.navKey.currentContext!.tr("something_went_wrong_try_again"),
        );
        throw BadRequestException(
          response.statusCode,
          response.body.toString(),
        );
      case 401:
        String msg =
            json.decode(response.body.toString())['detail'] ??
            AppRouter.navKey.currentContext!.tr("something_went_wrong_try_again");
        
        Helper.showMessage( AppRouter.navKey.currentContext!,message: msg);
        
        if(msg == "Invalid token"){
         if (SharedPreferenceManager.sharedInstance.getRefreshToken() != null &&
            SharedPreferenceManager.sharedInstance.getRefreshToken() != "") {
          // AuthRemoteRepo.authRemoteInstance.updateToken(input: {
          //   "refreshToken":
          //       SharedPreferenceManager.sharedInstance.getRefreshToken()!
          // }, query: GraphQLQueries.refreshTokenQuery);
          // SharedPreferenceManager.sharedInstance.clearRefreshToken();
          // SharedPreferenceManager.sharedInstance.clearToken();
          SharedPreferenceManager.sharedInstance.clearAll();

          AppRouter.pushAndRemoveUntil(const LoginView());
          Helper.showMessage( AppRouter.navKey.currentContext!,message: AppRouter.navKey.currentContext!.tr("please_login_again"));
        }
        else {
          SharedPreferenceManager.sharedInstance.clearAll();

          AppRouter.pushAndRemoveUntil(const LoginView());
          Helper.showMessage( AppRouter.navKey.currentContext!,message: AppRouter.navKey.currentContext!.tr("please_login_again"));
        } 
        }
        
        throw BadRequestException(
          response.statusCode,
          response.body.toString(),
        );
      case 403:
        Helper.showMessage(
           AppRouter.navKey.currentContext!,message: 
          json.decode(response.body.toString())['detail'] ??
              AppRouter.navKey.currentContext!.tr("something_went_wrong_try_again"),
        );
        throw UnauthorisedException(
          response.statusCode,
          response.body.toString(),
        );
      
      case 408:
        Helper.showMessage(
           AppRouter.navKey.currentContext!,message: 
          json.decode(response.body.toString())['detail'] ??
              AppRouter.navKey.currentContext!.tr("something_went_wrong_try_again"),
        );
        if (json.decode(response.body.toString())['detail'] ==
            "User Not Found") {
          SharedPreferenceManager.sharedInstance.clearAll();

          AppRouter.pushAndRemoveUntil(const LoginView());
          Helper.showMessage( AppRouter.navKey.currentContext!,message: AppRouter.navKey.currentContext!.tr("please_login_again"));
        }
        throw RequestTimeOutException(
          response.statusCode,
          response.body.toString(),
        );
      case 422:
        Helper.showMessage(
           AppRouter.navKey.currentContext!,message: 
          json.decode(response.body.toString())['detail'] ??
              AppRouter.navKey.currentContext!.tr("something_went_wrong_try_again"),
        );
        throw UnprocessableContent(
          response.statusCode,
          response.body.toString(),
        );
      case 423:
        Helper.showMessage( AppRouter.navKey.currentContext!,message: 
          json.decode(response.body.toString())['detail'] ??
              AppRouter.navKey.currentContext!.tr("something_went_wrong_try_again"),
        );
        throw UnauthorisedException(
          response.statusCode,
          response.body.toString(),
        );
      case 409:
      case 500:
        Helper.showMessage(
          AppRouter.navKey.currentContext!,message: 
          json.decode( response.body.toString())['detail'] ??
              AppRouter.navKey.currentContext!.tr("something_went_wrong_try_again"),
        );
        throw ServerException(response.statusCode, "Server Error");
      default:
        Helper.showMessage( AppRouter.navKey.currentContext!,message: AppRouter.navKey.currentContext!.tr("something_went_wrong_try_again"));
        throw FetchDataException(response.statusCode, response.body.toString());
    }
  }

  SocketConnectionError _socketError() {
    Helper.showMessage( AppRouter.navKey.currentContext!,message: AppRouter.navKey.currentContext!.tr("no_internet_connection"));
    return SocketConnectionError(
      800,
      json.encode({"message": "No Internet Connection"}),
    );
  }
}