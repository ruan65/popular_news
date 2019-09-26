import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CupertinoSearchBar extends StatelessWidget {
  const CupertinoSearchBar({Key key, this.placeHolder, this.textEditingController})
      : super(key: key);

  final TextEditingController textEditingController;
  final String placeHolder;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(const Radius.circular(10)),
            color: CupertinoColors.lightBackgroundGray),
        child: CupertinoTextField(
          style: null,
          prefix: const Icon(
            CupertinoIcons.search,
            color: CupertinoColors.inactiveGray,
          ),
          placeholder: 'Начните поиск',
          placeholderStyle: const TextStyle(color: CupertinoColors.inactiveGray),
          autocorrect: false,
          textInputAction: TextInputAction.search,
          clearButtonMode: OverlayVisibilityMode.editing,
          onChanged: (text) {
            // searchState.searchDrugs(text: text);
          },
          controller: textEditingController,
        ),
      ),
    );
  }
}
