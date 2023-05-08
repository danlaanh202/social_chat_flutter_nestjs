import 'package:social_chat/models/ActiveNavmodel.dart';
import 'package:social_chat/models/DarkModeModel.dart';

class AppModel {
  final DarkModeModel darkModeModel;
  final ActiveNavModel activeNavModel;

  AppModel(this.darkModeModel, this.activeNavModel);
}
