import 'package:cloud_firestore/cloud_firestore.dart';

//Modelo para extraer la información de una historia
class StoryModel {
  final String img, author;
  final bool myStory;

  StoryModel({required this.img, required this.myStory, required this.author});

  factory StoryModel.fromSnapshot(DocumentSnapshot doc) {
    return StoryModel(
        myStory: doc['email'] == 'test.com' ? true : false,
        img: doc['img'],
        author: doc['author']);
  }
}
