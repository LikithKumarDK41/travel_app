import 'package:flutter/material.dart';

class ImagePlaceholder extends StatelessWidget {
  final double height;
  final double width;
  final String? text;

  const ImagePlaceholder({
    super.key,
    this.height = 200,
    this.width = double.infinity,
    this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.image_not_supported_outlined,
              color: Colors.grey.shade400,
              size: 40,
            ),
            if (text != null) ...[
              const SizedBox(height: 8),
              Text(
                text!,
                style: TextStyle(color: Colors.grey.shade500, fontSize: 12),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
