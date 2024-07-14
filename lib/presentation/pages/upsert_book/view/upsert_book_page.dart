import 'package:auto_route/auto_route.dart';
import 'package:booky/presentation/components/app_text_field.dart';
import 'package:booky/presentation/components/date_picker/date_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../components/app_button.dart';
import '../../../theme/text_style.dart';
import '../bloc/upsert_book_cubit.dart';
import 'user_book.dart';

@RoutePage()
class UpsertBookPage extends StatelessWidget {
  final UserBook? book;
  const UpsertBookPage({this.book, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UpsertBookCubit(),
      child: UpsertBookView(book),
    );
  }
}

class UpsertBookView extends StatelessWidget {
  final UserBook? book;
  const UpsertBookView(this.book, {super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<UpsertBookCubit>();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Book', style: AppTextStyle.appbarTitleStyle,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w,),
        child: SingleChildScrollView(
          child: Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              children: [
                30. verticalSpace,
                AppTextField(
                  label: 'Title',
                  minLine: 2,
                  maxLine: 3,
                  keyboardType: TextInputType.multiline,
                  initialValue: book?.title,
                  onChanged: cubit.onTitleChanged,
                ),
                24. verticalSpace,
                AppTextField(
                  label: 'Author',
                  maxLine: 1,
                  initialValue: book?.author,
                  onChanged: cubit.onAuthorChanged,
                ),
                24. verticalSpace,
                AppTextField(
                  label: 'description',
                  initialValue: book?.description,
                  minLine: 5,
                  maxLine: 7,
                  onChanged: cubit.onDescriptionChanged,
                ),
                32. verticalSpace,
                DatePicker(
                  initialDate: book?.publish,
                  onChanged: cubit.onPublishChanged,
                ),
                80. verticalSpace,
                AppButton(
                  title: 'Add Book',
                  onClicked: () => cubit.addBook(),
                ),
                24. verticalSpace,
              ],
            ),
          ),
        ),
      ),
    );
  }
}

