import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:esacc_task/core/utils/app_functions.dart';
import 'package:esacc_task/core/utils/enums.dart';
import 'package:esacc_task/features/settings/widgets/wifi/wifi_device_widget.dart';
import 'package:esacc_task/features/settings/widgets/wifi/wifi_devices_dropdown.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_nearby_connections/flutter_nearby_connections.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WifiPart extends StatefulWidget {
  const WifiPart({Key? key}) : super(key: key);

  @override
  State<WifiPart> createState() => _WifiPartState();
}

class _WifiPartState extends State<WifiPart> {
  List<Device> devices = [];
  List<Device> connectedDevices = [];
  late NearbyService nearbyService;
  late StreamSubscription subscription;
  late StreamSubscription receivedDataSubscription;

  bool isInit = false;

  @override
  void initState() {
    super.initState();
    init();
  }

  @override
  void dispose() {
    subscription.cancel();
    receivedDataSubscription.cancel();
    nearbyService.stopBrowsingForPeers();
    nearbyService.stopAdvertisingPeer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const Icon(Icons.wifi),
            SizedBox(
              width: 5.w,
            ),
            const Text('Wifi'),
          ],
        ),
        SizedBox(
          height: 10.h,
        ),
        WifiDevicesDropdown(items: _getAvailableDevices())
      ],
    );
  }


  List<DropdownMenuItem<String>> _getAvailableDevices() {
    return devices
        .map((e) =>
        DropdownMenuItem<String>(
          value: e.deviceId,
          child: WifiDeviceWidget(
            device: e,
            onConnectPress:() {
              _onButtonClicked(e);
            },
          ),
        ))
        .toList();
  }

  _onButtonClicked(Device device) {
    switch (device.state) {
      case SessionState.notConnected:
        nearbyService.invitePeer(
          deviceID: device.deviceId,
          deviceName: device.deviceName,
        );
        break;
      case SessionState.connected:
        nearbyService.disconnectPeer(deviceID: device.deviceId);
        break;
      case SessionState.connecting:
        break;
    }
  }

  // _onTabItemListener(Device device) {
  //   if (device.state == SessionState.connected) {
  //     showDialog(
  //         context: context,
  //         builder: (BuildContext context) {
  //           final myController = TextEditingController();
  //           return AlertDialog(
  //             title: const Text("Send message"),
  //             content: TextField(controller: myController),
  //             actions: [
  //               TextButton(
  //                 child: const Text("Cancel"),
  //                 onPressed: () {
  //                   Navigator.of(context).pop();
  //                 },
  //               ),
  //               TextButton(
  //                 child: const Text("Send"),
  //                 onPressed: () {
  //                   nearbyService.sendMessage(
  //                       device.deviceId, myController.text);
  //                   myController.text = '';
  //                 },
  //               )
  //             ],
  //           );
  //         });
  //   }
  // }

  void init() async {
    nearbyService = NearbyService();
    String devInfo = '';
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      devInfo = androidInfo.model;
    }
    if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      devInfo = iosInfo.localizedModel;
    }
    await nearbyService.init(
        serviceType: 'mpconn',
        deviceName: devInfo,
        strategy: Strategy.P2P_CLUSTER,
        callback: (isRunning) async {
          if (isRunning) {
            // if (widget.deviceType == DeviceType.browser) {
            //
            //   await nearbyService.stopBrowsingForPeers();
            //   await Future.delayed(const Duration(microseconds: 200));
            //   await nearbyService.startBrowsingForPeers();
            // } else {
            //   await nearbyService.stopAdvertisingPeer();
            //   await nearbyService.stopBrowsingForPeers();
            //   await Future.delayed(const Duration(microseconds: 200));
            //   await nearbyService.startAdvertisingPeer();
            //   await nearbyService.startBrowsingForPeers();
            // }
            await nearbyService.stopBrowsingForPeers();
            await Future.delayed(const Duration(microseconds: 200));
            await nearbyService.startBrowsingForPeers();
          }
        });
    subscription =
        nearbyService.stateChangedSubscription(callback: (devicesList) {
          for (var element in devicesList) {
            if (kDebugMode) {
              print(" deviceId: ${element.deviceId} | deviceName: ${element
                  .deviceName} | state: ${element.state}");
            }
            if (Platform.isAndroid) {
              if (element.state == SessionState.connected) {
                nearbyService.stopBrowsingForPeers();
              } else {
                nearbyService.startBrowsingForPeers();
              }
            }
          }

          setState(() {
            devices.clear();
            devices.addAll(devicesList);
            connectedDevices.clear();
            connectedDevices.addAll(devicesList
                .where((d) => d.state == SessionState.connected)
                .toList());
          });
        });

    receivedDataSubscription =
        nearbyService.dataReceivedSubscription(callback: (data) {
          if (kDebugMode) {
            print("dataReceivedSubscription: ${jsonEncode(data)}");
          }
          AppFunctions.showToast(
            message: jsonEncode(data), state: ToastStates.error,);
        });
  }
}
