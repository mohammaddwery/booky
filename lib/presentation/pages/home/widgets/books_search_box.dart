import 'package:booky/presentation/components/search_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BooksSearchBox extends StatelessWidget {
  const BooksSearchBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w,),
      child: SearchBox(
        onChanged: (value) {
          // TODO
        },
      ),
    );
  }
}
