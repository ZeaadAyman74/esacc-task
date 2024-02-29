import 'dart:async';
import 'dart:io';

import 'package:esacc_task/core/utils/app_functions.dart';
import 'package:esacc_task/core/utils/colors.dart';
import 'package:esacc_task/core/utils/enums.dart';
import 'package:esacc_task/features/settings/bloc/settings_cubit.dart';
import 'package:esacc_task/features/settings/widgets/bluetooth/bluetooth_devices_dropdown.dart';
import 'package:esacc_task/features/settings/widgets/bluetooth/device_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BluetoothPart extends StatefulWidget {
  const BluetoothPart({Key? key}) : super(key: key);

  @override
  State<BluetoothPart> createState() => _BluetoothPartState();
}

class _BluetoothPartState extends State<BluetoothPart> {
  SettingsCubit get cubit => SettingsCubit.get(context);
  late StreamSubscription<List<ScanResult>> resultSubscription;
  late StreamSubscription<BluetoothAdapterState> bluetoothStateSubscription;

  List<BluetoothDevice> _availableDevices = [];

  @override
  void initState() {
    super.initState();
    bluetoothStateSubscription =
        FlutterBluePlus.adapterState.listen(_bluetoothAdapterListener);
    resultSubscription = FlutterBluePlus.onScanResults.listen(
        _scanResultListener,
        onError: (e) => AppFunctions.showToast(
            message: e.toString(), state: ToastStates.error));
  }

  @override
  void dispose() {
    super.dispose();
    resultSubscription.cancel();
    bluetoothStateSubscription.cancel();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const Icon(Icons.bluetooth),
            SizedBox(
              width: 5.w,
            ),
            const Text('Bluetooth'),
            const Spacer(),
            BlocBuilder<SettingsCubit, SettingsState>(
              buildWhen: (previous, current) =>
              current is ScanningState || current is FinishScanning,
              builder: (context, state) => state is ScanningState
                  ? const CircularProgressIndicator.adaptive(
                strokeAlign: 0,
                strokeWidth: 2,
              )
                  : TextButton(
                  onPressed: () => _startBluetoothScanning(),
                  child: Text(
                    'Scan',
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall!
                        .copyWith(
                        color: AppColors.lightSecondaryColor,
                        fontSize: 14.sp),
                  )),
            ),
          ],
        ),
        SizedBox(
          height: 10.h,
        ),
        BluetoothDevicesDropdown(
          items: _getAvailableDevices(),
        ),
      ],
    );
  }

  /// ///////////////////////////////////////
  /// ///////////// Helper Methods ///////////
  /// ////////////////////////////////////////

  Future<void> _startBluetoothScanning() async {
    cubit.startScanning();
    FlutterBluePlus.startScan(
      timeout: const Duration(seconds: 10),
      androidScanMode: AndroidScanMode.balanced,
      oneByOne: true,
    );
    await Future.delayed(const Duration(seconds: 10));
    cubit.finishScanning();
  }

  void _bluetoothAdapterListener(BluetoothAdapterState state) async {
    if (state == BluetoothAdapterState.on) {
      _startBluetoothScanning();
    } else if (state == BluetoothAdapterState.off) {
      if (Platform.isAndroid) {
        await FlutterBluePlus.turnOn();
      } else {
        AppFunctions.showToast(
            message: 'Turn on your bluetooth', state: ToastStates.warning);
      }
    }
  }

  void _scanResultListener(List<ScanResult> results) {
    _availableDevices.clear();
    if (results.isNotEmpty) {
      for (var result in results) {
        if (kDebugMode) {
          print(result.device.remoteId);
        }
        _availableDevices.add(result.device);
      }
      setState(() {});
    }
  }

  List<DropdownMenuItem<String>> _getAvailableDevices() {
    return _availableDevices
        .map((e) => DropdownMenuItem<String>(
      value: e.remoteId.str,
      child: DeviceWidget(
        device: e,
      ),
    ))
        .toList();
  }
}
