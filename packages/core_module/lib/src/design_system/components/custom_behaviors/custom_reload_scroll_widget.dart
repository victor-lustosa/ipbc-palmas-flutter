import 'dart:io';

import 'package:core_module/core_module.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomReloadScrollWidget extends StatelessWidget {
  const CustomReloadScrollWidget({
    super.key,
    required this.action,
    required this.child,
  });

  final Future<void> Function() action;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicatorWidget(
      action: action,
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        slivers: [
          CupertinoSliverWidget(action: action),
          SliverToBoxAdapter(child: child),
        ],
      ),
    );
  }
}

class CupertinoSliverWidget extends StatelessWidget {
  const CupertinoSliverWidget({
    super.key,
    this.radius,
    this.color,
    this.size,
    required this.action,
  });

  final double? radius;
  final double? size;
  final Color? color;
  final Future<void> Function() action;

  @override
  Widget build(context) {
    return Platform.isIOS
        ? CupertinoSliverRefreshControl(
            onRefresh: action,
            builder: (_, _, pulledExtent, _, _) {
              return Center(
                child: Opacity(
                  opacity: (pulledExtent / 100.0).clamp(0.0, 1.0),
                  child: CupertinoActivityIndicator(
                    color: color ?? AppColors.darkGreen,
                    radius: radius ?? 14,
                  ),
                ),
              );
            },
          )
        : const SliverToBoxAdapter(child: SizedBox.shrink());
  }
}

class RefreshIndicatorWidget extends StatelessWidget {
  const RefreshIndicatorWidget({
    super.key,
    this.color,
    this.elevation,
    this.backgroundColor,
    required this.action,
    required this.child,
  });

  final double? elevation;
  final Color? backgroundColor;
  final Color? color;
  final Future<void> Function() action;
  final Widget child;

  @override
  Widget build(context) {
    return Platform.isAndroid
        ? CustomNativeRefresh(onRefresh: action, child: child)
        : child;
  }
}

class CustomNativeRefresh extends StatefulWidget {
  final Widget child;
  final Future<void> Function() onRefresh;

  const CustomNativeRefresh({
    super.key,
    required this.child,
    required this.onRefresh,
  });

  @override
  State<CustomNativeRefresh> createState() => _CustomNativeRefreshState();
}

class _CustomNativeRefreshState extends State<CustomNativeRefresh> {
  bool _isRefreshing = false;
  double _dragOffset = 0.0;

  final double _triggerDistance = 80.0;
  final double _maxDragDistance = 120.0;

  bool _handleScrollNotification(ScrollNotification notification) {
    if (notification is ScrollUpdateNotification) {
      if (notification.metrics.pixels < 0) {
        final double overscroll = notification.metrics.pixels.abs();
        if (!_isRefreshing) {
          setState(() {
            _dragOffset = overscroll.clamp(0.0, _maxDragDistance);
          });
        }
      } else if (_dragOffset > 0 && !_isRefreshing) {
        setState(() {
          _dragOffset = 0.0;
        });
      }
    } else if (notification is ScrollEndNotification) {
      if (_dragOffset >= _triggerDistance && !_isRefreshing) {
        _startRefresh();
      } else {
        _reset();
      }
    }
    return false;
  }

  void _startRefresh() async {
    setState(() {
      _isRefreshing = true;
      _dragOffset = _triggerDistance;
    });

    try {
      await widget.onRefresh();
    } finally {
      if (mounted) {
        _reset();
      }
    }
  }

  void _reset() {
    setState(() {
      _isRefreshing = false;
      _dragOffset = 0.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        NotificationListener<ScrollNotification>(
          onNotification: _handleScrollNotification,
          child: widget.child,
        ),

        if (_dragOffset > 0)
          Positioned(
            top: _dragOffset - 45,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                width: 45,
                height: 45,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withAlpha(10),
                      blurRadius: 2,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Center(
                  child: const LoadingWidget(
                    size: 22,
                    androidRadius: 2.5,
                    iosRadius: 10,
                    color: AppColors.darkGreen,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
