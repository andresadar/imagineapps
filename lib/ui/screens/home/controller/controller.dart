import 'package:flutter/material.dart';

import 'package:imagine_apps/data/models/post_model.dart';
import 'package:imagine_apps/data/models/story_model.dart';
import 'package:imagine_apps/data/services/data_firebase.dart';
import 'package:imagine_apps/domain/repository.dart';

class HomeController extends ChangeNotifier {
  //Metodos CRUD para POST
  final DataRepository _repository = DataImplementation(DataFirebase());

  //GET
  Future<List<PostModel>> getPost() {
    return _repository.getPost();
  }

  //POST
  Future<bool> createPost(String text) {
    return _repository.createPost(text);
  }

  //UPDATE
  Future<void> updatePost(String id, String text) {
    return _repository.updatePost(id, text).whenComplete(() {
      notifyListeners();
    });
  }

  //DELETE
  Future<void> deletePost(String id) {
    return _repository.deletePost(id).whenComplete(() {
      notifyListeners();
    });
  }

  //Obtener Historias
  Future<List<StoryModel>> getStories() {
    return _repository.getStories();
  }

  //refresh
  void refresh() {
    notifyListeners();
  }
}
