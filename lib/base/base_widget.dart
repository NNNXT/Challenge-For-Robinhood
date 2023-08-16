// Flutter Modules
import 'package:flutter/material.dart';

// External Modules
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

  const BaseWidget({
    required this.builder,
    required this.model,
    this.child,
    this.onModelReady,
    Key? key,
  }) : super(key: key);

  @override
  BaseWidgetState<T> createState() => BaseWidgetState<T>();
}

class BaseWidgetState<T extends ChangeNotifier> extends State<BaseWidget<T>> {
  late T model;

  @override
  void initState() {
    model = widget.model;

    if (widget.onModelReady != null) {
      widget.onModelReady!(model);
    }

    super.initState();
  }

  Widget _mainContainer() => ChangeNotifierProvider<T>(
        create: (_) => model,
        child: Consumer<T>(
          builder: (context, value, child) => widget.builder(
            context,
            model,
            child,
          ),
          child: widget.child,
        ),
      );

  @override
  Widget build(BuildContext context) => _mainContainer();
}
