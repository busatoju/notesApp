import 'package:flutter_test/flutter_test.dart';
import 'package:note_app/shared/validators/validators.dart';

void main() {
  final _validators = Validators();

  test('Deve verificar se o e-mail é valido', () {
    final emailValido = _validators.validateEmail('busatoju@gmail.com');

    expect(emailValido, null);

    final emailInvalido = _validators.validateEmail('gmail.com');

    expect(emailInvalido, 'Informe um e-mail válido');
  });

  test('Deve verificar que se a senha é maior ou igual a 6', () {
    final passwordValido = _validators.validatePassword('admin123');

    expect(passwordValido, null);

    final passwodInvalido = _validators.validatePassword('admin');

    expect(passwodInvalido, 'Senha deve ter ao menos 6 caracteres');
  });

  test('Deve verificar se o nome é válido', () {
    final nameValido = _validators.validateName('Juliana');

    expect(nameValido, null);

    final nameInvalido = _validators.validateName('ju');
    expect(nameInvalido, 'Por favor informe seu nome completo');
  });
}
