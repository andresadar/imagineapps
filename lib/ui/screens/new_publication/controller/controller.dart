import 'package:flutter/material.dart';
import 'package:imagine_apps/data/services/data_firebase.dart';
import 'package:imagine_apps/domain/repository.dart';

class PostController extends ChangeNotifier {
  final FocusNode inputFocus = FocusNode();
  final TextEditingController textController = TextEditingController();

  //loading LinearProgressIndicator
  bool loadingPost = false;

  final DataRepository _repository = DataImplementation(DataFirebase());

  //CREATE POST
  Future<bool> createPost(String text) async {
    loadingPost = true;
    notifyListeners();
    await Future.delayed(const Duration(seconds: 1));
    return _repository.createPost(text).whenComplete(
      () async {
        await Future.delayed(const Duration(seconds: 1));
        loadingPost = false;
        notifyListeners();
      },
    );
  }
}
