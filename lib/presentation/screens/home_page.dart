import 'package:flutter/material.dart';
import 'package:machine_task_e_commerce/domain/model/model.dart';
import 'package:machine_task_e_commerce/infrastructure/api_services.dart';
import 'package:machine_task_e_commerce/presentation/widgets/itembuilder.dart';
import 'package:machine_task_e_commerce/presentation/widgets/save_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController controller = TextEditingController();
  late Future<ItemsList> futureItemsList;
  List<Items> filteredItems = [];

  @override
  void initState() {
    super.initState();
    futureItemsList = ApiServices().fetchData();
  }

  void filterItems(String searchText) async {
    final itemsList = await futureItemsList;
    List<Items> filteredList = [];
    for (Items item in itemsList.itemsList) {
      if (item.description.toLowerCase().contains(searchText.toLowerCase())) {
        filteredList.add(item);
      }
    }
    setState(() {
      filteredItems = filteredList;
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.95),
      appBar: AppBar(
          backgroundColor: Colors.teal,
          iconTheme: const IconThemeData(color: Colors.white),
          leading:
              IconButton(icon: const Icon(Icons.arrow_back), onPressed: () {}),
          actions: [
            IconButton(
                icon: const Icon(
                  Icons.qr_code_scanner_outlined,
                  color: Colors.white,
                ),
                onPressed: () {}),
            IconButton(
                icon: const Icon(
                  Icons.close,
                  color: Colors.white,
                ),
                onPressed: () {})
          ],
          title: const Text(
            'K G Gupta',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          )),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              autofocus: false,
              controller: controller,
              onChanged: (value) {
                filterItems(value);
              },
              style: const TextStyle(color: Colors.black),
              decoration: InputDecoration(
                enabledBorder:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none),
                contentPadding: const EdgeInsets.symmetric(vertical: 18),
                hintText: "Search products..",
                hintStyle: const TextStyle(color: Colors.black),
                prefixIcon: const Icon(Icons.search, color: Colors.black),
              ),
            ),
          ),
          Expanded(
            child: ItemBuilder(
                futureItemsList: futureItemsList,
                filteredItems: filteredItems,
                height: height,
                width: width),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 50, left: 16, right: 16),
            child: SaveButton(height: height),
          ),
        ],
      ),
    );
  }
}
