import 'package:flutter/material.dart';

class EmptyBox extends StatelessWidget{
  build(context) {
    final iphonex = MediaQuery.of(context).size.height >= 812.0;
    final bottomPadding = iphonex ? 16.0 : 0.0;
    return SliverToBoxAdapter(
      child: Container(
        height: 50 + bottomPadding,
      ),
    );
  }
}

final emptyBox = EmptyBox();