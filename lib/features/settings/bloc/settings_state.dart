part of 'settings_cubit.dart';

@immutable
abstract class SettingsState {}

class SettingsInitial extends SettingsState {}

class ScanningState extends SettingsState {}

class FinishScanning extends SettingsState {}
