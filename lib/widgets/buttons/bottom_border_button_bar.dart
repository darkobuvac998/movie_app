import 'package:flutter/material.dart';

import 'bottom_border_button.dart';

class BottomBorderButtonBar extends StatelessWidget
    implements PreferredSizeWidget {
  final List<BottomBorderButton> items;
  final ValueChanged<int>? onTap;
  final int currentIndex;
  const BottomBorderButtonBar({
    Key? key,
    required this.items,
    this.onTap,
    this.currentIndex = 0,
  }) : super(key: key);

  List<Widget> _createButtons() {
    final List<Widget> buttons = <Widget>[];
    for (int i = 0; i < items.length; i++) {
      buttons.add(
        Expanded(
          child: _BottomBorderButtonBarItem(
            child: items[i].child,
            onPressed: items[i].onPressed,
            onTap: () => onTap?.call(i),
            showBorder: currentIndex == i,
          ),
        ),
      );
    }
    return buttons;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: _createButtons(),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _BottomBorderButtonBarItem extends StatelessWidget {
  final Widget child;
  final VoidCallback onPressed;
  final VoidCallback? onTap;
  final bool showBorder;
  const _BottomBorderButtonBarItem(
      {required this.child,
      required this.onPressed,
      this.onTap,
      this.showBorder = false,
      Key? key})
      : super(key: key);

  void _callMethods() {
    onTap!();
    onPressed();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.zero,
      padding: EdgeInsets.zero,
      decoration: showBorder
          ? const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  width: 1.5,
                  color: Colors.white,
                ),
              ),
            )
          : null,
      child: OutlinedButton(
        onPressed: _callMethods,
        child: FittedBox(
          child: child,
        ),
      ),
    );
  }
}
