import 'package:flutter/material.dart';
import '../pages/deal_view.dart';
import '../widgets/utils.dart';

class DealCard extends StatelessWidget {
  final Map<String, dynamic> deal;

  const DealCard({super.key, required this.deal});
  

  @override
  Widget build(BuildContext context) {
    final timeRemaining = getTimeRemaining(deal['end_date']);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.all(12),
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => DealView(deal: deal),
              ),
            );
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                deal['title'] ?? 'Product',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text("Store: ${deal['store'] ?? 'N/A'}"),
              Text("Price: \$${deal['discounted_price'] ?? '?'}"),
              const SizedBox(height: 6),
              Text(
                timeRemaining,
                style: TextStyle(
                  fontSize: 12,
                  color: timeRemaining == "Expired" ? Colors.red : Colors.black,),
              )
            ],
          ),
        ),
      ),
    );
  }
}
