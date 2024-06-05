import 'package:flutter/material.dart';
import 'package:machine_task_e_commerce/domain/model/model.dart';
import 'package:machine_task_e_commerce/presentation/widgets/custom_price_widget.dart';

class ItemBuilder extends StatelessWidget {
  const ItemBuilder({
    super.key,
    required this.futureItemsList,
    required this.filteredItems,
    required this.height,
    required this.width,
  });

  final Future<ItemsList> futureItemsList;
  final List<Items> filteredItems;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ItemsList>(
      future: futureItemsList,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        } else {
          List<Items> items = filteredItems.isNotEmpty
              ? filteredItems
              : snapshot.data!.itemsList;
          return ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              final GlobalKey<_CounterState> counterKey =
                  GlobalKey<_CounterState>();
              return Padding(
                padding: const EdgeInsets.all(2.0),
                child: Container(
                  height: height * 0.1,
                  width: double.infinity,
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        width: width * 0.6,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              item.description,
                              style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomPriceWidget(
                                    title: 'MRP', value: 'Rs.${item.mrp}'),
                                CustomPriceWidget(
                                    title: 'Rate', value: 'Rs.${item.rate}'),
                                CustomPriceWidget(
                                    title: 'Amount',
                                    value: 'Rs.${item.amount}'),
                              ],
                            )
                          ],
                        ),
                      ),
                      Container(
                        height: height * 0.08,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.yellow.shade600),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                                onPressed: () {
                                  counterKey.currentState?.sub();
                                },
                                icon: const Icon(Icons.remove)),
                            Counter(
                              key: counterKey,
                            ),
                            IconButton(
                                onPressed: () {
                                  counterKey.currentState?.add();
                                },
                                icon: const Icon(Icons.add))
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }
}

class Counter extends StatefulWidget {
  const Counter({super.key});

  @override
  State<Counter> createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  int counterValue = 0;

  void add() {
    setState(() {
      counterValue = counterValue + 1;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Item added to cart'),
          behavior: SnackBarBehavior.floating,
        ),
      );
    });
  }

  void sub() {
    if (counterValue > 0) {
      counterValue = counterValue - 1;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Item removed from cart'),
          behavior: SnackBarBehavior.floating,
        ),
      );
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Text(counterValue.toString());
  }
}
