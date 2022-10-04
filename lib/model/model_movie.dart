import 'package:cloud_firestore/cloud_firestore.dart';

class Movie {
  final String title;
  final String keyword;
  final String poster;
  final bool like;
  final DocumentReference reference; //해당 데이터 컬럼 참조할 수있는 링크 ->CRUD 쉽게 가능하도록함

  Movie.fromMap(Map<String, dynamic> map, {required this.reference}) //Map<String, dynamic>
      : title = map['title'],
        keyword = map['keyword'],
        poster = map['poster'],
        like = map['like'];

  Movie.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data() as Map<String, dynamic>, reference: snapshot.reference); //as Map<String, dynamic>
 
  @override
  String toString() => 'Movie<$title:$keyword>';
}



/* 파이어베이스 연동전
class Movie {
  final String title;
  final String keyword;
  final String poster;
  final bool like;

  Movie.fromMap(Map<String, dynamic> map)
      : title = map['title'],
        keyword = map['keyword'],
        poster = map['poster'],
        like = map['like'];

  @override
  String toString() => 'Movie<$title:$keyword>';
}*/
