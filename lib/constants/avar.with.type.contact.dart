import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class AvarNormal extends StatelessWidget {
  final String? avar;
  final bool isCircle;
  const AvarNormal({super.key, required this.avar, this.isCircle = true});

  @override
  Widget build(BuildContext context) {
    if (avar!.contains('http')) {
      return Center(
        child: CachedNetworkImage(
            fit: BoxFit.cover,
            imageBuilder: (context, imageProvider) {
              return Container(
                  decoration: BoxDecoration(
                      borderRadius:
                          isCircle ? null : BorderRadius.circular(10),
                      shape:
                          isCircle ? BoxShape.circle : BoxShape.rectangle,
                      image: DecorationImage(
                          fit: BoxFit.cover, image: imageProvider)));
            },
            imageUrl: avar!),
      );
    }
    return Container(
        decoration: BoxDecoration(
            borderRadius: isCircle ? null : BorderRadius.circular(10),
            shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
            image: DecorationImage(
                fit: BoxFit.cover,
                image: avar?.isEmpty ?? true
                    ? const AssetImage("assets/noavatar.jpeg")
                    : (avar!.startsWith('http')
                        ? NetworkImage(avar!)
                        : const AssetImage("assets/noavatar.jpeg")
                            as ImageProvider))));
  }
}
