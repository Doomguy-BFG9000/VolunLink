import 'package:flutter_test/flutter_test.dart';
import 'package:volun_link/data/models/ngo_model.dart';
import 'package:volun_link/features/user/utils/ngo_share_message.dart';

void main() {
  group('buildNgoShareMessage', () {
    test('includes the NGO name, description, and normalized website', () {
      final ngo = _ngo(
        organizationName: 'Green Earth',
        description: 'Protecting local forests.',
        website: 'greenearth.org',
      );

      expect(
        buildNgoShareMessage(ngo),
        'Check out Green Earth on VolunLink!\n'
        'Protecting local forests.\n'
        'https://greenearth.org',
      );
    });

    test('omits empty optional details without leaving blank lines', () {
      final ngo = _ngo(description: '  ', website: '');

      expect(buildNgoShareMessage(ngo), 'Check out Test NGO on VolunLink!');
    });

    test('uses a safe fallback when the NGO name is empty', () {
      final ngo = _ngo(organizationName: '  ');

      expect(buildNgoShareMessage(ngo), 'Check out this NGO on VolunLink!');
    });

    test('keeps an existing website scheme', () {
      final ngo = _ngo(website: 'https://example.org/help');

      expect(buildNgoShareMessage(ngo), endsWith('https://example.org/help'));
    });
  });
}

NGOModel _ngo({
  String organizationName = 'Test NGO',
  String? description,
  String? website,
}) {
  return NGOModel(
    id: 'ngo-1',
    email: 'hello@example.org',
    organizationName: organizationName,
    description: description,
    category: 'Environment',
    website: website,
    createdAt: DateTime(2026),
  );
}
