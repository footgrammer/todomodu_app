//Please delete this file
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileImage extends StatelessWidget {
  const ProfileImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0XFFD9D9D9),
          ),
        ),
        Positioned(
          right: 0,
          bottom: 0,
          child: GestureDetector(
            onTap: (){
              log('카메라 버튼 클릭');
            },
            child: Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                border: Border.all(width: 2, color: Colors.white),
                shape: BoxShape.circle,
                color: Color(0XFFD9D9D9),
              ),
              child: Icon(
                CupertinoIcons.camera,
                size: 18,
                color: Color(0XFF1C1B1F),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
