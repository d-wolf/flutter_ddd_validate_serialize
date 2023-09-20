import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key, this.param});
  static const String routeName = 'error_page';

  final Object? param;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: Text(
          param != null ? 'Unexpected error: $param.' : 'Unexpected error.',
        ),
      ),
    );
  }
}
