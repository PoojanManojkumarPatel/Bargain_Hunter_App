import 'package:flutter/material.dart';
import '../widgets/utils.dart';

class DealView extends StatelessWidget {
  final Map<String, dynamic> deal;

  const DealView({super.key, required this.deal});

  @override
  Widget build(BuildContext context) {
    final title = deal['title'] ?? 'No Title';
    final store = deal['store'] ?? 'Unknown Store';
    final description = deal['description'] ?? 'No description';
    final discountedPrice = deal['discounted_price'];
    final originalPrice = deal['original_price'];
    final imageUrl = deal['image_url'];
    final timeRemaining = getTimeRemaining(deal['end_date']);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Deal Details"),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // image
            Container(
              width: double.infinity,
              height: 300,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(12),
              ),
              child: imageUrl != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        imageUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) =>
                            const Center(child: Icon(Icons.broken_image)),
                      ),
                    )
                  : const Center(child: Text("Image")),
            ),
            const SizedBox(height: 20),

            // Title
            Text(
              title,
              style: const TextStyle(
                fontSize: 30,
                fontFamily: 'Inknut_Antiqua',
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            // Price and Store
            Row(
              children: [
                if (originalPrice != null)
                  Text(
                    '\$$originalPrice',
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.grey,
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                const SizedBox(width: 8),
                if (discountedPrice != null)
                  Text(
                    '\$$discountedPrice',
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              "$store",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 12),

            // Deal ends in
            Text(
              "The deal ends in: $timeRemaining",
              style: TextStyle(
                fontSize: 18,
                color: timeRemaining == "Expired" ? Colors.red : Colors.black,
              ),
            ),

            const SizedBox(height: 100),

            // Description
            const Text(
              "Description:",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
            const SizedBox(height: 6),
            Text(
              description,
              style: const TextStyle(fontSize: 16, fontStyle: FontStyle.italic)
            ),
          ],
        ),
      ),
    );
  }
}
