import 'package:flutter/material.dart';
import 'package:social_chat/widget/settings_dialog/setting_dialog_views/AccountSettingDialog.dart';
import 'package:social_chat/widget/settings_dialog/setting_dialog_views/ChatSettingDialog.dart';
import 'package:social_chat/widget/settings_dialog/setting_dialog_views/DataAndStorageDialog.dart';
import 'package:social_chat/widget/settings_dialog/setting_dialog_views/NotificationsDialog.dart';

class DialogItem {
  final String title;
  final Widget dialogBody;
  DialogItem({
    required this.title,
    required this.dialogBody,
  });
}

List<DialogItem> dialogList = [
  DialogItem(
    title: "Account",
    dialogBody: const AccountSettingDialog(),
  ),
  DialogItem(
    title: "Chat",
    dialogBody: const ChatSettingDialog(),
  ),
  DialogItem(
    title: "Data & Storage",
    dialogBody: const DataAndStorageDialog(),
  ),
  DialogItem(
    title: "Notifications",
    dialogBody: const NotificationsDialog(),
  ),
  DialogItem(
    title: "Helps",
    dialogBody: const NotificationsDialog(),
  ),
];
