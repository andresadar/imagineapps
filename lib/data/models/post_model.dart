import 'package:cloud_firestore/cloud_firestore.dart';

//Modelo para extraer la información de un post
class PostModel {
  final String id, imageProfile, author, profession, description, email;
  final String? img;
  final Timestamp createAt;
  final bool myPost, edit;
  final int likes;

  PostModel(
      {required this.id,
      required this.imageProfile,
      required this.author,
      required this.profession,
      required this.description,
      required this.img,
      required this.email,
      required this.myPost,
      required this.edit,
      required this.likes,
      required this.createAt});

  factory PostModel.fromSnapshot(DocumentSnapshot doc) {
    return PostModel(
        id: doc.id,
        imageProfile: doc['imageProfile'],
        author: doc['author'],
        profession: doc['profession'],
        description: doc['description'],
        img: doc['img'] == 'null' ? null : doc['img'],
        email: doc['email'],
        likes: doc['likes'],
        edit: doc['edit'],
        myPost: doc['email'] == 'test.com' ? true : false,
        createAt: doc['createAt']);
  }
}
