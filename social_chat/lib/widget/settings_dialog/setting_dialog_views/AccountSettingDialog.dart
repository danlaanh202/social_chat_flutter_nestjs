import 'package:flutter/material.dart';
import 'package:social_chat/constants/social_strings.dart';
import 'package:social_chat/models/auth.model.dart';
import 'package:social_chat/models/status.model.dart';
import 'package:social_chat/services/auth_services.dart';
import 'package:social_chat/services/post_services.dart';
import 'package:social_chat/services/user_services.dart';
import 'package:social_chat/widget/status/StatusItem.dart';

class AccountSettingDialog extends StatefulWidget {
  const AccountSettingDialog({Key? key}) : super(key: key);

  @override
  _AccountSettingDialogState createState() => _AccountSettingDialogState();
}

class _AccountSettingDialogState extends State<AccountSettingDialog> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
