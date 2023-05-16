import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_chat/constants/social_strings.dart';
import 'package:social_chat/models/DarkModeModel.dart';
import 'package:social_chat/models/auth.model.dart';
import 'package:social_chat/models/status.model.dart';
import 'package:social_chat/services/post_services.dart';
import 'package:social_chat/services/user_services.dart';
import 'package:social_chat/widget/MySquareButton.dart';
import 'package:social_chat/widget/status/StatusItem.dart';

class UserScreen extends StatefulWidget {
  final String? userId;
  const UserScreen({Key? key, required this.userId}) : super(key: key);

  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  List<Status?> _myStatusList = [];
  Auth? _myInformation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    UserServices.getMyUser(widget.userId).then((data) {
      print(data?.username!);
      setState(() {
        _myInformation = data;
      });
    });
    PostServices.getPostsOfId(widget.userId).then((data) {
      print(data[0]?.authorId!);
      setState(() {
        _myStatusList = data;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final darkModeModel = Provider.of<DarkModeModel>(context, listen: false);
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: SizedBox(
          width: width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MySquareButton(
                width: 36,
                height: 36,
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              Text(
                "User",
                style: TextStyle(
                  fontSize: textSizeMedium,
                  color: darkModeModel.isDarkMode ? Colors.white : Colors.black,
                ),
              ),
              const SizedBox(
                width: 36,
                height: 36,
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
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
                                size:
                                    const Size.fromRadius(100), // Image radius
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
          ),
        ],
      ),
    );
  }
}
