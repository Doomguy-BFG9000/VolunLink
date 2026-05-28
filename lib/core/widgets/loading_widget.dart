import 'package:flutter/material.dart';
import 'package:volun_link/app/theme/app_colors.dart';

/// LoadingWidget - Reusable loading indicator
/// Shows loading state with optional message
class LoadingWidget extends StatelessWidget {
  final String? message;
  final double size;
  final Color? color;

  const LoadingWidget({
    super.key,
    this.message,
    this.size = 40,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: size,
            height: size,
            child: CircularProgressIndicator(
              strokeWidth: 3,
              valueColor: AlwaysStoppedAnimation<Color>(
                color ?? AppColors.primary,
              ),
            ),
          ),
          if (message != null) ...[
            const SizedBox(height: 16),
            Text(
              message!,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? AppColors.darkTextSecondary
                        : AppColors.lightTextSecondary,
                  ),
              textAlign: TextAlign.center,
            ),
          ],
        ],
      ),
    );
  }
}

/// ShimmerLoading - Skeleton loading for lists
/// Shows placeholder content while loading
class ShimmerLoading extends StatefulWidget {
  final double width;
  final double height;
  final double borderRadius;

  const ShimmerLoading({
    super.key,
    required this.width,
    required this.height,
    this.borderRadius = 8,
  });

  @override
  State<ShimmerLoading> createState() => _ShimmerLoadingState();
}

class _ShimmerLoadingState extends State<ShimmerLoading>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat();
    _animation = Tween<double>(begin: -1.0, end: 2.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final baseColor = isDark ? AppColors.darkCard : AppColors.lightDivider;
    final highlightColor = isDark
        ? AppColors.darkBorder
        : AppColors.lightTextTertiary.withOpacity(0.3);

    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            gradient: LinearGradient(
              begin: Alignment(_animation.value - 1, 0),
              end: Alignment(_animation.value, 0),
              colors: [
                baseColor,
                highlightColor,
                baseColor,
              ],
              stops: const [0.0, 0.5, 1.0],
            ),
          ),
        );
      },
    );
  }
}

/// NGO Card Shimmer - Specific shimmer for NGO cards
class NGOCardShimmer extends StatelessWidget {
  const NGOCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const ShimmerLoading(width: 60, height: 60, borderRadius: 30),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const ShimmerLoading(width: 150, height: 16),
                      const SizedBox(height: 8),
                      ShimmerLoading(
                        width: 100,
                        height: 12,
                        borderRadius: 6,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            const ShimmerLoading(width: double.infinity, height: 12),
            const SizedBox(height: 6),
            const ShimmerLoading(width: double.infinity, height: 12),
            const SizedBox(height: 6),
            const ShimmerLoading(width: 200, height: 12),
          ],
        ),
      ),
    );
  }
}

/// List Shimmer - Shows multiple shimmer items
class ListShimmer extends StatelessWidget {
  final int itemCount;
  final Widget shimmerItem;

  const ListShimmer({
    super.key,
    this.itemCount = 5,
    required this.shimmerItem,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: itemCount,
      itemBuilder: (context, index) => shimmerItem,
    );
  }
}

/// Usage:
/// 
/// 1. Simple Loading:
/// LoadingWidget()
/// 
/// 2. Loading with Message:
/// LoadingWidget(message: 'Loading NGOs...')
/// 
/// 3. List Shimmer:
/// ListShimmer(
///   itemCount: 5,
///   shimmerItem: NGOCardShimmer(),
/// )
/// 
/// 4. Custom Shimmer:
/// ShimmerLoading(
///   width: 100,
///   height: 20,
///   borderRadius: 10,
/// )
