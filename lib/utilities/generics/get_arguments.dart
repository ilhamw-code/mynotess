import 'package:flutter/material.dart' show BuildContext,ModalRoute;

extension GetArguments on BuildContext {
  T? getArgument<T>(){
    final modalRoute=ModalRoute.of(this);
    if (modalRoute!=null) {
      final agrs = modalRoute.settings.arguments;
      if (agrs!= null && agrs is T) {
        return agrs as T;
      }
    }
    return null;
  }
}
