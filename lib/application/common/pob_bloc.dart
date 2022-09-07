import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// TODO: USE REPLAY_BLOC ONCE APPROPRIATE CHANGES HAVE BEEN MADE
abstract class PopBloc<Event, State> extends Bloc<Event, State> {
  @protected
  final List<int> currentItemsInStack = [];

  PopBloc(State initialState) : super(initialState);

  Event getEventForPop(int? id);

  void pop() {
    final id = _popAndGetLastKey();
    if (id != null) {
      final event = getEventForPop(id);
      add(event);
    }
  }

  int? _popAndGetLastKey() {
    if (currentItemsInStack.isEmpty) {
      return null;
    }

    currentItemsInStack.removeLast();
    if (currentItemsInStack.isEmpty) {
      return null;
    }

    return currentItemsInStack.last;
  }
}