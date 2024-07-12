import 'package:booky/app.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('MyApp', () {
    testWidgets('renders MyApp', (tester) async {
      await tester.pumpWidget(
        MyApp(),
      );
      expect(find.byType(MyApp), findsOneWidget);
    });
  });
}
