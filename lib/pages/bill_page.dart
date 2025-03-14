import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:split_receipt/providers/item_provider.dart';
import 'package:split_receipt/providers/name_provider.dart';

class BillPage extends StatefulWidget {
  const BillPage({super.key});

  @override
  State<BillPage> createState() {
    return _BillPageState();
  }
}

class _BillPageState extends State<BillPage> {
  List<TextEditingController> itemNameListController = [
    TextEditingController()
  ];
  List<TextEditingController> itemCostController = [TextEditingController()];
  List<TextEditingController> itemHolderController = [TextEditingController()];

  @override
  void initState() {
    super.initState();
    int itemLength = context.read<ItemProvider>().getItem.length;
    for (int i = 0; i < itemLength; i++) {
      if (i != 0) {
        itemNameListController.add(TextEditingController());
        itemCostController.add(TextEditingController());
        itemHolderController.add(TextEditingController());
      }
      itemNameListController[i].text =
          context.read<ItemProvider>().getItem[i].itemName;
      itemCostController[i].text =
          context.read<ItemProvider>().getItem[i].itemCost.toStringAsFixed(2);
      itemHolderController[i].text =
          context.read<ItemProvider>().getItem[i].profileHolder;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 15, right: 15, top: 30),
            child: Text(
              "Add Items",
              style: TextStyle(fontSize: 20),
            ),
          ),
          const Divider(height: 1, thickness: 1, indent: 50, endIndent: 50, color: Colors.black),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    height: 25,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: const Column(
                      children: [
                        Text("Name"),
                        Divider(height: 1, thickness: 1, indent: 20, endIndent: 20, color: Colors.black),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    height: 25,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: const Column(
                      children: [
                        Text("Cost"),
                        Divider(height: 1, thickness: 1, indent: 20, endIndent: 20, color: Colors.black),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    height: 25,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: const Column(
                      children: [
                        Text("Person"),
                        Divider(height: 1, thickness: 1, indent: 20, endIndent: 20, color: Colors.black),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                  child: VerticalDivider(
                    thickness: 2,
                    width: 20,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(width: 50),
              ],
            ),
          ),
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 15),
            shrinkWrap: true,
            itemCount: itemNameListController.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        height: 60,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.blue[200],
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: TextFormField(
                          controller: itemNameListController[index],
                          onChanged: (String text) => context
                              .read<ItemProvider>()
                              .updateItemName(
                                  updatingItemID: index, updatingItemName: text),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        height: 60,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.blue[200],
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: TextFormField(
                          controller: itemCostController[index],
                          onChanged: (String text) {
                            if (double.tryParse(text) == null) {
                              context.read<ItemProvider>().updateItemCost(
                                  updatingItemID: index, updatingItemCost: 0.00);
                            } else {
                              context.read<ItemProvider>().updateItemCost(
                                  updatingItemID: index,
                                  updatingItemCost: double.parse(text));
                            }
                          },
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        height: 60,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.blue[200],
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: DropdownButton<String>(
                          value: itemHolderController[index].text.isEmpty ||
                                  !context
                                      .read<NameProvider>()
                                      .getDropDownMenuEntries()
                                      .contains(itemHolderController[index].text)
                              ? null // Set to null if the value doesn't exist in the list
                              : itemHolderController[index].text,
                          icon: const Icon(Icons.arrow_downward),
                          elevation: 16,
                          style: const TextStyle(color: Colors.deepPurple),
                          underline: Container(
                              height: 2, color: Colors.deepPurpleAccent),
                          onChanged: (String? value) {
                            setState(() {
                              itemHolderController[index].text = value.toString();
                              context.read<ItemProvider>().updateItemHolder(
                                  updatingItemID: index,
                                  updatingProfileHolder: value.toString());
                            });
                          },
                          items: context
                              .read<NameProvider>()
                              .getDropDownMenuEntries()
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                                value: value, child: Text(value));
                          }).toList(),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                      child: VerticalDivider(
                        thickness: 2,
                        width: 20,
                        color: Colors.black,
                      ),
                    ),
                    index == 0 ? const SizedBox(width: 35) : const SizedBox(),
                    index != 0
                        ? GestureDetector(
                            onTap: () {
                              setState(() {
                                itemNameListController[index].clear();
                                itemCostController[index].clear();
                                itemHolderController[index].clear();

                                itemNameListController[index].dispose();
                                itemCostController[index].dispose();
                                itemHolderController[index].dispose();
                                
                                itemNameListController.removeAt(index);
                                itemCostController.removeAt(index);
                                itemHolderController.removeAt(index);
                                context
                                    .read<ItemProvider>()
                                    .removeItem(inputItemID: index);
                              });
                            },
                            child: const Icon(
                              Icons.delete,
                              size: 35,
                            ))
                        : const SizedBox(),
                  ],
                ),
              );
            },
          ),
          const SizedBox(
            height: 1,
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                context.read<ItemProvider>().addItem(
                    newItemID: itemNameListController.length,
                    newItemName: "",
                    newItemCost: 0.00,
                    newProfileHolder: "");
                itemNameListController.add(TextEditingController());
                itemCostController.add(TextEditingController());
                itemHolderController.add(TextEditingController());
                itemCostController[itemCostController.length - 1].text = "0.00";
              });
            },
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 15,
                ),
                decoration: BoxDecoration(
                  color: Colors.red[300],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  "Add more",
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const Divider(height: 1, thickness: 1, indent: 5, endIndent: 5, color: Colors.black),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Taxes:'),
                    Text('Taxes TextFormField goes here.'),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Tip:'),
                    Text('Tips TextFormField goes here.'),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Total Cost:'),
                    Text(context.read<ItemProvider>().calculateTotalCost().toStringAsFixed(2)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
