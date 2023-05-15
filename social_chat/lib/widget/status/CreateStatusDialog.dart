import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_chat/models/DarkModeModel.dart';
import 'package:social_chat/widget/MySquareButton.dart';
import '../../constants/social_strings.dart';
import '../../services/post_services.dart';

class CreateStatusDialog extends StatefulWidget {
  const CreateStatusDialog({Key? key}) : super(key: key);

  @override
  _CreateStatusDialogState createState() => _CreateStatusDialogState();
}

class _CreateStatusDialogState extends State<CreateStatusDialog> {
  String _filePath = "";
  final TextEditingController _descriptionController = TextEditingController();
  Future<void> _pickAndPreviewFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      File file = File(result.files.single.path!);
      String filePath = file.path;
      setState(() {
        _filePath = filePath;
      });
      // Gọi hàm uploadFileToServer với đường dẫn tệp tin
      // PostServices.uploadFileToServer(filePath);
    } else {
      // Người dùng không chọn tệp tin
      print("nah");
    }
  }

  Future<void> _handlePost() async {
    if (_filePath != "") {
      PostServices.uploadFileToServer(_filePath, _descriptionController.text)
          .then((data) {
        Navigator.of(context)
            .pushNamedAndRemoveUntil("/home", (route) => false);
      });
    } else {
      print("Chưa post được");
    }
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var darkModeModel = Provider.of<DarkModeModel>(context);
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
                "Create post",
                style: TextStyle(
                  fontSize: textSizeMedium,
                  color: darkModeModel.isDarkMode ? Colors.white : Colors.black,
                ),
              ),
              ElevatedButton(
                onPressed: _handlePost,
                child: const Text("Post"),
              )
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [],
            ),
            SizedBox(
              width: width,
              height: 300,
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: SizedBox(
                  child: TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "What do you think?",
                      hintStyle: TextStyle(
                        fontSize: textSizeLargeMedium,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            _filePath != ""
                ? Stack(
                    children: [
                      Image.file(
                        File(
                          _filePath,
                        ),
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                      Positioned(
                        top: 10,
                        right: 10,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              _filePath = "";
                            });
                          },
                          child: const Icon(
                            Icons.close,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  )
                : Container(),
          ],
        ),
      ),
      floatingActionButton: SizedBox(
        width: 64,
        height: 64,
        child: Ink(
          decoration: const ShapeDecoration(
            color: Colors.blue,
            shape: CircleBorder(),
          ),
          child: IconButton(
            icon: const Icon(Icons.image),
            color: Colors.white,
            onPressed: () {
              _pickAndPreviewFile();
            },
          ),
        ),
      ),
    );
  }
}
