import 'package:flutter/material.dart';

Type _typeOf<T>() => T;

abstract class BlocBase {
  void dispose();
}

class BlocProvider<T extends BlocBase> extends StatefulWidget {
  final Widget child;
  final T bloc;

  BlocProvider({
    Key key,
    @required this.child,
    @required this.bloc
  }) : super(key: key);

  @override
  _BlocProvider<T> createState() => _BlocProvider<T>();

  static T of<T extends BlocBase>(BuildContext context) {
    final type = _typeOf<_BlocProviderInherited<T>>();
    _BlocProviderInherited provider = context.ancestorInheritedElementForWidgetOfExactType(type)?.widget;
    return provider?.bloc;
  }
}

class _BlocProvider<T extends BlocBase> extends State<BlocProvider<T>> {
  @override
  void dispose() {
    widget.bloc?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _BlocProviderInherited(
      bloc: widget.bloc,
      child: widget.child,
    );
  }
}

class _BlocProviderInherited<T extends BlocBase> extends InheritedWidget{
  final T bloc;

  _BlocProviderInherited({
    Key key,
    @required Widget child,
    @required this.bloc
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(_BlocProviderInherited oldWidget) => false;
}