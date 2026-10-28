import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:share_plus_platform_interface/share_plus_platform_interface.dart';
import 'package:volun_link/data/models/ngo_model.dart';
import 'package:volun_link/data/providers/ngo_provider.dart';
import 'package:volun_link/features/user/screens/discover/ngo_detail_screen.dart';

void main() {
  testWidgets('NGO detail screen exposes the share action', (tester) async {
    final sharePlatform = _TestSharePlatform();
    SharePlatform.instance = sharePlatform;

    final ngo = NGOModel(
      id: 'ngo-1',
      email: 'hello@example.org',
      organizationName: 'Green Earth',
      description: 'Protecting local forests.',
      category: 'Environment',
      website: 'greenearth.org',
      createdAt: DateTime(2026),
    );

    await tester.pumpWidget(
      MaterialApp(
        home: ChangeNotifierProvider<NGOProvider>(
          create: (_) => _TestNGOProvider(),
          child: NGODetailScreen(ngo: ngo),
        ),
      ),
    );

    expect(find.byIcon(Icons.share), findsOneWidget);
    expect(find.text('Green Earth'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.share));
    await tester.pump();

    expect(
      sharePlatform.params?.text,
      'Check out Green Earth on VolunLink!\n'
      'Protecting local forests.\n'
      'https://greenearth.org',
    );
    expect(sharePlatform.params?.sharePositionOrigin, isNotNull);
  });
}

class _TestNGOProvider extends NGOProvider {
  @override
  bool isFavorite(String ngoId) => false;

  @override
  Future<void> toggleFavorite(String ngoId) async {}
}

class _TestSharePlatform extends SharePlatform {
  ShareParams? params;

  @override
  Future<ShareResult> share(ShareParams params) async {
    this.params = params;
    return ShareResult.unavailable;
  }
}
