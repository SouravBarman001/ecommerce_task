import 'package:flutter_riverpod/flutter_riverpod.dart';

// Holds the current value of the search text
final searchTextProvider = StateProvider<String>((ref) => '');
