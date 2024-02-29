import 'package:esacc_task/features/settings/bloc/settings_cubit.dart';
import 'package:esacc_task/features/settings/widgets/bluetooth/bluetooth_part.dart';
import 'package:esacc_task/features/settings/widgets/open_url_widget.dart';
import 'package:esacc_task/features/settings/widgets/wifi/wifi_part.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  SettingsCubit get cubit => SettingsCubit.get(context);


  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _appBar(),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: Column(
            children: [
              const OpenUrlWidget(),
              SizedBox(
                height: 30.h,
              ),
             const BluetoothPart(),
              SizedBox(height: 40.h,),
              const WifiPart(),
            ],
          ),
        ));
  }

  /// ///////////////////////////////////////
  /// ///////////// Helper Widgets ///////////
  /// ////////////////////////////////////////

  AppBar _appBar() => AppBar(
        title: const Text('Settings'),
      );

  /// ///////////////////////////////////////
  /// ///////////// Helper Methods ///////////
  /// ////////////////////////////////////////

}
