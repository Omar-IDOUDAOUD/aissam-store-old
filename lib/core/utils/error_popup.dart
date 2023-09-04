import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

List<String> _ErrorsList = [];

class TestingErrorPopup {
  static void newPage(String errorMsg) {
    _ErrorsList.add(errorMsg);
    Get.to(ErrorDialog());
  }

  static void show(String errorMsg) {
    _ErrorsList.add(errorMsg);
    Get.bottomSheet(
      ErrorDialog(),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30),
        ),
      ),
      elevation: 20,
      backgroundColor: Colors.white,
      barrierColor: Colors.black.withOpacity(.2),
      isDismissible: true,
    );
  }
}

class ErrorDialog extends StatefulWidget {
  const ErrorDialog({super.key});

  @override
  State<ErrorDialog> createState() => _ErrorDialogState();
}

class _ErrorDialogState extends State<ErrorDialog> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 60,
              child: Row(
                children: [
                  Text(
                    'Error log: ',
                    style:
                        Get.textTheme.bodyLarge!.copyWith(color: Colors.black),
                  ),
                  Spacer(),
                  IconButton(
                      onPressed: () {
                        setState(() {
                          _ErrorsList.clear();
                        });
                      },
                      icon: Icon(Icons.delete))
                ],
              ),
            ),
            Expanded(
              child: ListView.separated(
                padding: EdgeInsets.all(15),
                itemCount: _ErrorsList.length,
                separatorBuilder: (ctx, i) {
                  return SizedBox(
                      height: 1, child: ColoredBox(color: Colors.black));
                },
                itemBuilder: (_, i) {
                  return Text(
                    _ErrorsList.elementAt(i),
                    style:
                        Get.textTheme.bodyLarge!.copyWith(color: Colors.black),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
