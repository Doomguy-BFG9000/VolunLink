import '../../../data/models/ngo_model.dart';

/// Builds the text shown in the platform share sheet for an NGO.
String buildNgoShareMessage(NGOModel ngo) {
  final name = ngo.organizationName.trim();
  final description = ngo.description?.trim();
  final website = ngo.website?.trim();

  final message = <String>[
    'Check out ${name.isEmpty ? 'this NGO' : name} on VolunLink!',
  ];

  if (description != null && description.isNotEmpty) {
    message.add(description);
  }

  if (website != null && website.isNotEmpty) {
    message.add(_normalizeWebsite(website));
  }

  return message.join('\n');
}

String _normalizeWebsite(String website) {
  final uri = Uri.tryParse(website);
  if (uri != null && uri.hasScheme) {
    return website;
  }
  return 'https://$website';
}
