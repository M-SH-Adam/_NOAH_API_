import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import '../../theme/custom_colors.dart';
import 'map_view_model.dart';
import 'package:provider/provider.dart';

class SelectMapPointScreen extends StatelessWidget {
  const SelectMapPointScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MapViewModel(),
      child: const SelectMapPointScreenBody(),
    );
  }
}

class SelectMapPointScreenBody extends StatelessWidget {
  const SelectMapPointScreenBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return context.watch<MapViewModel>().position == null
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : SafeArea(
            child: Scaffold(
              appBar: AppBar(
                  backgroundColor: CustomColors.mainColor,
                  title: Text("select"),
                  bottom: PreferredSize(
                    preferredSize: const Size.fromHeight(50),
                    child: _buildLocationDisplay(
                      location: context.watch<MapViewModel>().locationAddress,
                      onTap: () => context
                          .read<MapViewModel>()
                          .handlePressButton(context),
                    ),
                  )),
              body: Stack(
                children: [
                  GoogleMap(
                    onMapCreated: context.read<MapViewModel>().onMapCreated,
                    initialCameraPosition: CameraPosition(
                      target: LatLng(
                          context.watch<MapViewModel>().position!.latitude,
                          context.watch<MapViewModel>().position!.longitude),
                      zoom: 18.0,
                    ),
                    onTap: context.read<MapViewModel>().setMarker,
                    myLocationButtonEnabled: true,
                    gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
                      Factory<OneSequenceGestureRecognizer>(
                        () => EagerGestureRecognizer(),
                      ),
                    },
                    myLocationEnabled: true,
                    mapToolbarEnabled: true,
                    buildingsEnabled: true,
                    markers: Set<Marker>.of(
                        context.watch<MapViewModel>().markers.values),
                  ),
                  context.watch<MapViewModel>().locationLatLng != null
                      ? Positioned(
                          bottom: 20,
                          right: 0,
                          left: 0,
                          child: InkWell(
                            onTap: (){
                              var data = {
                                "latLng": context.read<MapViewModel>().locationLatLng,
                                "address": context.read<MapViewModel>().locationAddress
                              };
                              Navigator.pop(context,data);
                            },
                            child: Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal:
                                        MediaQuery.of(context).size.width * .2),
                                padding: const EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(5)),
                                child: const Center(
                                  child: Text(
                                    "Done",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold),
                                  ),
                                )),
                          ))
                      : Container(),
                ],
              ),
            ),
          );
  }

  _buildLocationDisplay({required String? location, required Function onTap}) {
    return InkWell(
      onTap: () => onTap(),
      child: Container(
          margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
          width: double.infinity,
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.black12,
          ),
          child: Text(
            location ?? "",
            style: const TextStyle(fontSize: 15),
            maxLines: 1,
          )),
    );
  }
}
