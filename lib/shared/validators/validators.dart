class Validators {
  String? validateEmail(String? email) =>
      email!.contains('@') ? null : 'Informe um e-mail válido';

  String? validatePassword(String? password) =>
      password!.length >= 6 ? null : 'Senha deve ter ao menos 6 caracteres';

  String? validateName(String? name) =>
      name!.length >= 3 ? null : 'Por favor informe seu nome completo';

  String? validateTitle(String? title) =>
      title!.isNotEmpty ? null : 'Informe o título';

  String? validateBody(String? body) =>
      body!.isNotEmpty ? null : 'Preencha o campo';
}
