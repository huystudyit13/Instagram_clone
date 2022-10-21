import 'package:instagram_clone/screens/login/forgot_password.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:instagram_clone/main.dart';

import 'package:flutter/material.dart';

Future<void> addDelay(int ms) async {
  await Future<void>.delayed(Duration(milliseconds: ms));
}

void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  if (binding is LiveTestWidgetsFlutterBinding) {
    binding.framePolicy = LiveTestWidgetsFlutterBindingFramePolicy.fullyLive;
  }

  group('end-to-end test', () {
    //TODO: add random email var here

    //TODO: add test 1 here
    testWidgets('Authentication Testing', (WidgetTester tester) async {
      //TODO: add Firebase Initialization Here
      await Firebase.initializeApp(); // previous code
      await tester.pumpWidget(const MyApp());
      await tester.pumpAndSettle();
      // await addDelay(1000);
      // await logout(tester);
      await addDelay(10000);
      await tester.tap(find.byKey(const ValueKey('login')));
      //await tester.tap(find.byType(InkWell));
//TODO: Add code here
      tester.printToConsole('Login screen opens');
      await tester.pumpAndSettle();
      // previous code
      await tester.enterText(
          find.byKey(const ValueKey('emailSignUpField')), 'huydo1341@gmail.com');

      await tester.enterText(
          find.byKey(const ValueKey('passwordSignUpField')), 'admin1');
      await tester.ensureVisible(find.byType(ElevatedButton));
      await tester.pumpAndSettle();
      await tester.tap(find.byType(ElevatedButton));
      //await tester.tap(find.byKey(const ValueKey('loginButton')));
      await addDelay(10000);
      await tester.pumpAndSettle();
      expect(find.byKey(const ValueKey('Logout')), findsOneWidget);
      await logout(tester);
    });

    //TODO: add test 2 here
    testWidgets('Sign up Testing', (WidgetTester tester) async {
      //TODO: add Firebase Initialization Here
      await Firebase.initializeApp(); // previous code
      await tester.pumpWidget(const MyApp());
      await addDelay(5000);
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const ValueKey('signupButton')));
      tester.printToConsole('sign up screen opens');
      await tester.pumpAndSettle();
      expect(find.byKey(const ValueKey('sign_up_option')), findsOneWidget);
      await tester.tap(find.byKey(const ValueKey('sign_up_option')));
      await tester.pumpAndSettle();
      expect(find.byKey(const ValueKey('phoneNumber')), findsOneWidget);
      await tester.tap(find.byKey(const ValueKey('secondTab')));
      await tester.pumpAndSettle();
      expect(find.byKey(const ValueKey('emailField')), findsOneWidget);
      await tester.tap(find.byKey(const ValueKey('firstTab')));
      await tester.pumpAndSettle();
      expect(find.byKey(const ValueKey('phoneNumber')), findsOneWidget);
      await tester.tap(find.byKey(const ValueKey('secondTab')));
      await tester.pumpAndSettle();
      expect(find.byKey(const ValueKey('emailField')), findsOneWidget);
      await tester.enterText(
          find.byKey(const ValueKey('emailField')), 'huydo1341');
      await tester.ensureVisible(find.byKey(const ValueKey('nextButton')));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const ValueKey('nextButton')));
      await addDelay(1000);
      //await tester.pumpAndSettle();
      expect(find.byType(SnackBar), findsOneWidget);
      await addDelay(5000);
      await tester.enterText(
          find.byKey(const ValueKey('emailField')), 'huydo1341@gmail.com');
      await tester.ensureVisible(find.byKey(const ValueKey('nextButton')));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const ValueKey('nextButton')));
      await addDelay(2000);
      expect(find.byType(SnackBar), findsOneWidget);
      await tester.enterText(
          find.byKey(const ValueKey('emailField')), '123456@gmail.com');
      await tester.ensureVisible(find.byKey(const ValueKey('nextButton')));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const ValueKey('nextButton')));
      await addDelay(1000);
      await tester.pumpAndSettle();
      expect(find.byType(TextField), findsOneWidget);
      await tester.enterText(
          find.byType(TextField), '111');
      await tester.ensureVisible(find.byType(ElevatedButton));
      await tester.pumpAndSettle();
      await tester.tap(find.byType(ElevatedButton));
      await addDelay(2000);
      expect(find.byType(SnackBar), findsOneWidget);
    });

    testWidgets('Authentication Testing', (WidgetTester tester) async {
      //TODO: add Firebase Initialization Here
      await Firebase.initializeApp(); // previous code
      await tester.pumpWidget(const MyApp());
      await tester.pumpAndSettle();
      await addDelay(5000);
      await tester.tap(find.byKey(const ValueKey('login')));
//TODO: Add code here
      tester.printToConsole('Login screen opens');
      await tester.pumpAndSettle();
      await tester.enterText(find.byKey(const ValueKey('emailSignUpField')),
          'huydo1341@gmail.com');

      await tester.enterText(
          find.byKey(const ValueKey('passwordSignUpField')), 'admin2');
      await tester.ensureVisible(find.byType(ElevatedButton));
      await tester.pumpAndSettle();
      await tester.tap(find.byType(ElevatedButton));
      //await tester.tap(find.byKey(const ValueKey('loginButton')));
      await addDelay(1000);
      expect(find.byType(SnackBar), findsOneWidget);
      await addDelay(5000);
      await tester.enterText(find.byKey(const ValueKey('emailSignUpField')),
          'huydo@gmail.com');
      await tester.ensureVisible(find.byType(ElevatedButton));
      await tester.pumpAndSettle();
      await tester.tap(find.byType(ElevatedButton));
      await addDelay(2000);
      expect(find.byType(SnackBar), findsOneWidget);
    });

    testWidgets('Authentication Testing', (WidgetTester tester) async {
      //TODO: add Firebase Initialization Here
      await Firebase.initializeApp(); // previous code
      await tester.pumpWidget(const ForgotPass());
      await tester.pumpAndSettle();
      await addDelay(5000);
//TODO: Add code here
      tester.printToConsole('forgot screen opens');
      await tester.enterText(find.byType(TextField),
          'huydo@gmail.com');
      await tester.ensureVisible(find.byType(ElevatedButton));
      await tester.pumpAndSettle();
      await tester.tap(find.byType(ElevatedButton));
      //await tester.tap(find.byKey(const ValueKey('loginButton')));
      await addDelay(1000);
      expect(find.byType(SnackBar), findsOneWidget);
      await addDelay(4000);
      await tester.enterText(find.byType(TextField),
          'huydo');
      await tester.ensureVisible(find.byType(ElevatedButton));
      await tester.pumpAndSettle();
      await tester.tap(find.byType(ElevatedButton));
      await addDelay(1000);
      expect(find.byType(SnackBar), findsOneWidget);
      await addDelay(4000);
      await tester.enterText(find.byType(TextField),
          'huydo1341@gmail.com');
      await tester.ensureVisible(find.byType(ElevatedButton));
      await tester.pumpAndSettle();
      await tester.tap(find.byType(ElevatedButton));
      await addDelay(1000);
      expect(find.byType(SnackBar), findsOneWidget);
      await addDelay(4000);
    });
    testWidgets('Change language', (WidgetTester tester) async {
      //TODO: add Firebase Initialization Here
      await Firebase.initializeApp(); // previous code
      await tester.pumpWidget(const MyApp());
      await tester.pumpAndSettle();
      await addDelay(5000);
      await tester.tap(find.byType(DropdownButton<String>));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const ValueKey('secondMenu')));
      await tester.pumpAndSettle();
      await addDelay(5000);
      expect(find.byKey(const ValueKey('signupButton')), findsOneWidget);
      await tester.tap(find.byKey(const ValueKey('firstMenu')));
      await tester.pumpAndSettle();
      await addDelay(5000);
      expect(find.byKey(const ValueKey('signupButton')), findsOneWidget);
    });

  });
}

Future<void> logout(WidgetTester tester) async {
  await addDelay(8000);

  await tester.tap(find.byKey(
    const ValueKey('Logout'),
  ));

  await addDelay(5000);
  tester.printToConsole('Login screen opens');
  await tester.pumpAndSettle();
  expect(find.byKey(const ValueKey('emailSignUpField')), findsOneWidget);
}
