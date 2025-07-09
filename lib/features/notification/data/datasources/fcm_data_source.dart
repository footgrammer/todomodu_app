abstract interface class FcmDataSource {
  Future<String?> getToken();
  void listenTokenRefresh(String userId);
}