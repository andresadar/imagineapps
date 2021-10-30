import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:imagine_apps/data/models/post_model.dart';
import 'package:imagine_apps/data/models/story_model.dart';

class DataFirebase {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  //OBTENER LOS POST
  Future<List<PostModel>> getPost() async {
    List<PostModel> post = [];

    try {
      await _db
          .collection('Post')
          .orderBy('createAt', descending: true)
          .get()
          .then(
            (value) => post.addAll(
              value.docs.map(
                (e) => PostModel.fromSnapshot(e),
              ),
            ),
          );
      return post;
    } catch (e) {
      print('$e');
      return post;
    }
  }

  //PUBLICAR UN POST
  Future<bool> createPost(String text) async {
    try {
      await _db.collection('Post').doc().set({
        'author': 'Andres Arenas R.',
        'createAt': FieldValue.serverTimestamp(),
        'description': text,
        'email': 'test.com',
        'edit': false,
        'imageProfile':
            'https://www.colfecarga.com/taxi/assets/pages/media/profile/profile_user.jpg',
        'img': 'null',
        'likes': 0,
        'profession': 'Desarrollado de Aplicaciones Flutter / Android'
      });
      return true;
    } catch (e) {
      print('$e');
      return false;
    }
  }

  //EDITAR UN POST
  Future<void> updatePost({required String id, required String text}) async {
    try {
      await _db
          .collection('Post')
          .doc(id)
          .update({'description': text, 'edit': true});
    } catch (e) {
      print('$e');
    }
  }

  //ELIMINAR UN POST
  Future<void> deletePost(String id) async {
    try {
      await _db.collection('Post').doc(id).delete();
    } catch (e) {
      print('$e');
    }
  }

  //OBTENER HISTORIAS
  Future<List<StoryModel>> getStories() async {
    List<StoryModel> stories = [];

    try {
      await _db.collection('Stories').get().then(
            (value) => stories.addAll(
              value.docs.map(
                (e) => StoryModel.fromSnapshot(e),
              ),
            ),
          );

      stories.sort((a, b) {
        if (b.myStory) {
          return 1;
        }
        return -1;
      });

      return stories;
    } catch (e) {
      print('$e');
      return stories;
    }
  }
}
