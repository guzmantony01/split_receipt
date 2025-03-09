import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:split_receipt/providers/item_provider.dart';

class BillPage extends StatefulWidget {
  const BillPage({super.key});

  @override
  State<BillPage> createState() {
    return _BillPageState();
  }
}

class _BillPageState extends State<BillPage> {

  List<TextEditingController> itemNameListController = [TextEditingController()];
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
      itemNameListController[i].text = context.read<ItemProvider>().getItem[i].itemName;
      itemCostController[i].text = context.read<ItemProvider>().getItem[i].itemCost.toString();
      itemHolderController[i].text = context.read<ItemProvider>().getItem[i].itemHolderID.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 15, right: 15, top: 30),
          child: Text("Add Items", style: TextStyle(fontSize: 20),),
        ),
        const SizedBox(
          height: 1,
        ),
        ListView.builder(
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
                        onChanged: (String text) => context.read<ItemProvider>().updateItemName(updatingItemID: index, updatingItemName: text),
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
                          if(double.tryParse(text) == null) {
                            context.read<ItemProvider>().updateItemCost(updatingItemID: index, updatingItemCost: 0.00);
                          } else {
                            context.read<ItemProvider>().updateItemCost(updatingItemID: index, updatingItemCost: double.parse(text));
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
                      child: TextFormField(
                        controller: itemHolderController[index],
                        onChanged: (String text) {
                          if(double.tryParse(text) == null) {
                            context.read<ItemProvider>().updateitemHolderID(updatingItemID: index, updatingitemHolderID: 99);
                          } else {
                            context.read<ItemProvider>().updateitemHolderID(updatingItemID: index, updatingitemHolderID: int.parse(text));
                          }
                        },
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
                  index ==0 ? const SizedBox(width: 35)
                  : const SizedBox(),
                  index !=0 ? GestureDetector(
                    onTap: (){
                      setState(() {
                        itemNameListController[index].clear();
                        itemCostController[index].clear();
                        itemNameListController[index].dispose();
                        itemCostController[index].dispose();
                        itemNameListController.removeAt(index);
                        itemCostController.removeAt(index);
                        context.read<ItemProvider>().removeItem(inputItemID: index);
                      });
                    },
                    child: const Icon(
                      Icons.delete,
                      size: 35,
                    )
                  )
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
          onTap: (){
            setState(() {
              context.read<ItemProvider>().addItem(newItemID: itemNameListController.length, newItemName: "", newItemCost: 0.00, newitemHolderID: 99);
              itemNameListController.add(TextEditingController());
              itemCostController.add(TextEditingController());
              itemHolderController.add(TextEditingController());
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
      ],
    );
  }
}