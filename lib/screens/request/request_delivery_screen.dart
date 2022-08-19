import 'package:ark_2/theme/custom_assets.dart';
import 'package:ark_2/widgets/formBuilderTextField.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:provider/provider.dart';

import '../../theme/custom_colors.dart';
import '../../widgets/nav_bar_widget.dart';
import 'request_view_model.dart';

class RequestDeliveryScreen extends StatelessWidget {
  const RequestDeliveryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RequestViewModel(),
      child: MapScreenBody(),
    );
  }
}

class MapScreenBody extends StatelessWidget {
  MapScreenBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget map = SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * .4,
      child: context.watch<RequestViewModel>().position != null
          ? GoogleMap(
              onMapCreated: context.read<RequestViewModel>().onMapCreated,
              initialCameraPosition: CameraPosition(
                target: LatLng(
                    context.watch<RequestViewModel>().position!.latitude,
                    context.watch<RequestViewModel>().position!.longitude),
                zoom: 16.0,
              ),
              myLocationEnabled: true,
              markers: Set<Marker>.of(
                  context.watch<RequestViewModel>().markers.values),
              polylines: context.watch<RequestViewModel>().polyline,
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );

    Widget buildButtonForTrans(AssetImage image, String buttonTitle) {
      return SizedBox(
        width: 80, // Container child widget will get this width value
        height: 55, // Container child widget will get this height value
        child: Material(
          color: context.watch<RequestViewModel>().selected == buttonTitle
              ? CustomColors.mainColor
              : Colors.white,
          elevation: 10,
          borderRadius: BorderRadius.circular(15),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Padding(
            padding: const EdgeInsets.only(top: 5),
            child: InkWell(
              onTap: () {
                context.read<RequestViewModel>().changeSelected(buttonTitle);
              },
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  /*Ink.image(
                    image: image,
                    height: 25,
                    width: 35,
                    fit: BoxFit.cover,
                  ),*/
                  Text(
                    buttonTitle,
                    style:
                        TextStyle(fontSize: 15, color: CustomColors.textColor),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    Widget carTypeButtons = Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        //build in a separated function
        buildButtonForTrans(const AssetImage(CustomAssets.car), "Car"),
        buildButtonForTrans(const AssetImage(CustomAssets.truck), "Truck"),
        buildButtonForTrans(const AssetImage(CustomAssets.trailer), "Trailer"),
      ],
    );

    Widget requestInfo = FormBuilder(
        key: context.read<RequestViewModel>().requestFormKey,
        autovalidateMode: AutovalidateMode.disabled,
        skipDisabled: true,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            TextFieldForm(
                controller: context.watch<RequestViewModel>().fromController,
                name: 'From',
                required: true,
                function: () => context
                    .read<RequestViewModel>()
                    .selectMapPoint(context, "from"),
                textInputAction: TextInputAction.next,
                textInputType: TextInputType.text),
            SizedBox(height: 10),
            TextFieldForm(
                controller: context.watch<RequestViewModel>().toController,
                name: 'To',
                required: true,
                function: () => context
                    .read<RequestViewModel>()
                    .selectMapPoint(context, "To"),
                textInputAction: TextInputAction.next,
                textInputType: TextInputType.text),
            SizedBox(height: 10),
            TextFieldForm(
                controller: null,
                name: 'Offer',
                required: true,
                function: () {},
                textInputAction: TextInputAction.next,
                textInputType: TextInputType.text),
            SizedBox(height: 10),
            TextFieldForm(
                controller: null,
                name: 'Comment and wishes',
                required: false,
                function: () {},
                textInputAction: TextInputAction.next,
                textInputType: TextInputType.text),
            SizedBox(
              height: 10,
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: CustomColors.borderLightGrayColor,
                  width: 1,
                ),
              ),
              child: Column(
                children: <Widget>[
                  MultiSelectBottomSheetField(
                    initialChildSize: 0.4,
                    listType: MultiSelectListType.CHIP,
                    buttonText: Text("My Animals"),
                    title: Text("Animals"),
                    items: context.watch<RequestViewModel>().items,
                    onConfirm: (values) {
                      context
                          .read<RequestViewModel>()
                          .confirmSelectedAnimals(values);
                    },
                    chipDisplay: MultiSelectChipDisplay(
                      onTap: (value) {
                        context
                            .watch<RequestViewModel>()
                            .selectedAnimals
                            .remove(value);
                      },
                    ),
                  ),
                  context.watch<RequestViewModel>().selectedAnimals.length == 0
                      ? Container(
                          padding: EdgeInsets.all(10),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "None selected",
                            style: TextStyle(color: Colors.black54),
                          ))
                      : Container(),
                ],
              ),
            ),
          ],
        ));

    Widget requestButton = ElevatedButton(
      onPressed: () {},
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: const Text(
          'Request',
          style: TextStyle(
              color: Colors.white, fontSize: 22, fontWeight: FontWeight.w700),
        ),
      ),
    );

    return Scaffold(
      drawer: NavBar(),
      appBar: AppBar(
        backgroundColor: CustomColors.mainColor,
        title: const Text('Noah'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            map,
            Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(children: <Widget>[
                  carTypeButtons,
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: requestInfo,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  requestButton,
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
