import 'package:built_value/built_value.dart';
import 'package:redux/redux.dart';

import '../../redux/app_state.dart';
import '../../models/password.dart';

part 'home_screen_view_model.g.dart';

abstract class HomeScreenViewModel
    implements Built<HomeScreenViewModel, HomeScreenViewModelBuilder> {
  bool get showEditButton;

  @nullable
  Password get selectedPassword;

  bool get showDeleteButton;

  bool get showFab;

  bool get isLoading;

  HomeScreenViewModel._();

  factory HomeScreenViewModel(
          [void Function(HomeScreenViewModelBuilder) updates]) =
      _$HomeScreenViewModel;

  static HomeScreenViewModel fromStore(Store<AppState> store) {
    final selectedPassword = store.state.selectedPasswordIds.length == 1
        ? store.state.passwords.firstWhere(
            (element) => element.id == store.state.selectedPasswordIds.first)
        : null;

    return HomeScreenViewModel((b) => b
      ..selectedPassword = selectedPassword?.toBuilder()
      ..showEditButton = selectedPassword != null
      ..showDeleteButton = store.state.selectedPasswordIds.length > 0
      ..showFab = store.state.selectedPasswordIds.length == 0
      ..isLoading = store.state.loadingPasswords);
  }
}
