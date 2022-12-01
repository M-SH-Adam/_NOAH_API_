import 'package:ark_2/app/routes.dart';
import 'package:ark_2/database/GetDataFromDB.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../app/global_variables.dart';
import '../../theme/custom_colors.dart';
import '../../widgets/nav_bar_widget.dart';
import 'myAnimals_viewModel.dart';
import 'package:ark_2/web_services/APIs/Pet_controller.dart';

class MyAnimals extends StatelessWidget {
  const MyAnimals({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MyAnimalsViewModel(),
      child: MyAnimalsBody(),
    );
  }
}

class MyAnimalsBody extends StatelessWidget {
  void initState() {
    pet_controller pet = new pet_controller();
    pet.getPetData();
    print(Global.phone);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBar(),
      appBar: AppBar(
        backgroundColor: CustomColors.mainColor,
        title: const Text('My Pets'),
        centerTitle: true,
      ),
      body: ListView.builder(
          itemCount: context.watch<MyAnimalsViewModel>().animals.length,
          itemBuilder: (context, index) {
            return Container(
              padding: EdgeInsets.only(left: 15, right: 15, top: 20),
              height: 220,
              width: double.maxFinite,
              child: Card(
                elevation: 5,
                child: Stack(
                  children: [
                    Positioned(
                      child: IconButton(
                        icon: Icon(Icons.more_vert),
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (ct) {
                              return Wrap(
                                children: [
                                  GestureDetector(
                                    child: ListTile(
                                      leading: Icon(Icons.edit),
                                      title: Text('Update pet'),
                                    ),
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, Routes.addAnimal,
                                          arguments: {
                                            'data': context
                                                .read<MyAnimalsViewModel>()
                                                .animals[index],
                                            'index': index
                                          });
                                    },
                                  ),
                                  GestureDetector(
                                    child: ListTile(
                                      leading: Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      ),
                                      title: Text(
                                        'Delete pet',
                                        style: TextStyle(color: Colors.red),
                                      ),
                                    ),
                                    onTap: () {
                                      Navigator.pop(context);
                                      context
                                          .read<MyAnimalsViewModel>()
                                          .deleteAnimal(index);
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                      top: 5,
                      right: 5,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, right: 20),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(100.0),
                                child: Image.network(
                                  'https://bit.ly/fcc-relaxing-cat',
                                  height: 100,
                                  width: 100,
                                ),
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              textBaseline: TextBaseline.ideographic,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 20),
                                  child: Text(
                                    context
                                        .read<MyAnimalsViewModel>()
                                        .animals[index]['Name'],
                                    style: TextStyle(
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                ),
                                Text(context
                                    .read<MyAnimalsViewModel>()
                                    .animals[index]['Select type']),
                                Text(context
                                    .read<MyAnimalsViewModel>()
                                    .animals[index]['Color']),
                              ],
                            ),
                            SizedBox(
                              width: 25,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 42),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(context
                                      .read<MyAnimalsViewModel>()
                                      .animals[index]['Select species']),
                                  Text(context
                                      .read<MyAnimalsViewModel>()
                                      .animals[index]['Birth date']
                                      .toString()
                                      .split(" ")
                                      .first),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            RichText(
                              text: TextSpan(
                                children: [
                                  WidgetSpan(
                                    child: Icon(
                                      Icons.line_weight,
                                      size: 18,
                                      color: Colors.blue,
                                    ),
                                  ),
                                  TextSpan(
                                      text:
                                          "${context.read<MyAnimalsViewModel>().animals[index]['Weight']} KG",
                                      style: TextStyle(color: Colors.black)),
                                ],
                              ),
                            ),
                            RichText(
                              text: TextSpan(
                                children: [
                                  WidgetSpan(
                                    child: context
                                                .read<MyAnimalsViewModel>()
                                                .animals[index]['Gender'] ==
                                            'Male'
                                        ? Icon(
                                            Icons.male,
                                            size: 18,
                                            color: Colors.blue,
                                          )
                                        : Icon(
                                            Icons.female,
                                            size: 18,
                                            color: Colors.blue,
                                          ),
                                  ),
                                  TextSpan(
                                      text: context
                                          .read<MyAnimalsViewModel>()
                                          .animals[index]['Gender'],
                                      style: TextStyle(color: Colors.black)),
                                ],
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
          backgroundColor: CustomColors.mainColor,
          onPressed: () {
            // pet_controller pet = new pet_controller();
            // pet.getPetData();
            GetDataFromDB DBData =new GetDataFromDB();
            DBData.getData();
            print(Global.phone);
            Navigator.pushNamed(context, Routes.addAnimal);
          },
          child: Icon(
            Icons.add,
            size: 35,
          )),
    );
  }
}
