import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class WebScalingWrapper extends StatelessWidget {
  final Widget child;
  final double webScaleFactor;

  const WebScalingWrapper({
    Key? key,
    required this.child,
    this.webScaleFactor = 0.85, // Adjust this value to control zoom level
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Only apply scaling for web platform
    if (!kIsWeb) {
      return child;
    }

    // For web, adjust the MediaQuery data to control the scaling
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(
        // Adjust the text scaling factor to control zoom
        textScaleFactor: webScaleFactor,
        // You can also set specific device dimensions for consistent layout
        // size: const Size(1440, 900),
      ),
      child: child,
    );
  }
}
