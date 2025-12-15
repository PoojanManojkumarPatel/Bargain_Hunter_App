import 'package:flutter_test/flutter_test.dart';
import 'package:bargain_hunter/widgets/filter_provider.dart';

void main() {
  group('FilterProvider Unit Tests', () {
    late FilterProvider filterProvider;

    setUp(() {
      filterProvider = FilterProvider();
    });

    test('Initial state is correct', () {
      expect(filterProvider.searchTerm, '');
      expect(filterProvider.priceRange, '');
      expect(filterProvider.store, '');
      expect(filterProvider.showFilters, false);
    });

    test('Search term updates correctly', () {
      filterProvider.updateSearchTerm('milk');
      expect(filterProvider.searchTerm, 'milk');
    });

    test('Toggling filter visibility works', () {
      expect(filterProvider.showFilters, false);
      filterProvider.toggleFilters();
      expect(filterProvider.showFilters, true);
    });
  });
}