import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'filter_provider.dart';

class FilterSection extends StatelessWidget {
  const FilterSection({super.key});

  @override
  Widget build(BuildContext context) {
    final filter = context.watch<FilterProvider>();

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: TextField(
            controller: filter.searchController,
            onChanged: filter.updateSearchTerm,
            decoration: InputDecoration(
              hintText: 'Search',
              prefixIcon: const Icon(Icons.search),
              suffixIcon: IconButton(
                icon: Icon(
                  filter.showFilters ? Icons.filter_list_off : Icons.filter_list,
                ),
                onPressed: filter.toggleFilters,
              ),
              filled: true,
              fillColor: Colors.grey[300],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: BorderSide.none,
              ),
            ),
          ),

        ),
        if (filter.showFilters) const SizedBox(height: 10),
        if (filter.showFilters)
          AnimatedCrossFade(
            firstChild: const SizedBox.shrink(),
            secondChild: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  DropdownButtonFormField<String>(
                    value: filter.priceRange.isEmpty ? null : filter.priceRange,
                    hint: const Text("Price Range"),
                    items: const ['< \$10', '\$10–\$20', '> \$20']
                        .map((val) => DropdownMenuItem(value: val, child: Text(val)))
                        .toList(),
                    onChanged: (val) => filter.setPriceRange(val ?? ''),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: filter.storeController,
                    onChanged: filter.setStore,
                    decoration: const InputDecoration(
                      labelText: "Store",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton.icon(
                      onPressed: filter.clear,
                      icon: const Icon(Icons.clear),
                      label: const Text("Clear All Filters"),
                    ),
                  ),
                ],
              ),
            ),
            crossFadeState: filter.showFilters
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 300),
          ),
        const Divider(),
      ],
    );
  }
}
