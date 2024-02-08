import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:world_time/services/world_time.dart';
import 'package:world_time/page/home.dart';

class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  String? time = 'loading';

  void setupWorldTime() async {
    WorldTime instance = WorldTime(location: 'Berlin', flag: 'germany.png', url: 'Europe/Berlin');
    await instance.getTime();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => Home(),
        settings: RouteSettings(
          arguments: {
            'location': instance.location,
            'flag': instance.flag,
            'time': instance.time,
            'isDaytime':instance.isDaytime,
          },
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    setupWorldTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[900],
      appBar: AppBar(
        backgroundColor: Colors.grey[200],
        title: Text('Choose a location', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)), // Example of styling the app bar text
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.all(50.0),
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Center(
            child: SpinKitRotatingCircle(
              color: Colors.blue[900], // Adjust color to match your design
              size: 50.0,
            ),
          ),
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    return Scaffold(
      appBar: AppBar(
        title: Text('Home tthierry', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)), // Example of styling the app bar text
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Location: ${args['location']}', style: TextStyle(fontSize: 24)), // Example of styling the text
            // Text('Flag: ${args['flag']}', style: TextStyle(fontSize: 18)),
            Text('Time: ${args['time']}', style: TextStyle(fontSize: 44)),
          ],
        ),
      ),
    );
  }
}
