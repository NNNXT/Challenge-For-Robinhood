// Flutter Modules
import 'package:flutter/material.dart';

// External Modules
import 'package:focus_detector/focus_detector.dart';
import 'package:provider/provider.dart';

class BaseWidget<T extends ChangeNotifier> extends StatefulWidget {
  final Widget Function(
    BuildContext context,
    T model,
    Widget? child,
  ) builder;

  final T model;
  final Widget? child;
  final void Function(T model)? onModelReady;
  final void Function(T model)? onPageResume;
  final void Function(T model)? onPagePause;

  const BaseWidget({
    required this.builder,
    required this.model,
    this.child,
    this.onModelReady,
    this.onPageResume,
    this.onPagePause,
    Key? key,
  }) : super(key: key);

  @override
  BaseWidgetState<T> createState() => BaseWidgetState<T>();
}

class BaseWidgetState<T extends ChangeNotifier> extends State<BaseWidget<T>> {
  late T model;

  bool get _isNeedFocusDetector => widget.onPageResume != null || widget.onPagePause != null;

  @override
  void initState() {
    model = widget.model;

    if (widget.onModelReady != null) {
      widget.onModelReady!(model);
    }

    super.initState();
  }

  Widget _focusDetector({required Widget child}) => _isNeedFocusDetector
      ? FocusDetector(
          onFocusGained: () {
            if (widget.onPageResume != null) {
              widget.onPageResume!(model);
            }
          },
          onFocusLost: () {
            if (widget.onPagePause != null) {
              widget.onPagePause!(model);
            }
          },
          child: child,
        )
      : child;

  Widget _mainContainer() => ChangeNotifierProvider<T>.value(
        value: model,
        child: Consumer<T>(
          builder: (context, value, child) => widget.builder(context, model, child),
          child: widget.child,
        ),
      );

  @override
  Widget build(BuildContext context) => _focusDetector(
        child: _mainContainer(),
      );
}
