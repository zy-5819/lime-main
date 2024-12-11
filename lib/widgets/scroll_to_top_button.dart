

import 'package:flutter/material.dart';

class ScrollToTopButton extends StatelessWidget {
  /// “回到顶部”按钮
  const ScrollToTopButton({Key? key, required this.scrollController})
      : super(key: key);

  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: scrollController,
        builder: ((context, child) {
          double scrollOffset = scrollController.hasClients
              ? scrollController.offset
              : scrollController.initialScrollOffset;
          return scrollOffset > MediaQuery.of(context).size.height * 0.5
              ? FloatingActionButton(
                  heroTag: 'scrollToTopButton',
                  tooltip: '回到顶部',
                  onPressed: (() {
                    scrollController.animateTo(0,
                        duration: const Duration(milliseconds: 200),
                        curve: Curves.easeInOut);
                  }),
                  child: const Icon(Icons.arrow_upward))
              : const SizedBox();
        }));
  }
}
