import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quote_app/features/home/cubit/cubit/home_cubit.dart';
import 'package:quote_app/widgets/custom_textfield.dart';
import 'package:quote_app/widgets/loading_dialog.dart';
import 'package:quote_app/widgets/my_snackbar.dart';

class CreateQuote extends StatelessWidget {
  static const routeName = 'create-quote';
  const CreateQuote({super.key});

  @override
  Widget build(BuildContext context) {
    final quoteTEC = TextEditingController();
    final authorTEC = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text('Create Quote'),
        backgroundColor: Colors.purple,
        foregroundColor: Colors.white,
      ),
      floatingActionButton: ElevatedButton(
        onPressed: () {
          String quote = quoteTEC.text.trim();
          String author = authorTEC.text.trim();

          if (quote.isEmpty || author.isEmpty) {
            mySnackBar(context, message: 'Quote & Author required');
            return;
          }

          context.read<HomeCubit>().addQuote(
                text: quote,
                author: author,
              );
        },
        child: Text('Add Quote'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: BlocListener<HomeCubit, HomeState>(
        listener: (context, state) {
          if (state is Loading) {
            LoadingDialog.show(context);
          } else {
            LoadingDialog.hide(context);
          }

          if (state is QuoteCreated) {
            quoteTEC.clear();
            authorTEC.clear();
            mySnackBar(context,
                message: 'Quote Created Successfully',
                bgColor: Colors.lightGreen);
          }

          if (state is Error) {
            mySnackBar(context, message: state.message);
          }
        },
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            spacing: 12,
            children: [
              CustomTextField(
                controller: quoteTEC,
                hintText: 'Write full quote...',
                extraLabel: 'Quote',
                keyboardType: TextInputType.text,
                maxLines: 6,
              ),
              CustomTextField(
                controller: authorTEC,
                hintText: 'Who said the quote?',
                extraLabel: 'Author',
                keyboardType: TextInputType.text,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
