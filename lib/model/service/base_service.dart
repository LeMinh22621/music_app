abstract class BaseService {
  final String mediaBaseUrl = 'https://firebasestorage.googleapis.com/v0/';

  Future<dynamic> getResponse(String url);
}
