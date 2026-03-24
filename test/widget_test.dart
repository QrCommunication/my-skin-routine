import 'package:flutter_test/flutter_test.dart';
import 'package:my_skin_routine/app.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  testWidgets('App starts without crashing', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(child: MySkinRoutineApp()),
    );
    expect(find.byType(MySkinRoutineApp), findsOneWidget);
  });
}
