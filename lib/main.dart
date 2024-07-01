import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:jbicv2/src/app.dart';
import 'package:jbicv2/src/data_source/firebase_data_source.dart';
import 'package:jbicv2/src/repository/auth_repository.dart';
import 'package:jbicv2/src/repository/book_list_book.repository.dart';
import 'package:jbicv2/src/repository/book_repository.dart';
import 'package:jbicv2/src/repository/book_user_repository.dart';
import 'package:jbicv2/src/repository/implementation/auth_repository.dart';
import 'package:jbicv2/src/repository/implementation/book_list_book_repository.dart';
import 'package:jbicv2/src/repository/implementation/book_repository.dart';
import 'package:jbicv2/src/repository/implementation/book_user_repository.dart';
import 'package:jbicv2/src/repository/implementation/review_repository.dart';
import 'package:jbicv2/src/repository/implementation/user_book_list_repositry.dart';
import 'package:jbicv2/src/repository/review_repository.dart';
import 'package:jbicv2/src/repository/user_book_list_repository.dart';
import 'firebase_options.dart';

final getIt = GetIt.instance;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if(kIsWeb){
    await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  }
  else{
await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
    name: 'jbiv',
  );
  }
  

  // // Point Firebase Auth to the local emulator
  //FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
  //FirebaseDatabase.instance.useDatabaseEmulator('localhost', 9000);
  

  await injectDependencies();
  runApp(ProviderScope(child: MyApp()));
}

Future<void> injectDependencies() async {
  getIt.registerLazySingleton(() => FirebaseDataSource());
  getIt.registerLazySingleton<AuthRepository>(() => AuthRepositoryImp());
  getIt.registerLazySingleton<BookRepository>(() => BookRepositoryImp());
  getIt
      .registerLazySingleton<BookUserRepository>(() => BookUserRepositoryImp());
  getIt.registerLazySingleton<UserBookListRepository>(
      () => UserBookListRepositoryImp());
  getIt.registerLazySingleton<ReviewRepository>(() => ReviewRepositoryImp());
  getIt.registerLazySingleton<BookListBookRepository>(() => BookListBookRepositoryImp());
}
