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

  List<TextEditingController> listController = [TextEditingController()];

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < listController.length; i++) {
      listController[i].text = providerName.getProfile[i].name;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<NameProvider>(builder: (context, providerName, child) {
      return Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 15, right: 15, top: 30),
            child: Text("Add Names", style: TextStyle(fontSize: 20),),
          ),
          const SizedBox(
            height: 1,
          ),
          ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            shrinkWrap: true,
            itemCount: listController.length,
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
                          controller: listController[index],
                          onChanged: (String text) => providerName.changeName(newNameID: index, newName: text),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    index !=0 ? GestureDetector(
                      onTap: (){
                        setState(() {
                          listController[index].clear();
                          listController[index].dispose();
                          listController.removeAt(index);
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
                listController.add(TextEditingController());
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
    });
  }
}

// class _NamePageState extends State<NamePage> {

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: ListView(
//         children: const [
//           NameHandler(nameID: 0),
//           NameHandler(nameID: 1),
//           NameHandler(nameID: 2),
//           NameHandler(nameID: 3),
//           NameHandler(nameID: 4),
//           NameHandler(nameID: 5),
//           NameHandler(nameID: 6),
//           NameHandler(nameID: 7),
//           NameHandler(nameID: 8),
//           NameHandler(nameID: 9),
//         ],
//       ),
//     );
//   }
// }