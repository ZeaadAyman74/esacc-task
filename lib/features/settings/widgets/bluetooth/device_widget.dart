import 'dart:async';

import 'package:esacc_task/core/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DeviceWidget extends StatefulWidget {
  const DeviceWidget({Key? key, required this.device}) : super(key: key);
  final BluetoothDevice device;

  @override
  State<DeviceWidget> createState() => _DeviceWidgetState();
}

class _DeviceWidgetState extends State<DeviceWidget> {
  late StreamSubscription<BluetoothConnectionState>deviceSubscription;
  bool isConnected = false;

  @override
  void initState() {
    super.initState();
    deviceSubscription = widget.device.connectionState
        .listen((BluetoothConnectionState state) async {
      if (state == BluetoothConnectionState.disconnected) {
      print('Disconnected');
      }else if(state == BluetoothConnectionState.connected){
       print('Connected');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.devices),
      title: Text(widget.device.remoteId.str),
      trailing: OutlinedButton(
          onPressed: () {
            if(isConnected){
              widget.device.disconnect();
            }else{
              widget.device.connect();
            }
          },
          style: ButtonStyle(
              padding: MaterialStatePropertyAll(
                  EdgeInsets.symmetric(vertical: 8.w, horizontal: 15.w)),
              enableFeedback: true,
              elevation: const MaterialStatePropertyAll(5),
              backgroundColor:
                  MaterialStatePropertyAll(Colors.grey.withOpacity(.1)),
              shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              )),
              side: const MaterialStatePropertyAll(
                  BorderSide(color: AppColors.lightSecondaryColor))),
          child: Text(isConnected?'Disconnect':'Connect',
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  color: AppColors.lightPrimaryColor, fontSize: 12.sp))),
    );
  }

  @override
  void dispose() {
    super.dispose();
    deviceSubscription.cancel();
  }
}
