import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:split_receipt/providers/name_provider.dart';
import 'package:split_receipt/providers/item_provider.dart';


class BreakDownPage extends StatefulWidget {
  const BreakDownPage({super.key});

  @override
  State<BreakDownPage> createState() {
    return _BreakDownPageState();
  }
}

class _BreakDownPageState extends State<BreakDownPage> {

  int nameBoxHeight = 35;
  int itemBoxHeight = 20;
  int totalCostBoxHeight = 20;
  int lineThickness = 1;

  double totalBoxCalculate(int numItemBox) {
    return (nameBoxHeight + (itemBoxHeight * numItemBox) + totalCostBoxHeight + lineThickness).toDouble();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 15, right: 15, top: 30),
            child: Text("Breakdown Cost", style: TextStyle(fontSize: 20),),
          ),
          const SizedBox(
            height: 1,
          ),
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 15),
            shrinkWrap: true,
            itemCount: context.read<NameProvider>().getProfile.length,
            itemBuilder: (context, indexName) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  height: totalBoxCalculate(
                    context.read<ItemProvider>().countInventory(
                      inputProfileName: context.read<NameProvider>().getProfile[indexName].name
                    ),
                  ),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.blue[200],
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 35,
                        child: Text(
                          context.read<NameProvider>().getProfile[indexName].name,
                          style: const TextStyle(
                            fontSize: 25,
                          ),
                        ),
                      ),
                      ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.symmetric(horizontal: 1),
                        shrinkWrap: true,
                        itemCount: context.read<ItemProvider>().countInventory(
                          inputProfileName: context.read<NameProvider>().getProfile[indexName].name),
                        itemBuilder: (context, indexItem) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 1),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  height: 20,
                                  child: Text(
                                    context.read<ItemProvider>().populateItemName(
                                      inputProfileName: context.read<NameProvider>().getProfile[indexName].name,
                                      index: indexItem),
                                    style: const TextStyle(
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                  child: Text(
                                    context.read<ItemProvider>().populateItemCost(
                                      inputProfileName: context.read<NameProvider>().getProfile[indexName].name,
                                      index: indexItem).toStringAsFixed(2),
                                    style: const TextStyle(
                                      fontSize: 15,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                      ),
                      const Divider(height: 1, thickness: 1, indent: 5, endIndent: 5, color: Colors.black),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 1),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Total Cost:'),
                            Text(context.read<ItemProvider>().calculateProfileTotalCost(
                                inputProfileName: context.read<NameProvider>().getProfile[indexName].name,
                              ).toStringAsFixed(2)),
                          ],
                        ),
                      ),
                    ]
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}