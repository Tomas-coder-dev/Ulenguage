import 'package:flutter/material.dart';

// Paleta UIX
const Color kBrandRed = Color(0xFFD72631);
const Color kOverlayBg = Color(0xFF23272E); // Gris oscuro para overlay

class LoadingOverlay extends StatelessWidget {
  final bool isLoading;
  final Widget child;

  const LoadingOverlay({
    super.key,
    required this.isLoading,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (isLoading)
          AnimatedOpacity(
            duration: const Duration(milliseconds: 250),
            opacity: isLoading ? 1 : 0,
            curve: Curves.easeInOut,
            child: AbsorbPointer(
              absorbing: true,
              child: Container(
                // Overlay gris oscuro semi-transparente, elegante y profesional
                color: kOverlayBg.withValues(alpha: 0.22),
                child: const Center(
                  child: SizedBox(
                    width: 54,
                    height: 54,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Color(0x19000000),
                            blurRadius: 14,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: CircularProgressIndicator(
                          strokeWidth: 4,
                          valueColor: AlwaysStoppedAnimation<Color>(kBrandRed),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
