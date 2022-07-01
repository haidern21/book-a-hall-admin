import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class EditImageWidget extends StatefulWidget {
  final String? image;

  const EditImageWidget({Key? key, this.image}) : super(key: key);

  @override
  _EditImageWidgetState createState() => _EditImageWidgetState();
}

class _EditImageWidgetState extends State<EditImageWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey,
      ),
      child: widget.image == null
          ? const Icon(
              Icons.add,
              color: Colors.black,
              size: 50,
            )
          : CachedNetworkImage(
              imageUrl: widget.image!,
              fit: BoxFit.cover,
            ),
    );
  }
}
