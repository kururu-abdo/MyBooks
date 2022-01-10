import 'package:flutter/material.dart';
import 'package:mybooks/core/model/user.dart';

class CircularImage extends StatelessWidget {
  final User? user;
  const CircularImage({Key? key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      width: 120,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.green,
      ),
      child: Center(
        child: Text(
          user!.placeName!.toString()[0],
          style: TextStyle(
              color: Colors.white, fontSize: 50, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
