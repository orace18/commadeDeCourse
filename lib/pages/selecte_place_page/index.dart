import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otrip/pages/selecte_place_page/controllers/search_place_controller.dart';

class NeighborhoodsPage extends GetView<NeighborhoodsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quartiers du Monde'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: controller.searchController,
              decoration: InputDecoration(
                hintText: 'Rechercher un quartier',
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (value) {
                controller.searchNeighborhoods(value);
              },
            ),
          ),
          Expanded(
            child: Obx(
              () => ListView.builder(
                itemCount: controller.neighborhoods.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(controller.neighborhoods[index]),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

