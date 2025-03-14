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

  int countProfileList() {
    int runningCount = 0;
    int itemLength = context.read<ItemProvider>().getItem.length;
    int profileLength = context.read<NameProvider>().getProfile.length;
    if (profileLength == 1) {
      if(context.read<NameProvider>().getProfile[0].name != "") {
        runningCount += 1;
      }
      if(context.read<ItemProvider>().getItem[0].itemName != "") {
        runningCount += 1;
      }
    } else {
      runningCount = profileLength;
      for(int i = 0; i < itemLength; i++) {
        if((context.read<ItemProvider>().getItem[i].itemName != "") && (context.read<ItemProvider>().getItem[i].profileHolder == "")) {
          runningCount += 1;
          return runningCount;
        }
      }
    }
    return runningCount;
  }

  String putProfileName(int indexName) {
    if (indexName >= context.read<NameProvider>().getProfile.length) {
      return "Unassigned Balanced";
    } else {
      return (context.read<NameProvider>().getProfile[indexName].name);
    }
  }

  int countItemList(int indexName) {
    int runningCount = 0;
    int itemLength = context.read<ItemProvider>().getItem.length;
    int profileLength = context.read<NameProvider>().getProfile.length;
    for(int i = 0; i < itemLength; i++) {
      if (indexName >= profileLength) {
        if (context.read<ItemProvider>().getItem[i].profileHolder == "") {
          runningCount++;
        }
      } else {
        if (context.read<ItemProvider>().getItem[i].profileHolder == context.read<NameProvider>().getProfile[indexName].name) {
          runningCount++;
        }
      }
    }
    return runningCount;
  }

  String putItemName(int indexName, int indexItem) {
    if (indexName >= context.read<NameProvider>().getProfile.length) {
      return context.read<ItemProvider>().populateItemName(inputProfileName: "", index: indexItem);
    } else {
      return context.read<ItemProvider>().populateItemName(inputProfileName: context.read<NameProvider>().getProfile[indexName].name,index: indexItem);
    }
  }

  String putItemCost(int indexName, int indexItem) {
    if (indexName >= context.read<NameProvider>().getProfile.length) {
      return context.read<ItemProvider>().populateItemCost(inputProfileName: "",index: indexItem).toStringAsFixed(2);
    } else {
      return context.read<ItemProvider>().populateItemCost(inputProfileName: context.read<NameProvider>().getProfile[indexName].name,index: indexItem).toStringAsFixed(2);
    }
  }

  String putTotalCost(int indexName) {
    if (indexName >= context.read<NameProvider>().getProfile.length) {
      return context.read<ItemProvider>().calculateProfileTotalCost(inputProfileName: "").toStringAsFixed(2);
    } else {
      return context.read<ItemProvider>().calculateProfileTotalCost(inputProfileName: context.read<NameProvider>().getProfile[indexName].name).toStringAsFixed(2);
    }
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
          // ListView Builder for the ProfileList
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 15),
            shrinkWrap: true,
            itemCount: countProfileList(),
            itemBuilder: (context, indexName) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  height: totalBoxCalculate(countItemList(indexName)),
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
                          putProfileName(indexName),
                          style: const TextStyle(
                            fontSize: 25,
                          ),
                        ),
                      ),
                      // ListView Builder for the Item/Cost
                      ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.symmetric(horizontal: 1),
                        shrinkWrap: true,
                        itemCount: countItemList(indexName),
                        itemBuilder: (context, indexItem) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 1),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  height: 20,
                                  child: Text(
                                    putItemName(indexName, indexItem),
                                    style: const TextStyle(
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                  child: Text(
                                    putItemCost(indexName, indexItem),
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
                            Text(putTotalCost(indexName)),
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