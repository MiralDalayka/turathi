import 'package:flutter/material.dart';

import '../../../../utils/theme_manager.dart';


class RequestToBeExpert extends StatefulWidget {
  const RequestToBeExpert({super.key});

  @override
  State<RequestToBeExpert> createState() => _RequestToBeExpertState();

}

class _RequestToBeExpertState extends State<RequestToBeExpert> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Request To Be Expert',
          style: ThemeManager.textStyle.copyWith(color: ThemeManager.primary),
        ),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {

            },
            style: ThemeManager.buttonStyle,
            child: Text(
              'Request',
              style: ThemeManager.textStyle
                  .copyWith(color: ThemeManager.primary),
            ),
          )
        ],
      ),
    );
  }
}
