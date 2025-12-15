import 'package:flutter/material.dart';
import '../widgets/filters.dart';
import '../widgets/deal_list.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: const [
          SizedBox(height: 16),
          Text(
            'Bargain Hunter',
            style: TextStyle(
              fontSize: 32,
              fontFamily: 'Exile',
            ),
          ),
          SizedBox(height: 16),
          FilterSection(),
          Expanded(child: DealList()),
        ],
      ),
    );
  }
}
