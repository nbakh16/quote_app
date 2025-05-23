import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quote_app/features/home/data/quote_model.dart';
part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(QuoteInitial());

  List<QuoteModel> quotes = [];
  String userEmail = FirebaseAuth.instance.currentUser?.email ?? '';

  Future<void> getQuotes() async {
    emit(Loading());

    FirebaseFirestore db = FirebaseFirestore.instance;

    try {
      QuerySnapshot querySnapshot = await db
          .collection('Quotes')
          .orderBy('createdAt', descending: true)
          .get();

      quotes.clear();

      for (var doc in querySnapshot.docs) {
        quotes.add(
            QuoteModel.fromMap(doc.data() as Map<String, dynamic>, doc.id));
      }

      emit(QuotesLoaded(quotes));
    } catch (e) {
      emit(Error(e.toString()));
    }
  }

  addQuote({required String text, required String author}) async {
    emit(Loading());
    FirebaseFirestore db = FirebaseFirestore.instance;

    try {
      User? currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser == null) {
        emit(Error('User not logged in. Please log in to post a quote.'));
        return;
      }

      QuoteModel newQuote = QuoteModel(
        quote: text,
        author: author,
        addedBy: currentUser.email ?? 'N/A',
      );

      await db
          .collection('Quotes')
          .doc(DateTime.now().toString())
          .set(newQuote.toMap());

      quotes.add(newQuote);

      emit(QuoteCreated());
    } catch (e) {
      emit(Error(e.toString()));
    }
  }

  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
    emit(Logout());
  }
}
