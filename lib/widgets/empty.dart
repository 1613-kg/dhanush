import 'package:flutter/material.dart';

class empty extends StatelessWidget {
  const empty({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "Oops!! It's empty.Get something healthy!",
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    );
  }
}
