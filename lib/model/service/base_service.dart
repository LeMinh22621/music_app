abstract class BaseService {
  final String mediaBaseUrl = 'https://api.spotify.com';

  Future<dynamic> getResponse(String url);
}
