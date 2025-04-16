class Validator {
  Validator._();

  static String? validateName(String? value) {
    final condition = RegExp(r"\b([A-ZÀ-ÿ][-,a-z. ']+[ ]*)+");
    if(value != null && value.isEmpty) {
      return "Esse campo não pode ser vazio.";
    }
    if (value != null && !condition.hasMatch(value)) {
      return "Nome inválido. Digite um nome válido.";
    }
    return null;
  }

  static String? validateEmail(String? value) {
    final condition = RegExp(r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?");
    if(value != null && value.isEmpty) {
      return "Esse campo não pode ser vazio.";
    }
    if (value != null && !condition.hasMatch(value)) {
      return "E-mail inválido. Digite um e-mail válido.";
    }
    return null;
  }

  static String? validateConfirmEmail(String? first, String? second) {
    if (first != second) {
      return "Os e-mail`s são diferentes";
    }
    return null;
  }

  static String? validatePassword(String? value) {
    final condition = RegExp(r"^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[a-zA-Z]).{8,}$");
    if(value != null && value.isEmpty) {
      return "Esse campo não pode ser vazio.";
    }
    if (value != null && !condition.hasMatch(value)) {
      return "Senha inválida. Digite uma senha válida.";
    }
    return null;
  }

  static String? validateConfirmPassword(String? first, String? second) {
    if (first != second) {
      return "As senhas são diferentes.";
    }
    return null;
  }

  static String? validateBirthday(String? value) {
    if(value != null && value.isEmpty) {
      return "Esse campo não pode ser vazio.";
    }
    return null;
  }
}