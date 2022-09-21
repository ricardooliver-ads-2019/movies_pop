class LoginCredential {
  var _login = Login('');

  void setLogin(String login) => _login = Login(login);
  Login get login => _login;

  var _password = Password('');
  void setPassword(String password) => _password = Password(password);
  Password get password => _password;

  String? validate() {
    String? validate = _login.validate();
    if (validate != null) {
      return validate;
    }

    validate = _password.validate();
    if (validate != null) {
      return validate;
    }
    return null;
  }
}

class Login {
  final String value;

  Login(this.value);

  String? validate() {
    if (value.isEmpty) {
      return 'Campo login não pode ser vazio';
    }
    return null;
  }
}

class Password {
  final String value;

  Password(this.value);

  String? validate() {
    if (value.isEmpty) {
      return 'Campo senha não pode ser vazio';
    }
    return null;
  }
}
