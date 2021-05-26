class ServerException implements Exception {}

class CacheException implements Exception {}

class CredentialException implements Exception {
  final String message;
  CredentialException(this.message);
}
