import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:ttxplorer/ui/controllers/auth_controller.dart';

void main() {
  test('login with email and password', () async {
    // Organizar: Instancia de FirebaseAuth simulada donde el usuario ya ha iniciado sesión
    final auth = MockFirebaseAuth(signedIn: true);
    // Creación del controlador de autenticación con el servicio de autenticación simulado
    final controller = AuthenticationController(auth);

    // Actuar: Intentar iniciar sesión con correo electrónico y contraseña
    await controller.login('test@test.com', 'password');

    // Afirmar: Verificar si el usuario ha iniciado sesión correctamente
    expect(auth.currentUser!.email, equals('test@test.com'));
  });

  test('sign up with email and password', () async {
    // Organizar: Instancia de FirebaseAuth simulada donde el usuario no ha iniciado sesión
    final auth = MockFirebaseAuth(signedIn: false);
    // Creación del controlador de autenticación con el servicio de autenticación simulado
    final controller = AuthenticationController(auth);

    // Actuar: Intentar registrarse con nombre de usuario, correo electrónico y contraseña
    await controller.signup('testuser', 'test@test.com', 'password');

    // Afirmar: Verificar si el usuario se ha registrado correctamente
    expect(auth.currentUser!.email, equals('test@test.com'));
  });

  test('logout', () async {
    // Organizar: Instancia de FirebaseAuth simulada donde el usuario ya ha iniciado sesión
    final auth = MockFirebaseAuth(signedIn: true);
    // Creación del controlador de autenticación con el servicio de autenticación simulado
    final controller = AuthenticationController(auth);

    // Actuar: Intentar cerrar sesión
    await controller.logout();

    // Afirmar: Verificar si el usuario ha cerrado sesión correctamente
    expect(auth.currentUser, isNull);
  });

  test('login with non-existing user', () async {
    // Organizar: Instancia de FirebaseAuth simulada donde el usuario no ha iniciado sesión
    final auth = MockFirebaseAuth(signedIn: false);
    // Creación del controlador de autenticación con el servicio de autenticación simulado
    final controller = AuthenticationController(auth);

    // Actuar y Afirmar: Intentar iniciar sesión con un usuario no existente y esperar una excepción
    expect(
        () async => await controller.login('nonexistent@test.com', 'password'),
        throwsException);
  });

  test('sign up with weak password', () async {
    // Organizar: Instancia de FirebaseAuth simulada donde el usuario no ha iniciado sesión
    final auth = MockFirebaseAuth(signedIn: false);
    // Creación del controlador de autenticación con el servicio de autenticación simulado
    final controller = AuthenticationController(auth);

    // Actuar y Afirmar: Intentar registrarse con una contraseña débil y esperar una excepción
    expect(
        () async =>
            await controller.signup('testuser', 'test@test.com', 'short'),
        throwsException);
  });

  test('change password with wrong current password', () async {
    // Organizar: Instancia de FirebaseAuth simulada donde el usuario ya ha iniciado sesión
    final auth = MockFirebaseAuth(signedIn: true);
    // Creación del controlador de autenticación con el servicio de autenticación simulado
    final controller = AuthenticationController(auth);

    // Actuar y Afirmar: Intentar cambiar la contraseña con una contraseña actual incorrecta y esperar una excepción
    expect(
        () async =>
            await controller.changePassword('newpassword', 'wrongpassword'),
        throwsException);
  });

  test('login with wrong password', () async {
    // Organizar: Instancia de FirebaseAuth simulada donde el usuario ya ha iniciado sesión
    final auth = MockFirebaseAuth(signedIn: true);
    // Creación del controlador de autenticación con el servicio de autenticación simulado
    final controller = AuthenticationController(auth);

    // Actuar y Afirmar: Intentar iniciar sesión con una contraseña incorrecta y esperar una excepción
    expect(() async => await controller.login('test@test.com', 'wrongpassword'),
        throwsException);
  });

  test('sign up with existing email', () async {
    // Organizar: Instancia de FirebaseAuth simulada donde el usuario ya ha iniciado sesión
    final auth = MockFirebaseAuth(signedIn: true);
    // Creación del controlador de autenticación con el servicio de autenticación simulado
    final controller = AuthenticationController(auth);

    // Actuar y Afirmar: Intentar registrarse con un correo electrónico ya en uso y esperar una excepción
    expect(
        () async =>
            await controller.signup('testuser', 'test@test.com', 'password'),
        throwsException);
  });
}
