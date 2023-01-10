// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:myallin1/config/config.dart';
import 'package:myallin1/pages/components/each_crypto.dart';
import 'package:myallin1/pages/components/each_movie.dart';
import 'package:myallin1/pages/components/each_news.dart';
import 'package:myallin1/pages/components/movie_detail_bottom_sheet.dart';

import '../chatpage/chats.dart';
import '../components/crypto_detail_bottom_sheet.dart';
import '../components/rounded_search_input_box.dart';
import '../postspage/posts.dart';
import 'package:http/http.dart' as http;

class SearchPage extends StatefulWidget {
  const SearchPage({
    super.key,
    required this.currentUser,
    required this.searchFocusNode,
  });

  final Map currentUser;
  final dynamic searchFocusNode;

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List news = [];
  List movies = [];
  List cryptos = [];
  Map searchResults = {};
  int currentSearchPage = 0;
  List<Widget> eachNewsWidget = [];
  List<Widget> eachMovieWidget = [];
  List<Widget> eachCryptoWidget = [];
  bool newsLoading = true;
  bool moviesLoading = true;
  bool cryptoLoading = true;
  bool isSeries = false;
  bool isDaily = false;
  TextEditingController searchTextController = TextEditingController();
  String curSearchTerm = "";

  // News
  void getNews() async {
    // Get Headlines
    var url =
        "https://newsapi.org/v2/top-headlines?country=us&apiKey=158f7ed38d5e42aea76930d43ecca9c8";
    var uri = Uri.parse(url);
    var result = await http.get(uri);
    dynamic resultJSON = jsonDecode(result.body);
    news = resultJSON["articles"];

    // Update
    newsLoading = false;
    setState(() {});

    // Get Tech News
    url =
        "https://newsapi.org/v2/top-headlines?country=us&category=technology&apiKey=158f7ed38d5e42aea76930d43ecca9c8";
    uri = Uri.parse(url);
    result = await http.get(uri);
    resultJSON = jsonDecode(result.body);
    news.addAll(resultJSON["articles"]);

    // Update
    newsLoading = false;
    setState(() {});

    // Get Entertainment News
    url =
        "https://newsapi.org/v2/top-headlines?country=us&category=entertainment&apiKey=158f7ed38d5e42aea76930d43ecca9c8";
    uri = Uri.parse(url);
    result = await http.get(uri);
    resultJSON = jsonDecode(result.body);
    news.addAll(resultJSON["articles"]);

    // Update
    newsLoading = false;
    setState(() {});

    // Get Business News
    url =
        "https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=158f7ed38d5e42aea76930d43ecca9c8";
    uri = Uri.parse(url);
    result = await http.get(uri);
    resultJSON = jsonDecode(result.body);
    news.addAll(resultJSON["articles"]);

    // Update
    newsLoading = false;
    setState(() {});
  }

  void displayNews() async {
    for (var eachNews in news)
      eachNewsWidget.add(
        EachNews(
          newsObject: eachNews,
        ),
      );
    currentSearchPage = 1;
    setState(() {});
  }

  // Movies
  Future<void> getMovies() async {
    var type = isSeries == false ? "movie" : "tv";
    var time = isDaily == false ? "day" : "week";
    var url = "https://api.themoviedb.org/3/trending/" +
        type +
        "/" +
        time +
        "?api_key=38d6559cd7b9ccdd0dd57ccca36e49fb&page=1";
    var uri = Uri.parse(url);
    var result = await http.get(uri);
    dynamic resultJSON = jsonDecode(result.body);
    eachMovieWidget = [];
    movies = [];
    movies = resultJSON["results"];
    // moviesLoading = false;
    // setState(() {});
    // displayMovies();
  }

  void displayMovies() async {
    for (var eachMovie in movies)
      eachMovieWidget.add(
        GestureDetector(
          onTap: () {
            showMovieDetails(eachMovie);
          },
          child: EachMovie(
            movieObject: eachMovie,
          ),
        ),
      );
    Widget space = Container(
      height: 100.0,
    );
    eachMovieWidget.add(space);
    currentSearchPage = 2;
    moviesLoading = false;
    setState(() {});
  }

  void showMovieDetails(movieObject) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      anchorPoint: Offset(0, 0),
      constraints: BoxConstraints(
        minHeight: MediaQuery.of(context).size.height * 0.5,
        maxHeight: MediaQuery.of(context).size.height * 0.96,
      ),
      isScrollControlled: true,
      isDismissible: true,
      enableDrag: true,
      context: context,
      builder: (context) {
        return MovieDetailBottomSheet(
          movieObject: movieObject,
          isSeries: isSeries,
        );
      },
    );
  }

  // Crypto
  void getCrypto() async {
    var url = "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd";
    var uri = Uri.parse(url);
    var result = await http.get(uri);
    dynamic resultJSON = jsonDecode(result.body);
    cryptos = resultJSON;
    cryptoLoading = false;
  }

  void displayCrypto() async {
    for (var eachCrypto in cryptos)
      eachCryptoWidget.add(
        GestureDetector(
          onTap: () {
            showCryptoDetails(eachCrypto);
          },
          child: EachCrypto(
            cryptoObject: eachCrypto,
          ),
        ),
      );
    currentSearchPage = 3;
    setState(() {});
  }

  void showCryptoDetails(cryptoObject) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      anchorPoint: Offset(0, 0),
      constraints: BoxConstraints(
        // minHeight: MediaQuery.of(context).size.height * 0.7,
        maxHeight: MediaQuery.of(context).size.height * 0.9,
      ),
      isScrollControlled: true,
      isDismissible: true,
      enableDrag: true,
      context: context,
      builder: (context) {
        return CryptoDetailBottomSheet(
          cryptoObject: cryptoObject,
        );
      },
    );
  }

  // Search
  void search(String searchTerm) async {
    curSearchTerm = searchTerm;
    if (searchTerm != "" && searchTerm != " ") {
      var url = Config.baseUrl + "/search/" + searchTerm;
      var uri = Uri.parse(url);
      var result = await http.get(uri);
      dynamic resultJSON = jsonDecode(result.body);
      searchResults = resultJSON;
      print(searchResults);
      currentSearchPage = 0;
    }
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getNews();
    getMovies();
    getCrypto();
  }

  @override
  Widget build(BuildContext context) {
    List searchScreens = [
      // Sample
      Container(
        child: Column(
          children: [
            // Post Results
            curSearchTerm == "" || curSearchTerm == " "
                ? Column(
                    children: [
                      // Trending Results
                      Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: 4.0, vertical: 4.0),
                        padding: EdgeInsets.symmetric(vertical: 8.0),
                        decoration: BoxDecoration(
                          color: Colors.grey[900]!.withOpacity(0.4),
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15.0, vertical: 5.0),
                              child: Text(
                                "Trending",
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  clipBehavior: Clip.hardEdge,
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 4.0, vertical: 4.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10.0),
                                    ),
                                  ),
                                  child: Image.asset(
                                    "assets/images/me.jpg",
                                    width: 180.0,
                                  ),
                                ),
                                Container(
                                  clipBehavior: Clip.hardEdge,
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 4.0, vertical: 4.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10.0),
                                    ),
                                  ),
                                  child: Image.asset(
                                    "assets/images/me.jpg",
                                    width: 180.0,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      // Chat Results
                      Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: 4.0, vertical: 4.0),
                        padding: EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 5.0),
                        decoration: BoxDecoration(
                          color: Colors.grey[900]!.withOpacity(0.4),
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 15.0, vertical: 8.0),
                              child: Text(
                                "Accounts",
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Chats(
                              borderRadius: 20.0,
                              chatObject: {
                                "profilepic":
                                    "https://assets.entrepreneur.com/content/3x2/2000/20150224165308-jeff-bezos-amazon.jpeg",
                                "fullname": "Jeff Bezos",
                                "username": "jeffyman",
                              },
                            ),
                            Chats(
                              borderRadius: 20.0,
                              chatObject: {
                                "profilepic":
                                    "https://media.vanityfair.com/photos/5d41c7688df537000832361b/4:3/w_2668,h_2001,c_limit/GettyImages-945005812.jpg",
                                "fullname": "Mark Zuckerberg",
                                "username": "repitilian",
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                : searchResults["postResults"].length == 0 &&
                        searchResults["accountResults"].length == 0
                    ? Container(
                        padding: EdgeInsets.only(top: 50.0),
                        child: Text(
                          "No Results Found",
                          style: TextStyle(
                            color: Colors.grey[500]!,
                          ),
                        ),
                      )
                    : Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: 4.0, vertical: 4.0),
                        padding: EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 5.0),
                        decoration: BoxDecoration(
                          color: Colors.grey[900]!.withOpacity(0.4),
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                        ),
                        child: Column(
                          children: [
                            searchResults["postResults"].length > 0
                                ? Container(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 15.0, vertical: 8.0),
                                          child: Text(
                                            "Posts",
                                            style: TextStyle(
                                              fontSize: 20.0,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        for (var eachPostResult
                                            in searchResults["postResults"])
                                          Posts(
                                            post: eachPostResult,
                                            currentUser: widget.currentUser,
                                          ),
                                      ],
                                    ),
                                  )
                                : Container(),
                            searchResults["accountResults"].length > 0
                                ? Container(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 15.0, vertical: 8.0),
                                          child: Text(
                                            "Accounts",
                                            style: TextStyle(
                                              fontSize: 20.0,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        for (var eachAccountResult
                                            in searchResults["accountResults"])
                                          Chats(
                                            borderRadius: 20.0,
                                            chatObject: eachAccountResult,
                                          ),
                                      ],
                                    ),
                                  )
                                : Container(),
                          ],
                        ),
                      ),
            SizedBox(height: 300.0),
          ],
        ),
      ),
      // News
      newsLoading
          ? Container(
              width: double.infinity,
              height: 200.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(
                    color: Colors.grey,
                  ),
                  SizedBox(height: 15.0),
                  Text(
                    "Getting Headlines",
                    style: TextStyle(
                      color: Colors.grey[700],
                    ),
                  ),
                ],
              ),
            )
          : Column(
              children: [
                for (var eachNews in eachNewsWidget) eachNews,
                SizedBox(height: 200.0),
              ],
            ),
      // Movies
      moviesLoading
          ? Container(
              width: double.infinity,
              height: 200.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(
                    color: Colors.grey,
                  ),
                  SizedBox(height: 15.0),
                  Text(
                    "Getting Movies",
                    style: TextStyle(
                      color: Colors.grey[700],
                    ),
                  ),
                ],
              ),
            )
          : Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Movie or Series
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(width: 20.0),
                        Text(
                          "Movies",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        Switch(
                          value: isSeries,
                          onChanged: (value) async {
                            isSeries = value;
                            moviesLoading = true;
                            setState(() {});
                            await getMovies();
                            displayMovies();
                          },
                          activeColor: Colors.red,
                          trackColor:
                              MaterialStateProperty.all(Colors.grey[700]),
                          thumbColor: MaterialStateProperty.all(Colors.yellow),
                        ),
                        Text(
                          "Series",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    // Daily Weekly
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Daily",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        Switch(
                          value: isDaily,
                          onChanged: (value) async {
                            isDaily = value;
                            moviesLoading = true;
                            setState(() {});
                            await getMovies();
                            displayMovies();
                          },
                          activeColor: Colors.red,
                          trackColor:
                              MaterialStateProperty.all(Colors.grey[700]),
                          thumbColor: MaterialStateProperty.all(Colors.cyan),
                        ),
                        Text(
                          "Weekly",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(width: 20.0),
                      ],
                    ),
                  ],
                ),
                Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.8,
                  child: GridView.count(
                    primary: true,
                    shrinkWrap: true,
                    crossAxisCount: 2,
                    childAspectRatio: 0.7,
                    children: eachMovieWidget,
                  ),
                ),
              ],
            ),
      // Cryto
      cryptoLoading
          ? Container(
              width: double.infinity,
              height: 200.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(
                    color: Colors.grey,
                  ),
                  SizedBox(height: 15.0),
                  Text(
                    "Fetching Crypto",
                    style: TextStyle(
                      color: Colors.grey[700],
                    ),
                  ),
                ],
              ),
            )
          : Column(
              children: [
                for (var eachCrypto in eachCryptoWidget) eachCrypto,
                SizedBox(height: 200.0),
              ],
            ),
    ];
    return ListView(
      children: [
        RoundedSearchInputBox(
          textEditingController: searchTextController,
          onChangedFunction: search,
          focusNode: widget.searchFocusNode,
        ),

        // Search Pages
        Container(
          margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 0.0),
          padding: EdgeInsets.symmetric(vertical: 1.0),
          decoration: BoxDecoration(
            // color: Colors.grey[900]!.withOpacity(0.4),
            // border: Border.all(
            //   color: Colors.grey[900]!,
            // ),
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () {
                  displayNews();
                },
                child: Container(
                  width: 120.0,
                  padding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                  decoration: BoxDecoration(
                    color: currentSearchPage == 1
                        ? Colors.lightBlue
                        : Colors.grey[900],
                    // border: Border.all(
                    //   color: Colors.lightBlue.withOpacity(0.4),
                    // ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(20.0),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Ionicons.newspaper_outline,
                        size: 18.0,
                        color: currentSearchPage == 1
                            ? Colors.black
                            : Colors.white,
                      ),
                      SizedBox(width: 8.0),
                      Text(
                        "News",
                        style: TextStyle(
                          color: currentSearchPage == 1
                              ? Colors.black
                              : Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  displayMovies();
                },
                child: Container(
                  width: 120.0,
                  padding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                  decoration: BoxDecoration(
                    color: currentSearchPage == 2
                        ? Colors.amberAccent
                        : Colors.grey[900],
                    // border: Border.all(
                    //   color: Colors.amberAccent.withOpacity(0.4),
                    // ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(20.0),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Ionicons.film_outline,
                        size: 18.0,
                        color: currentSearchPage == 2
                            ? Colors.black
                            : Colors.white,
                      ),
                      SizedBox(width: 8.0),
                      Text(
                        "Movies",
                        style: TextStyle(
                          color: currentSearchPage == 2
                              ? Colors.black
                              : Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  displayCrypto();
                },
                child: Container(
                  width: 120.0,
                  padding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                  decoration: BoxDecoration(
                    color: currentSearchPage == 3
                        ? Colors.greenAccent
                        : Colors.grey[900],
                    // border: Border.all(
                    //   color: Colors.greenAccent.withOpacity(0.4),
                    // ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(20.0),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Ionicons.cash_outline,
                        size: 18.0,
                        color: currentSearchPage == 3
                            ? Colors.black
                            : Colors.white,
                      ),
                      SizedBox(width: 8.0),
                      Text(
                        "Crypto",
                        style: TextStyle(
                          color: currentSearchPage == 3
                              ? Colors.black
                              : Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // ElevatedButton(
              //   style: ButtonStyle(
              //     fixedSize: MaterialStateProperty.all(
              //       Size(120.0, 40.0),
              //     ),
              //     backgroundColor: MaterialStateProperty.all(
              //       currentSearchPage == 1
              //           ? Colors.lightBlue
              //           : Colors.grey[900],
              //     ),
              //   ),
              //   onPressed: () {
              //     displayNews();
              //   },
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //     children: [
              //       Icon(
              //         Ionicons.newspaper_outline,
              //         size: 18.0,
              //         color:
              //             currentSearchPage == 1 ? Colors.black : Colors.white,
              //       ),
              //       Text(
              //         "News",
              //         style: TextStyle(
              //           color: currentSearchPage == 1
              //               ? Colors.black
              //               : Colors.white,
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              //   ElevatedButton(
              //     style: ButtonStyle(
              //       fixedSize: MaterialStateProperty.all(
              //         Size(120.0, 40.0),
              //       ),
              //       backgroundColor: MaterialStateProperty.all(
              //         currentSearchPage == 2
              //             ? Colors.amberAccent
              //             : Colors.grey[900],
              //       ),
              //     ),
              //     onPressed: () {
              //       displayMovies();
              //     },
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //       children: [
              //         Icon(
              //           Ionicons.film_outline,
              //           size: 18.0,
              //           color:
              //               currentSearchPage == 2 ? Colors.black : Colors.white,
              //         ),
              //         Text(
              //           "Movies",
              //           style: TextStyle(
              //             color: currentSearchPage == 2
              //                 ? Colors.black
              //                 : Colors.white,
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
              //   ElevatedButton(
              //     style: ButtonStyle(
              //       fixedSize: MaterialStateProperty.all(
              //         Size(120.0, 40.0),
              //       ),
              //       backgroundColor: MaterialStateProperty.all(
              //         currentSearchPage == 3
              //             ? Colors.greenAccent
              //             : Colors.grey[900],
              //       ),
              //     ),
              //     onPressed: () {
              //       displayCrypto();
              //     },
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //       children: [
              //         Icon(
              //           Ionicons.cash_outline,
              //           size: 18.0,
              //           color:
              //               currentSearchPage == 3 ? Colors.black : Colors.white,
              //         ),
              //         Text(
              //           "Crypto",
              //           style: TextStyle(
              //             color: currentSearchPage == 3
              //                 ? Colors.black
              //                 : Colors.white,
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
            ],
          ),
        ),

        SizedBox(height: 10.0),

        // Search Results
        searchScreens[currentSearchPage],

        // End of Page
        // SizedBox(height: 200.0),
      ],
    );
  }
}
