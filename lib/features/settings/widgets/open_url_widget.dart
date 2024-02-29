import 'package:esacc_task/core/routing/routes.dart';
import 'package:esacc_task/core/utils/app_extensions.dart';
import 'package:esacc_task/features/settings/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OpenUrlWidget extends StatefulWidget {
  const OpenUrlWidget({Key? key}) : super(key: key);

  @override
  State<OpenUrlWidget> createState() => _OpenUrlWidgetState();
}

class _OpenUrlWidgetState extends State<OpenUrlWidget> {
  final TextEditingController _controller = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: CustomTextField(
                validator: _validateUrl,
                controller: _controller,
                hint: 'Enter Url to browse'),
          ),
          SizedBox(
            width: 5.w,
          ),
          IconButton(
              onPressed: () {
                if(_formKey.currentState!.validate()){
                  context.push(Routes.webView, arg: _controller.text);
                }
              },
              icon: const Icon(Icons.launch))
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  /// ///////////////////////////////////////
  /// ///////////// Helper Methods ///////////
  /// ////////////////////////////////////////
  String? _validateUrl(String? url) {
    if (url.isNullOrEmpty) {
      return 'Please enter the url';
    } else {
      final RegExp urlRegExp = RegExp(
        r'^(?:http|https):\/\/(?:www\.)?[a-zA-Z0-9\-\.]+(?:\.[a-zA-Z]{2,})+(?:\/[^\s]*)?$',
      );
      if (!urlRegExp.hasMatch(url!)) {
        return 'Entre a valid url';
      } else {
        return null;
      }
    }
  }
}
