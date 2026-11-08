import 'package:flutter_test/flutter_test.dart';
import 'package:mochat/main.dart';

void main() {
  testWidgets('MoChat opens', (WidgetTester tester) async {
    await tester.pumpWidget(const MoChatApp());
    expect(find.text('MoChat'), findsOneWidget);
  });
}
