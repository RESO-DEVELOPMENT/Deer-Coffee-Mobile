import 'package:deer_coffee/views/profile_screen/profile.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';

class Location extends StatefulWidget {
  const Location({Key? key}) : super(key: key);

  @override
  State<Location> createState() => _LocationState();
}

class _LocationState extends State<Location> {
  final List<String> savedAddresses = [
    'S202, Vinhome Grand Park TP Thủ Đức',
    'S203, Vinhome Grand Park TP Thủ Đức',
    'S302, Vinhome Grand Park TP Thủ Đức',
  ];

  int selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Địa chỉ đã lưu'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: savedAddresses.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedIndex = index;
              });
            },
            child: AnimatedOpacity(
              opacity: selectedIndex == index ? 1.0 : 0.5,
              duration: Duration(milliseconds: 500),
              child: Card(
                margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                child: ListTile(
                  leading: Icon(
                    Icons.location_on,
                    color: selectedIndex == index ? Colors.lightBlue : null,
                  ),
                  title: Text(savedAddresses[index]),
                  trailing: selectedIndex == index
                      ? FadeDownEditButton(
                          onPressed: () {
                            editAddress(index);
                          },
                          isSelected: true,
                        )
                      : SizedBox.shrink(),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void editAddress(int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            EditAddressScreen(initialValue: savedAddresses[index]),
      ),
    ).then((editedValue) {
      if (editedValue != null) {
        setState(() {
          savedAddresses[index] = editedValue;
        });
      }
    });
  }
}

class EditAddressScreen extends StatefulWidget {
  final String initialValue;

  const EditAddressScreen({Key? key, required this.initialValue})
      : super(key: key);

  @override
  State<EditAddressScreen> createState() => _EditAddressScreenState();
}

class _EditAddressScreenState extends State<EditAddressScreen> {
  late TextEditingController _textEditingController;
  late GoogleMapController mapController;
  late LatLng currentLocation;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController(text: widget.initialValue);
    currentLocation = LatLng(0.0, 0.0); // Tọa độ mặc định (0, 0)
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chỉnh sửa địa chỉ'),
      ),
      body: Column(
        children: [
          Expanded(
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                target: currentLocation,
                zoom: 15.0,
              ),
              onMapCreated: (GoogleMapController controller) {
                mapController = controller;
              },
              markers: {
                Marker(
                  markerId: MarkerId('currentLocation'),
                  position: currentLocation,
                ),
              },
              onTap: (LatLng latLng) {
                updateMarker(latLng);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextField(
                  controller: _textEditingController,
                  decoration: InputDecoration(
                    labelText: 'Địa chỉ',
                  ),
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    saveChanges();
                  },
                  child: Text('Lưu chỉnh sửa'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void updateMarker(LatLng latLng) {
    setState(() {
      currentLocation = latLng;
      mapController.animateCamera(CameraUpdate.newLatLng(latLng));
    });

    getAddressFromLatLng(latLng);
  }

  Future<void> getAddressFromLatLng(LatLng latLng) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        latLng.latitude,
        latLng.longitude,
      );

      if (placemarks.isNotEmpty) {
        Placemark placemark = placemarks.first;
        setState(() {
          _textEditingController.text = placemark.street ?? '';
        });
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  void saveChanges() {
    print('Đã lưu địa chỉ: ${_textEditingController.text}');
    print('Vị trí tọa độ: $currentLocation');

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => OtherPage(),
      ),
    );
  }
}

class FadeDownEditButton extends StatelessWidget {
  final VoidCallback onPressed;
  final bool isSelected;

  const FadeDownEditButton(
      {Key? key, required this.onPressed, required this.isSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: Duration(milliseconds: 500),
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0.0, 50.0 * (1.0 - value)),
          child: Opacity(
            opacity: value,
            child: child,
          ),
        );
      },
      child: IconButton(
        icon: Icon(
          Icons.edit,
          color: Colors.grey,
        ),
        onPressed: onPressed,
      ),
    );
  }
}

