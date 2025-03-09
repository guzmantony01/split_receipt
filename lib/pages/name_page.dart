import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:split_receipt/providers/name_provider.dart';

class NamePage extends StatefulWidget {
  const NamePage({super.key});

  @override
  State<NamePage> createState() {
    return _NamePageState();
  }
}


class _NamePageState extends State<NamePage> {

  List<TextEditingController> nameListController = [TextEditingController()];

  @override
  void initState() {
    super.initState();
    int profileLength = context.read<NameProvider>().getProfile.length;
    for (int i = 0; i < profileLength; i++) {
      if (i != 0) {
        nameListController.add(TextEditingController());
      }
      nameListController[i].text = context.read<NameProvider>().getProfile[i].name;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 15, right: 15, top: 30),
            child: Text("Add Names", style: TextStyle(fontSize: 20),),
          ),
          const SizedBox(
            height: 1,
          ),
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 15),
            shrinkWrap: true,
            itemCount: nameListController.length,
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
                          controller: nameListController[index],
                          onChanged: (String text) => context.read<NameProvider>().updateProfile(updatingNameID: index, newName: text),
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
                          nameListController[index].clear();
                          nameListController[index].dispose();
                          nameListController.removeAt(index);
                          context.read<NameProvider>().removeProfile(inputNameID: index);
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
                context.read<NameProvider>().addProfile(newNameID: nameListController.length, newName: "");
                nameListController.add(TextEditingController());
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
      ),
    );
  }
}