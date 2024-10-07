

class GetEmail {
  static String _email = '';

  static void simpan(String email) {
    _email = email;
  }

  static String getEmail() {
    return _email;
  }
}
