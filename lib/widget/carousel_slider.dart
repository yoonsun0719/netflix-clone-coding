import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:netflix_clone_app/screen/detail_screen.dart';

import '../model/model_movie.dart';

class CarouselImage extends StatefulWidget {
  final List<Movie> movies;
  CarouselImage({required this.movies});

  _CarouselImageState createState() => _CarouselImageState();
}

class _CarouselImageState extends State<CarouselImage>{
  late List<Movie> movies;
  //late List<String> title;
  late List<Widget> images;
  late List<String> keywords;
  late List<bool> likes;
  //어느위치에 있는지
  int _currentPage = 0;
  late String _currentKeyword; //커런트 페이지에 등록되어있는 키워드

 /* @override
  void initState() {
    super.initState();
    movies = widget.movies;
    images = movies.map((m) => Image.asset('./assets/${m.poster}')).cast<Widget>().toList();
    keywords = movies.map((m) => m.keyword).toList();
    likes = movies.map((m) => m.like).toList();
    _currentKeyword = keywords[0];
  }*/
  @override
  void initState() {
    super.initState();
    movies = widget.movies;
    //title = movies.map((m) => m.title).toString() as List<String>;
    images = movies.map((m) => Image.network(m.poster)).cast<Widget>().toList();
    keywords = movies.map((m) => m.keyword).toList();
    likes = movies.map((m) => m.like).toList();
    _currentKeyword = keywords[0];
  }

  @override
  Widget build (BuildContext context) {
    return Container(
      child: Column(children: [
        Container(
          padding: EdgeInsets.all(20),
        ),
        CarouselSlider(
          items: images,
          options: CarouselOptions(
            onPageChanged : (index, reason) { //버전 변경으로인해 reason 추가
              setState(() {
                _currentPage = index;
                _currentKeyword = keywords[_currentPage];
              });
            },
          ),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(0, 10, 0, 3),
          child: Text(
              _currentKeyword,
            style: TextStyle(fontSize: 11),
          ),
        ),
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                child: Column(
                  children: [
                    //찜하기 버튼 누른 여부에따라
                    likes[_currentPage]
                        ? IconButton(
                            icon: Icon(Icons.check),
                            onPressed: () {
                            //찜하기 기능 추가
                            setState(() {
                              likes[_currentPage] = !likes[_currentPage];
                              movies[_currentPage].reference?.update({'like' : likes[_currentPage]}); //updateData 2버전?????
                            });

                    }, )
                        : IconButton(icon: Icon(Icons.add), onPressed: () {
                      //찜하기 기능 추가
                      setState(() {
                        likes[_currentPage] = !likes[_currentPage];
                        movies[_currentPage].reference?.update({'like' : likes[_currentPage]}); //updateData 2버전
                      });

                    } ),
                    Text('내가 찜한 콘텐츠',
                    style: TextStyle(fontSize: 11),
                    )
                  ],
                ),
              ),
              //재생버튼
              Container(
                padding: EdgeInsets.only(right: 10),
                child: TextButton(
                  style: TextButton.styleFrom(backgroundColor: Colors.white),
                 onPressed: () {  },
                  child: Row(
                    children: [
                      Icon(Icons.play_arrow, color: Colors.black,),
                      Text('재생', style: TextStyle(color : Colors.black),),
                      Padding(padding: EdgeInsets.all(3),),
                    ],
                  )
                ),
              ),
              //목록(정보)버튼
              Container(padding: EdgeInsets.only(right: 10),
              child: Column(
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute<Null>(
                          fullscreenDialog: true,
                          builder: (BuildContext context) {
                            return DetailScreen(movie: movies[_currentPage],
                            );
                          }
                        ));
                      },
                      icon: Icon(Icons.info)
                  ),
                  Text( '정보', style: TextStyle(color: Colors.white),)
                ],
              ),
              )
            ],
          ),
        ),
        Container(
          child: Row(
            mainAxisAlignment:MainAxisAlignment.center,
            children: makeIndicator(likes, _currentPage),

          ),
        )
      ],),
    );
  }
}


List<Widget> makeIndicator(List list, int _currentPage) {
  List<Widget> results = [];//반환할 리스트
  for(var i = 0;  i<list.length; i++){
  results.add(Container(
    width: 8,
    height: 8,
    margin: EdgeInsets.symmetric(
      vertical: 10.0, horizontal: 2.0
    ),
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: _currentPage == i
        ? Color.fromRGBO(255, 255, 255, 0.9)
          : Color.fromRGBO(255, 255, 255, 0.4)
    ),
  ),
);
  }
  return results;
}