import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'deal_card.dart';
import 'filter_provider.dart';

class DealList extends StatelessWidget {
  const DealList({super.key});

  @override
  Widget build(BuildContext context) {
    final filter = context.watch<FilterProvider>();

    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('deals')
          .orderBy('created_at', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text("No deals available."));
        }

        final allDeals = snapshot.data!.docs;
        final filtered = allDeals.where((doc) {
          final data = doc.data() as Map<String, dynamic>;

          final matchesSearch = filter.searchTerm.isEmpty ||
              data['title']
                  .toString()
                  .toLowerCase()
                  .contains(filter.searchTerm.toLowerCase()) ||
              data['store']
                  .toString()
                  .toLowerCase()
                  .contains(filter.searchTerm.toLowerCase());

          final price =
              double.tryParse(data['discounted_price'].toString()) ?? 0;
          bool matchesPrice = true;
          if (filter.priceRange == '< \$10') {
            matchesPrice = price < 10;
          } else if (filter.priceRange == '\$10–\$20') {
            matchesPrice = price >= 10 && price <= 20;
          } else if (filter.priceRange == '> \$20') {
            matchesPrice = price > 20;
          }

          final matchesStore = filter.store.isEmpty ||
              data['store']
                  .toString()
                  .toLowerCase()
                  .contains(filter.store.toLowerCase());

          return matchesSearch && matchesPrice && matchesStore;
        }).toList();

        return ListView.builder(
          itemCount: filtered.length,
          itemBuilder: (context, index) {
            final data = filtered[index].data() as Map<String, dynamic>;
            return DealCard(deal: data);
          },
        );
      },
    );
  }
}
