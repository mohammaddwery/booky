import 'package:auto_route/auto_route.dart';
import 'package:booky/presentation/components/app_text_field.dart';
import 'package:booky/presentation/components/date_picker/date_picker.dart';
import 'package:booky/presentation/pages/upsert_book/bloc/upsert_book_event.dart';
import 'package:booky/repository/books_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../components/app_button.dart';
import '../../../routes/app_router.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/text_style.dart';
import '../bloc/upsert_book_bloc.dart';
import '../../../../data/models/user_book.dart';
import '../bloc/upsert_book_state.dart';

@RoutePage()
class UpsertBookPage extends StatelessWidget {
  final UserBook? book;
  const UpsertBookPage({this.book, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UpsertBookBloc(context.read<BooksRepository>(), book),
      child: UpsertBookView(book?.id,),
    );
  }
}

class UpsertBookView extends StatelessWidget {
  final int? bookId;
  const UpsertBookView(this.bookId, {super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<UpsertBookBloc>();
    return BlocConsumer<UpsertBookBloc, UpsertBookState>(
      listener: (context, state) {
        if(state.runtimeType == AddBookSuccess) {
          context.replaceRoute(const MyBooksRoute());
          return;
        }

        if(state.runtimeType == UpdateBookSuccess) {
          context.maybePop((state as UpdateBookSuccess).updatedbookId);
          return;
        }

        if(state.runtimeType == UpsertBookFailure) {
            Fluttertoast.showToast(
              msg: (state as UpsertBookFailure).message,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: AppColors.error,
              textColor: AppColors.accent,
              fontSize: 14.sp,
            );
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            key: const Key('AppBar_Key'),
            title: Text(
              bookId == null ? 'Add Book' : 'Update Book',
              style: AppTextStyle.appbarTitleStyle,
            ),
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w,),
            child: SingleChildScrollView(
              key: const Key('UpsertBookForm_SingleChildScrollView'),
              child: Form(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    30. verticalSpace,
                    AppTextField(
                      key: const Key('BookTitle_AppTextField'),
                      label: 'Title',
                      minLine: 2,
                      maxLine: 3,
                      keyboardType: TextInputType.multiline,
                      initialValue: state.title,
                      onChanged: (value) => bloc.add(BookTitleChanged(value)),
                    ),
                    24. verticalSpace,
                    AppTextField(
                      key: const Key('BookAuthor_AppTextField'),
                      label: 'Author',
                      maxLine: 1,
                      initialValue: state.author,
                      onChanged: (value) => bloc.add(BookAuthorChanged(value)),
                    ),
                    24. verticalSpace,
                    AppTextField(
                      key: const Key('BookDescription_AppTextField'),
                      label: 'description',
                      initialValue: state.description,
                      minLine: 5,
                      maxLine: 7,
                      onChanged: (value) => bloc.add(BookDescriptionChanged(value)),
                    ),
                    24. verticalSpace,
                    Text(
                      'Publish date',
                      style: AppTextStyle.style.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w400,
                        fontSize: 11.sp,
                      ),
                    ),
                    4.verticalSpace,
                    DatePicker(
                      key: const Key('BookPublishDate_DatePicker'),
                      initialDate: state.publish,
                      onChanged: (value) => bloc.add(BookPublishDateChanged(value)),
                    ),
                    80. verticalSpace,
                    AppButton(
                      key: const Key('UpsertBook_AppButton'),
                      title: bookId == null ? 'Add Book' : 'Update Book',
                      onClicked: () {
                        if(bookId == null) {
                          bloc.add(AddBookRequested(UserBook(
                            id: DateTime.now().millisecond,
                            author: state.author,
                            title: state.title,
                            description: state.description,
                            publish: state.publish,
                          )));
                        } else {
                          bloc.add(UpdateBookRequested(bookId!, UserBook(
                            id: DateTime.now().millisecond,
                            author: state.author,
                            title: state.title,
                            description: state.description,
                            publish: state.publish,
                          )));
                        }
                      },
                    ),
                    24. verticalSpace,
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

