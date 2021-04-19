import 'package:flutter/material.dart';

class UnauthorizedAccessWidget extends StatelessWidget {
  const UnauthorizedAccessWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Unauthorized access!'),
    );
  }
}
