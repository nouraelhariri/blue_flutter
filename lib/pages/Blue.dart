import 'package:flutter_blue/flutter_blue.dart';
import 'package:flutter/material.dart';


class UP extends StatefulWidget {
UP({Key key, this.title}) : super(key: key);
 final FlutterBlue flutterBlue = FlutterBlue.instance;
 final String title;
 final List<BluetoothDevice> devicesList = new List<BluetoothDevice>();
 @override
 _MyHomePageState createState() => _MyHomePageState();
}
 
class _MyHomePageState extends State<UP> {
  
  
 
 @override
 Widget build(BuildContext context) => Scaffold(
       appBar: AppBar(
         title: Text(widget.title),
       ),
       body:   _buildListViewOfDevices(),
     );

_addDeviceTolist(final BluetoothDevice device) {
   if (!widget.devicesList.contains(device)) {
     setState(() {
       widget.devicesList.add(device);
     });
   }
 }
 @override
 void initState() {
   super.initState();
   widget.flutterBlue.connectedDevices
       .asStream()
       .listen((List<BluetoothDevice> devices) {
     for (BluetoothDevice device in devices) {
       _addDeviceTolist(device);
     }
   });
   widget.flutterBlue.scanResults.listen((List<ScanResult> results) {
     for (ScanResult result in results) {
       _addDeviceTolist(result.device);
     }
   });
   widget.flutterBlue.startScan();
 }
ListView _buildListViewOfDevices() {
   List<Container> containers = new List<Container>();
   for (BluetoothDevice device in widget.devicesList) {
     containers.add(
       Container(
         height: 50,
         child: Row(
           children: <Widget>[
             Expanded(
               child: Column(
                 children: <Widget>[
                   Text(device.name == '' ? '(unknown device)' : device.name),
                   Text(device.id.toString()),
                 ],
               ),
             ),
             FlatButton(
               color: Colors.blue,
               child: Text(
                 'Connect',
                 style: TextStyle(color: Colors.white),
               ),
               onPressed: () {},
             ),
           ],
         ),
       ),
     );
   }
 
   return ListView(
     padding: const EdgeInsets.all(8),
     children: <Widget>[
       ...containers,
     ],
   );
 }
 
}
