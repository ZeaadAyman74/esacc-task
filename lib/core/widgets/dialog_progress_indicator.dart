import 'package:esacc_task/core/widgets/my_progress.dart';
import 'package:flutter/material.dart';

class DialogIndicator extends StatelessWidget {
  const DialogIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const AlertDialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      content: Center(
        child: MyProgress(),
      ),
    );
  }
}