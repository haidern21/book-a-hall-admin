import 'dart:io';
import 'package:flutter/material.dart';
class AddImageWidget extends StatelessWidget {
  final File? image;
  const AddImageWidget({Key? key, this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey,
      ),
      child: image==null? const Icon(
        Icons.add,
        color: Colors.black,
        size: 50,
      ):Image.file(image!,fit: BoxFit.cover,),
    );
  }
}
