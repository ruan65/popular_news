import 'package:flutter/material.dart';
import 'list_element/list_item_view.dart';
import 'list_element/list_item_state.dart';


class ListWidget extends StatelessWidget{
  final values;
  ListWidget(this.values);

  build(context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate((context, index){
        return ListItemView(
            values[index].source["name"],
            values[index].url,
            values[index].title,
            values[index].publishedAt,
            values[index].urlToImage,
            ListItemState(values[index].liked)
        );
      },
          childCount: values.length
      ),
    );
  }
}
