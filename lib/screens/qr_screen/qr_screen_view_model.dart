import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:redux/redux.dart';

import '../../redux/app_state.dart';
import '../../models/password.dart';

part 'qr_screen_view_model.g.dart';

abstract class QRScreenViewModel
    implements Built<QRScreenViewModel, QRScreenViewModelBuilder> {
  BuiltList<Password> get selectedPasswords;

  QRScreenViewModel._();

  factory QRScreenViewModel([void Function(QRScreenViewModelBuilder) updates]) =
      _$QRScreenViewModel;

  static QRScreenViewModel fromStore(Store<AppState> store) {
    return QRScreenViewModel((b) => b
      ..selectedPasswords = ListBuilder(store.state.selectedPasswordIds.map(
          (e) =>
              store.state.passwords.firstWhere((element) => element.id == e))));
  }
}
