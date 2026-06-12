import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:beamtv/main.dart';

void main() {
  testWidgets('BeamTV app renders without error', (WidgetTester tester) async {
    await tester.pumpWidget(const BeamTVApp());
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}