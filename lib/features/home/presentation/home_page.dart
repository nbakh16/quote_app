import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:quote_app/features/auth/presentation/auth_page.dart';
import 'package:quote_app/features/home/cubit/cubit/home_cubit.dart';
import 'package:quote_app/features/home/data/quote_model.dart';
import 'package:quote_app/features/home/presentation/create_quote.dart';
import 'package:quote_app/widgets/app_error.dart';
import 'package:quote_app/widgets/not_available.dart';

class HomePage extends StatefulWidget {
  static const routeName = 'home';
  final String userEmail;
  const HomePage({super.key, required this.userEmail});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    context.read<HomeCubit>().getQuotes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<HomeCubit>();

    return Scaffold(
      appBar: _buildAppBar(context),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.pushNamed(CreateQuote.routeName);
        },
        child: Icon(Icons.add),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          cubit.getQuotes();
        },
        child: Center(
          child: BlocConsumer<HomeCubit, HomeState>(
            listener: (context, state) {
              if (state is Logout) {
                context.goNamed(AuthPage.routeName);
              }
            },
            builder: (context, state) {
              if (state is Loading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state is Error) {
                return AppError(
                  onTap: () => cubit.getQuotes(),
                  message: state.message,
                );
              }

              final List<QuoteModel> data = cubit.quotes;

              if (data.isEmpty) {
                return const NotAvailable();
              }

              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: ListView.separated(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    bool quoteOwner = data[index].addedBy == cubit.userEmail;

                    return InkWell(
                      onTap: () {
                        quoteDialog(context, quote: data[index]);
                      },
                      child: Card(
                        child: ListTile(
                          title: Text(data[index].quote),
                          subtitle: Text(data[index].author),
                          trailing: quoteOwner
                              ? Icon(
                                  Icons.edit,
                                  size: 14,
                                  color: Colors.purple,
                                )
                              : null,
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (_, __) => SizedBox(height: 8),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Future<dynamic> quoteDialog(BuildContext context,
      {required QuoteModel quote}) {
    return showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            content: Column(
              spacing: 6,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(quote.quote, style: TextStyle(fontSize: 18), maxLines: 10),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    '—${quote.author}',
                    style: TextStyle(fontSize: 14),
                  ),
                ),
                SizedBox(height: 12),
                Text('Added by: ${quote.addedBy}',
                    style: TextStyle(fontSize: 12, color: Colors.black54),
                    maxLines: 10),
                SizedBox(height: 12),
                TextButton(onPressed: context.pop, child: Text('Okay'))
              ],
            ),
          );
        });
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Quote App',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            widget.userEmail,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.normal,
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          onPressed: () {
            context.read<HomeCubit>().logout();
          },
          icon: Icon(
            Icons.logout,
          ),
        ),
      ],
      backgroundColor: Colors.purple,
      foregroundColor: Colors.white,
    );
  }
}
