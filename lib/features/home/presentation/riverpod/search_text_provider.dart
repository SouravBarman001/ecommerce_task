// Provider for search text state
import 'package:flutter_riverpod/flutter_riverpod.dart';

final searchTextProvider = StateProvider<String>((ref) => '');