abstract class BaseApiServices {
  // //DEV URL
  static String baseURL = "https://pushpricenow.xyz/";
  Future<dynamic> get(
    String url, {
    Map<String, dynamic>? params,
    Map<String, String>? headers,
    bool isToken = true,
    bool isBaseUrl = true,
  });

  Future<dynamic> post(
    String url,
    dynamic body, {
    Map<String, dynamic>? params,
    Map<String, String>? headers,
    bool isToken = true,
    bool isBaseUrl = true,
    bool isJsonEncode = true,
    bool isMultipartRequest = false,
    String? variableName
  });

  Future<dynamic> put(
    String url,
    dynamic body, {
    Map<String, dynamic>? params,
    Map<String, String>? headers,
    bool isToken = true,
    bool isBaseUrl = true,
    bool isJsonEncode = true,
    bool isMultipartRequest = false,
    String? variableName,
  });

  Future<dynamic> patch(
    String url,
    dynamic body, {
    Map<String, dynamic>? params,
    Map<String, String>? headers,
    bool isToken = true,
    bool isBaseUrl = true,
    bool isJsonEncode = true,
  });

  Future<dynamic> delete(
    String url,
    dynamic body, {
    Map<String, dynamic>? params,
    Map<String, String>? headers,
    bool isToken = true,
    bool isBaseUrl = true,
    bool isJsonEncode = true,
  });
}