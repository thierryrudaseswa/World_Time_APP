import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map<String, dynamic> data = {}; // Specify the type of the map
  String bgImage = 'day.png'; // Declare and initialize bgImage with a default value

  @override
  Widget build(BuildContext context) {
    // Check if ModalRoute.of(context).settings.arguments is not null
    final arguments = ModalRoute.of(context)?.settings.arguments;
    if (arguments != null && arguments is Map<String, dynamic>) {
      data =data.isNotEmpty ? data : arguments;

      bgImage = data['isDaytime'] ? 'day.png' : 'night.png';
      print(data);
    }

    return Scaffold(
      body: Container(
        width: double.infinity, // Fill the width of the screen
        height: double.infinity, // Fill the height of the screen
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/$bgImage'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              " Home Screen ",
              style: TextStyle(color: Colors.grey,fontSize: 2
              ),
            ),
            Text(
              'Location: ${data['location']}',
              style: TextStyle(fontSize: 45,color: Colors.white),
            ),
            // Text('Flag: ${data['flag']}', style: TextStyle(fontSize: 18)),
            Text(
              'Time: ${data['time']}',
              style: TextStyle(fontSize: 44,color: Colors.white),
            ),
            ElevatedButton.icon(
              onPressed: () async{
             dynamic  result  = await Navigator.pushNamed(context, '/location');
             setState(() {
               data = {
                 'time' : result['time'],
               'location' : result['location'],
               'isDaytime' : result['isDaytime'],
               'flag' : result['flag']
               };
             });
              },
              icon: Icon(Icons.edit_location),
              label: Text("Edit location you want  in the world"),
            ),
          ],
        ),
      ),
    );
  }
}
