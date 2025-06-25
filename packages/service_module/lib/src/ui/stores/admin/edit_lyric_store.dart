import 'package:core_module/core_module.dart';
import 'package:flutter/cupertino.dart';

class EditLyricStore extends ValueNotifier<GenericState<EditLyricState>> {
  EditLyricStore() : super(LoadingState());
  initial(){
    value = InitialState();
  }
}

@immutable
abstract class EditLyricState {}
