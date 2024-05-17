import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:jbicv2/src/data_source/firebase_data_source.dart';
import 'package:jbicv2/src/repository/implementation/auth_repository.dart';
import 'package:jbicv2/src/app.dart';
import 'firebase_options.dart';


final getIt = GetIt.instance;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "XXX",
      appId: "XXX",
      messagingSenderId: "XXX",
      projectId: "XXX",
    ),
  );

  await injectDependencies();

  runApp(ProviderScope(child: MyApp()));
}

Future<void> injectDependencies() async{
  getIt.registerLazySingleton(() => FirebaseDataSource());
  getIt.registerLazySingleton(() => AuthRepositoryImp());

}