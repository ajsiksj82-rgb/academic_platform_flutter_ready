import 'package:academic_platform/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('تسجيل الدخول ينقل المستخدم إلى لوحة التحكم', (tester) async {
    await tester.binding.setSurfaceSize(const Size(420, 1400));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(const AcademicPlatformApp());
    expect(find.text('تسجيل الدخول'), findsOneWidget);

    // محاولة دخول بحقول فارغة تُظهر رسالة تنبيه ولا تنقل المستخدم
    await tester.tap(find.text('دخول إلى المنصة'));
    await tester.pump();
    expect(find.text('أدخل اسم المستخدم وكلمة المرور للمتابعة'), findsOneWidget);

    await tester.enterText(find.byType(TextField).at(0), 'سارة');
    await tester.enterText(find.byType(TextField).at(1), '123456');
    await tester.tap(find.text('دخول إلى المنصة'));
    await tester.pumpAndSettle();

    expect(find.textContaining('أهلاً، سارة'), findsOneWidget);
    expect(find.text('المقررات'), findsWidgets);
  });
}
