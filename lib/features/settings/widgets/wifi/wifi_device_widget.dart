import 'package:esacc_task/core/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_nearby_connections/flutter_nearby_connections.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WifiDeviceWidget extends StatefulWidget {
  const WifiDeviceWidget({Key? key,required this.device,required this.onConnectPress}) : super(key: key);
final Device device;
final VoidCallback onConnectPress;
  @override
  State<WifiDeviceWidget> createState() => _WifiDeviceWidgetState();
}

class _WifiDeviceWidgetState extends State<WifiDeviceWidget> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.devices),
      title: Text(widget.device.deviceName),
      trailing: OutlinedButton(
          onPressed:widget.onConnectPress,
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
          child: Text(getButtonStateName(widget.device.state),
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  color: AppColors.lightPrimaryColor, fontSize: 12.sp))),
    );
  }

  /// ///////////////////////////////////////////////
  /// /////////////////// Helper Methods ////////////
  /// //////////////////////////////////////////////

  String getButtonStateName(SessionState state) {
    switch (state) {
      case SessionState.notConnected:
      case SessionState.connecting:
        return "Connect";
      default:
        return "Disconnect";
    }
  }

  Color getStateColor(SessionState state) {
    switch (state) {
      case SessionState.notConnected:
        return Colors.black;
      case SessionState.connecting:
        return Colors.grey;
      default:
        return Colors.green;
    }
  }

  Color getButtonColor(SessionState state) {
    switch (state) {
      case SessionState.notConnected:
      case SessionState.connecting:
        return Colors.green;
      default:
        return Colors.red;
    }
  }

}
