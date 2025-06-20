import 'package:flutter/material.dart';

class LoadingOverlay extends StatelessWidget {
  final bool isLoading;
  final Widget child;

  const LoadingOverlay({super.key, required this.isLoading, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (isLoading)
          AnimatedOpacity(
            duration: const Duration(milliseconds: 300),
            opacity: isLoading ? 1 : 0,
            child: Container(
              color: const Color(0xFF000000).withValues(alpha: 0.32),
              child: const Center(
                child: CircularProgressIndicator(
                  strokeWidth: 4,
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFD72631)),
                ),
              ),
            ),
          ),
      ],
    );
  }
}