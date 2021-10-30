import 'package:imagine_apps/data/models/post_model.dart';
import 'package:imagine_apps/data/models/story_model.dart';
import 'package:imagine_apps/data/services/data_firebase.dart';

abstract class DataRepository {
  //OBTENER POSTS
  Future<List<PostModel>> getPost();

  //PUBLICAR POST
  Future<bool> createPost(String text);

  //EDITAR POST
  Future<void> updatePost(String id, String text);

  //BORRAR POST
  Future<void> deletePost(String id);

  //OBTENER HISTORIAS
  Future<List<StoryModel>> getStories();
}

class DataImplementation implements DataRepository {
  final DataFirebase dataFirebase;

  DataImplementation(this.dataFirebase);

  @override
  Future<bool> createPost(String text) {
    return dataFirebase.createPost(text);
  }

  @override
  Future<void> deletePost(String id) {
    return dataFirebase.deletePost(id);
  }

  @override
  Future<List<PostModel>> getPost() {
    return dataFirebase.getPost();
  }

  @override
  Future<void> updatePost(String id, String text) {
    return dataFirebase.updatePost(id: id, text: text);
  }

  @override
  Future<List<StoryModel>> getStories() {
    return dataFirebase.getStories();
  }
}
