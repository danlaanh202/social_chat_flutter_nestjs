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
  List<Status?> _myStatusList = [];
  Auth? _myInformation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    UserServices.getMyUser().then((data) {
      print(data?.username!);
      setState(() {
        _myInformation = data;
      });
    });
    PostServices.getPostsOfId().then((data) {
      print(data[0]?.authorId!);
      setState(() {
        _myStatusList = data;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Padding(padding: EdgeInsets.symmetric(vertical: 8)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(4), // Border width
                      decoration: const BoxDecoration(
                        color: Colors.blue,
                        shape: BoxShape.circle,
                      ),
                      child: ClipOval(
                        child: SizedBox.fromSize(
                          size: const Size.fromRadius(100), // Image radius
                          child: Image.network(
                            'https://res.cloudinary.com/dantranne/image/upload/v1684153729/file_flxejk.jpg',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 10,
                      right: 10,
                      child: Ink(
                        decoration: const ShapeDecoration(
                          color: Colors.grey,
                          shape: CircleBorder(),
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.image),
                          color: Colors.white,
                          onPressed: () {},
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text(
                _myInformation?.username ?? "User",
                style: const TextStyle(
                  fontSize: textSizeLargeMedium,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _myStatusList.length,
              itemBuilder: (context, index) {
                return StatusItem(statusItem: _myStatusList[index]);
              },
            )
          ],
        ),
      ),
    );
  }
}
