



import 'package:flutter_riverpod/legacy.dart';

class NavigationProvider extends StateNotifier<int> {
  NavigationProvider() : super(0);

 

  void setIndex(int index) {
    state = index;
  }
}

final navigationProvider = StateNotifierProvider.autoDispose<NavigationProvider, int>((ref)=> NavigationProvider() );
