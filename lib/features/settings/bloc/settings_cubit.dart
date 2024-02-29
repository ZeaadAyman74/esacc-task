import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit() : super(SettingsInitial());

  static SettingsCubit get(BuildContext context)=>BlocProvider.of<SettingsCubit>(context);

  void startScanning(){
    emit(ScanningState());
  }
  void finishScanning(){
    emit(FinishScanning());
  }

}
