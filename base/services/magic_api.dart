import 'package:dio/dio.dart';

class MagicApi {
  static const BASE_URL = 'https://api.magicthegathering.io/v1';

  Dio dio;

  MagicApi() {
    BaseOptions options = new BaseOptions(
      baseUrl: BASE_URL,
    );

    dio = new Dio(options);
  }

  Future<Response> searchCardByName(String name){
    return _get(urn: '/cards', query: {'name': name});
  }

  Future<Response> findCard(String id){
    return _get(urn: '/cards/$id');
  }

  Future<Response> _get({
    String urn,
    Map<String, dynamic> query,
    String baseUrn,
  }) {
    return _request(
      'get',
      urn: urn,
      query: query,
      baseUrn: baseUrn,
    );
  }

  Future<Response> _post(
      Map<String, dynamic> data, {
        String urn,
        Map<String, dynamic> query,
        String baseUrn,
        bool formData = false,
      }) {
    return _request(
      'post',
      data: data,
      urn: urn,
      query: query,
      baseUrn: baseUrn,
      isFormData: formData,
    );
  }

  Future<Response> _put(
      Map<String, dynamic> data, {
        String urn,
        Map<String, dynamic> query,
        String baseUrn,
        bool formData = false,
      }) {
    return _request(
      'put',
      data: data,
      urn: urn,
      query: query,
      baseUrn: baseUrn,
      isFormData: formData,
    );
  }

  Future<Response> _delete({
    String urn,
    Map<String, dynamic> query,
    String baseUrn,
  }) {
    return _request(
      'delete',
      urn: urn,
      query: query,
      baseUrn: baseUrn,
    );
  }

  Future<Response> _request(
      String method, {
        Map<String, dynamic> data,
        dynamic urn,
        Map<String, dynamic> query,
        String baseUrn,
        bool isFormData = false,
      }) async {
    print("Request to $urn");

    FormData formData;

    Options options = Options(method: method);

    if (isFormData) {
      formData = FormData.fromMap(data);
      options = options.merge(contentType: Headers.formUrlEncodedContentType);
    }

    Response response = await dio.request(
      urn,
      data: formData ?? data ?? {},
      queryParameters: query ?? {},
      options: options,
    );

    print("Response ${response.data}");

    return response;
  }
}
