

class GetUsername {
  static String _username = '';

  static void simpan(String username) {
    _username = username;
  }

  static String getUsername() {
    return _username;
  }
}
