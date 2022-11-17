import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:google_fonts/google_fonts.dart';

class mapScreen extends StatefulWidget {
  final double lat;
  final double long;
  final String address;
  const mapScreen(
      {Key? key, required this.lat, required this.long, required this.address})
      : super(key: key);

  @override
  State<mapScreen> createState() => _mapScreenState();
}

class _mapScreenState extends State<mapScreen> {
  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
        center: LatLng(widget.lat, widget.long),
        zoom: 15,
      ),
      nonRotatedChildren: [
        AttributionWidget.defaultWidget(
          source: 'OpenStreetMap contributors',
          onSourceTapped: null,
        ),
      ],
      children: [
        TileLayer(
            urlTemplate:
                "https://api.mapbox.com/styles/v1/hoang1812/cl8a620nf000c15tbuv1k34cj/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoiaG9hbmcxODEyIiwiYSI6ImNsOGE1cnpvdDBlMmwzd2wwbDVtaDd6OHYifQ.Gl9NeJ0c_bOsv6mfugdfCQ",
            additionalOptions: {
              'accessToken':
                  'pk.eyJ1IjoiaG9hbmcxODEyIiwiYSI6ImNsOGE1cnpvdDBlMmwzd2wwbDVtaDd6OHYifQ.Gl9NeJ0c_bOsv6mfugdfCQ',
              'id': 'mapbox.satellite'
            }),
        MarkerLayer(
          markers: [
            Marker(
              point: LatLng(widget.lat, widget.long),
              width: 90,
              height: 90,
              builder: (context) => Container(
                width: 100,
                child: Column(
                  children: [
                    Text('${widget.address}',
                        style: GoogleFonts.inter(
                          textStyle:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                        )),
                    SizedBox(height: 5,),
                    Icon(Icons.location_on_rounded, color: Colors.red,),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
