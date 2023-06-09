// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'settings_bloc.dart';

sealed class SettingsState extends Equatable {
  final SettingsModel settingsModel;
  final SettingsError? settingsError;

  const SettingsState({required this.settingsModel, this.settingsError});
}

@immutable
final class SettingsStateGlobal extends SettingsState {
  const SettingsStateGlobal(
      {required super.settingsModel, super.settingsError});

  @override
  List<Object?> get props => [super.settingsModel, super.settingsError];
}
