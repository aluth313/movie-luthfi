import 'package:ditonton/common/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  test('text theme test', () {
    final kTextThemeTest = TextTheme(
      headline5: kHeading5,
      headline6: kHeading6,
      subtitle1: kSubtitle,
    );

    expect(kTextTheme, kTextThemeTest);
  });
}
