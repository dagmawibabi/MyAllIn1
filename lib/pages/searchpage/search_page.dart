// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:myallin1/config/config.dart';
import 'package:myallin1/pages/APOTDpage/aPOTD_page.dart';
import 'package:myallin1/pages/bookDetailPage/book_detail_page.dart';
import 'package:myallin1/pages/components/each_subreddit_post.dart';
import 'package:myallin1/pages/searchpage/search_categories_bottom_sheet.dart';
import 'package:myallin1/pages/components/eachBook.dart';
import 'package:myallin1/pages/components/each_APOTD.dart';
import 'package:myallin1/pages/components/each_crypto.dart';
import 'package:myallin1/pages/components/each_movie.dart';
import 'package:myallin1/pages/components/each_news.dart';
import 'package:myallin1/pages/components/icon_pill_button.dart';
import 'package:myallin1/pages/components/movie_detail_bottom_sheet.dart';
import 'package:myallin1/pages/components/rounded_icon_labeled_button.dart';
import 'package:myallin1/pages/cryptoDetailPage/crypto_detail_page.dart';
import 'package:myallin1/pages/movieDetailPage/movie_detail_page.dart';
import 'package:myallin1/pages/searchpage/sort_subreddit_posts_bottom_sheet.dart';

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
  List aPOTDs = [];
  List subRedditPosts = [];
  Map aPOTDToday = {};
  List books = [];
  dynamic aPOTDWeek = [];

  Map searchResults = {};
  int currentSearchPage = 0;
  List<Widget> eachNewsWidget = [];
  List<Widget> eachMovieWidget = [];
  List<Widget> eachCryptoWidget = [];
  List<Widget> eachBookWidget = [];
  List<Widget> subRedditPostsWidget = [];

  bool newsLoading = true;
  bool moviesLoading = true;
  bool cryptoLoading = true;
  bool aPOTDLoading = true;
  bool booksLoading = true;
  bool redditLoading = true;

  bool isSeries = false;
  bool isDaily = false;
  TextEditingController searchTextController = TextEditingController();
  String curSearchTerm = "";
  List subredditList = [
    "wholesomeMemes",
    "pics",
    "meme",
    "whitePeopleTwitter",
    "funny",
    "damnThatsInteresting",
    "cats",
    "dataIsBeautiful",
    "comics",
    "madeMeSmile",
    "sketchPad",
    "illustration",
    "artProgressPics",
    "pixelArt",
    "logoDesign",
    "typography",
    "humansForScale",
    "imaginaryCharacters",
    "imaginaryCityscapes",
    "imaginaryCyberpunk",
    "art",
    "artefactPorn",
    "quotesPorn",
    "aww",
    "movies",
    "earthPorn",
    "food",
    "mildlyInteresting",
    "space",
    "campingAndHiking",
    "100YearsAgo",
    "awwducational",
    "cozyPlaces",
    "programmingHumor",
    "getMotivated",
    "nostalgia",
    "designPorn",
    "cringePics",
    "creepy",
    "historyPorn",
    "verticalWallpapers",
    "militaryPorn",
    "skyPorn",
    "abandonedPorn",
    "noTitle",
    "iTookAPicture",
    "roomPorn",
    "me_IRL"
  ];

  // News
  Future<void> getNews() async {
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
    print(url);
    var uri = Uri.parse(url);
    var result = await http.get(uri);
    dynamic resultJSON = jsonDecode(result.body);
    eachMovieWidget = [];
    movies = [];
    movies = resultJSON["results"];
    moviesLoading = false;
    // setState(() {});
    // displayMovies();
  }

  void displayMovies() async {
    for (var eachMovie in movies)
      eachMovieWidget.add(
        GestureDetector(
          onTap: () {
            // showMovieDetails(eachMovie);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MovieDetailPage(
                  movieObject: eachMovie,
                  isSeries: isSeries,
                ),
              ),
            );
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
  Future<void> getCrypto() async {
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
            // showCryptoDetails(eachCrypto);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CryptoDetailPage(
                  cryptoObject: eachCrypto,
                ),
              ),
            );
          },
          child: EachCrypto(
            cryptoObject: eachCrypto,
          ),
        ),
      );
    currentSearchPage = 4;
    setState(() {});
  }

  void showCryptoDetails(cryptoObject) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      // barrierColor: Colors.black,
      anchorPoint: Offset(0, 0),
      constraints: BoxConstraints(
        // minHeight: MediaQuery.of(context).size.height * 0.7,
        maxHeight: MediaQuery.of(context).size.height * 0.8,
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

  // Space
  Future<void> getAPOTD() async {
    // Today APOTDs
    var url =
        "https://api.nasa.gov/planetary/apod?api_key=" + Config.aPOTDAPIKey;

    var uri = Uri.parse(url);
    var result = await http.get(uri);
    dynamic resultJSON = jsonDecode(result.body);
    aPOTDToday = resultJSON;

    // This Week
    dynamic startDate =
        DateTime.now().subtract(Duration(days: 7)).toString().substring(0, 10);
    url = "https://api.nasa.gov/planetary/apod?api_key=" +
        Config.aPOTDAPIKey +
        "&start_date=" +
        startDate;
    uri = Uri.parse(url);
    result = await http.get(uri);
    resultJSON = jsonDecode(result.body);
    aPOTDWeek = resultJSON;

    // Random APOTDs
    url = "https://api.nasa.gov/planetary/apod?api_key=" +
        Config.aPOTDAPIKey +
        "&count=10";
    uri = Uri.parse(url);
    result = await http.get(uri);
    resultJSON = jsonDecode(result.body);
    aPOTDs = resultJSON;

    aPOTDLoading = false;
  }

  void displayAPOTD() async {
    for (var eachCrypto in cryptos)
      eachCryptoWidget.add(
        GestureDetector(
          onTap: () {
            // showCryptoDetails(eachCrypto);
          },
          child: EachCrypto(
            cryptoObject: eachCrypto,
          ),
        ),
      );
    currentSearchPage = 3;
    setState(() {});
  }

  // Books
  Future<void> getBooks(curSearchTerm) async {
    booksLoading = true;
    setState(() {});
    var curSearchedBook = "";
    if (curSearchTerm == "" || curSearchTerm == " " || curSearchTerm == null) {
      curSearchedBook = "harry+potter";
    } else {
      curSearchedBook = curSearchTerm.toString().trim();
    }
    var url =
        "https://www.googleapis.com/books/v1/volumes?q=${curSearchedBook}";
    var uri = Uri.parse(url);
    var result = await http.get(uri);
    dynamic resultJSON = jsonDecode(result.body);
    // books = [];
    books = resultJSON["items"] ?? [];
    eachBookWidget = [];
    booksLoading = false;
  }

  void displayBooks() {
    for (var eachBook in books)
      eachBookWidget.add(
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BookDetailPage(
                  bookObject: eachBook,
                ),
              ),
            );
          },
          child: EachBook(
            bookObject: eachBook,
          ),
        ),
      );
    currentSearchPage = 5;
    setState(() {});
  }

  // Reddit
  String chosenSubreddit = "";
  int subRedditSortTime = 1;
  int subRedditSortListing = 1;
  Future<void> getSubreddit(String subreddit) async {
    chosenSubreddit = subreddit;
    // https://www.reddit.com/r/askscience/top/.json?sort=top
    // https://www.reddit.com/r/todayilearned/top.json?limit=10
    /*
      timeframe = 'month' # hour, day, week, month, year, all
      listing = 'top' # controversial, best, hot, new, random, rising, top
      https://www.reddit.com/r/{subreddit}/{listing}.json?limit={limit}&t={timeframe} 
    */
    var timeFrame = ["hour", "day", "week", "month", "year", "all"];
    var chosenTime = timeFrame[subRedditSortTime];
    var listings = ["new", "hot", "rising", "best", "random", "top"];
    var chosenListing = listings[subRedditSortListing];

    var url = "https://www.reddit.com/r/" +
        subreddit +
        "/" +
        chosenListing +
        ".json?t=" +
        chosenTime +
        "&limit=100";
    debugPrint("abcbbcbcbcbcbcbcbbccbc");
    print(chosenTime);
    print(chosenListing);
    debugPrint("abcbbcbcbcbcbcbcbbccbc");
    var uri = Uri.parse(url);
    var result = await http.get(uri);
    dynamic resultJSON = jsonDecode(result.body);
    subRedditPosts = resultJSON["data"]["children"];
    redditLoading = false;
  }

  void sortRedditPosts(int time, int listing) async {
    subRedditSortTime = time;
    subRedditSortListing = listing;
    await getSubreddit(chosenSubreddit);
    displaySubreddit();
  }

  void displaySubreddit() {
    subRedditPostsWidget = [];
    for (var eachSubredditPost in subRedditPosts)
      subRedditPostsWidget.add(
        GestureDetector(
          onTap: () {
            // showCryptoDetails(eachCrypto);
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => Text(eachSubredditPost),
            //   ),
            // );
          },
          child: EachSubredditPost(
            subredditPost: eachSubredditPost["data"],
          ),
        ),
      );
    currentSearchPage = 8;
    setState(() {});
  }

  void sortSubredditPostsBottomSheet() {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      anchorPoint: Offset(0, 0),
      constraints: BoxConstraints(
        // minHeight: MediaQuery.of(context).size.height * 0.7,
        maxHeight: MediaQuery.of(context).size.height * 0.5,
      ),
      isScrollControlled: true,
      isDismissible: true,
      enableDrag: true,
      context: context,
      builder: (context) {
        return SortSubredditBottomSheet(
          sortRedditPosts: sortRedditPosts,
        );
      },
    );
  }

  //!
  // Choose Search Categories
  void setChosenCategories(List chosenCategories) {
    chosenSearchCategories = chosenCategories;
    setState(() {});
  }

  // Search Categories
  List chosenSearchCategories = [
    "Books",
    "Crypto",
    "Github",
    "Memes",
    "Movies",
    "News",
    "Reddit",
    "Space",
    "Wikis",
  ];

  // Search Categories
  void searchCategories() {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      anchorPoint: Offset(0, 0),
      constraints: BoxConstraints(
        // minHeight: MediaQuery.of(context).size.height * 0.7,
        maxHeight: MediaQuery.of(context).size.height * 0.5,
      ),
      isScrollControlled: true,
      isDismissible: true,
      enableDrag: true,
      context: context,
      builder: (context) {
        return SearchCategoriesBottomSheet(
          setChosenCategories: setChosenCategories,
          chosenSearchCategories: chosenSearchCategories,
        );
      },
    );
  }

  // Search
  void search(String searchTerm) async {
    curSearchTerm = searchTerm;
    if (currentSearchPage == 5) {
      await getBooks(curSearchTerm);
      displayBooks();
    } else if (currentSearchPage == 8) {
      print("hereeeee");
      await getSubreddit(curSearchTerm);
      displaySubreddit();
    } else {
      if (searchTerm != "" && searchTerm != " ") {
        var url = Config.baseUrl + "/search/" + searchTerm;
        var uri = Uri.parse(url);
        var result = await http.get(uri);
        dynamic resultJSON = jsonDecode(result.body);
        searchResults = resultJSON;
        currentSearchPage = 0;
      }
      setState(() {});
    }
  }

  void getContent() {
    getNews();
    getMovies();
    getCrypto();
    getAPOTD();
    getBooks("");
    var randomSubredditIndex = Random().nextInt(subredditList.length);
    getSubreddit(subredditList[randomSubredditIndex]);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getContent();
  }

  @override
  Widget build(BuildContext context) {
    List searchCategoriesWidgets = [
      {
        "label": "News",
        "searchPageIndex": 1,
        "onClickFunction": displayNews,
        "chosenColor": Colors.lightBlue,
        "pillIcon": Ionicons.newspaper_outline,
      },
      {
        "label": "Movies",
        "searchPageIndex": 2,
        "onClickFunction": displayMovies,
        "chosenColor": Colors.amberAccent,
        "pillIcon": Ionicons.newspaper_outline,
      },
      {
        "label": "Space",
        "searchPageIndex": 3,
        "onClickFunction": displayAPOTD,
        "chosenColor": Colors.grey[300]!,
        "pillIcon": Ionicons.sparkles_outline,
      },
      {
        "label": "Crypto",
        "searchPageIndex": 4,
        "onClickFunction": displayCrypto,
        "chosenColor": Colors.greenAccent,
        "pillIcon": Ionicons.cash_outline,
      },
      {
        "label": "Books",
        "searchPageIndex": 5,
        "onClickFunction": displayBooks,
        "chosenColor": Colors.limeAccent,
        "pillIcon": Ionicons.book_outline,
      },
      // Undone
      {
        "label": "Github",
        "searchPageIndex": 6,
        "onClickFunction": displayBooks,
        "chosenColor": Colors.white,
        "pillIcon": Ionicons.git_branch_outline,
      },
      {
        "label": "Memes",
        "searchPageIndex": 7,
        "onClickFunction": displayBooks,
        "chosenColor": Colors.limeAccent,
        "pillIcon": Icons.photo_outlined,
      },
      {
        "label": "Reddit",
        "searchPageIndex": 8,
        "onClickFunction": displaySubreddit,
        "chosenColor": Colors.deepOrange,
        "pillIcon": Ionicons.logo_reddit,
      },
      {
        "label": "Wikis",
        "searchPageIndex": 9,
        "onClickFunction": displayBooks,
        "chosenColor": Color.fromARGB(255, 255, 110, 158),
        "pillIcon": Icons.library_books_outlined,
      },
    ];

    List searchScreens = [
      // Search Results
      searchResults.isEmpty == false
          ? searchResults["accountResults"].isEmpty == true &&
                  searchResults["postResults"].isEmpty == true
              ? Container(
                  height: 200.0,
                  margin:
                      EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
                  padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 5.0),
                  decoration: BoxDecoration(
                    color: Colors.grey[900]!.withOpacity(0.1),
                    borderRadius: BorderRadius.all(
                      Radius.circular(20.0),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      "No Results Found",
                      style: TextStyle(
                        color: Colors.grey[500]!,
                      ),
                    ),
                  ),
                )
              : Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      searchResults["accountResults"].length == 0
                          ? Container()
                          : Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 8.0, vertical: 4.0),
                              padding: EdgeInsets.symmetric(
                                  vertical: 8.0, horizontal: 5.0),
                              decoration: BoxDecoration(
                                color: Colors.grey[900]!.withOpacity(0.1),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10.0),
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10.0, bottom: 15.0),
                                    child: Text(
                                      "Accounts",
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        // fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  for (var eachAccountResult
                                      in searchResults["accountResults"])
                                    Chats(
                                      chatObject: eachAccountResult,
                                      currentUsername:
                                          eachAccountResult["username"],
                                      backgroundColor: Colors.grey[900]!,
                                      currentUser: widget.currentUser,
                                    ),
                                ],
                              ),
                            ),
                      searchResults["postResults"].length == 0
                          ? Container()
                          : Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 4.0, vertical: 4.0),
                              padding: EdgeInsets.symmetric(
                                  vertical: 8.0, horizontal: 5.0),
                              decoration: BoxDecoration(
                                color: Colors.grey[900]!.withOpacity(0.1),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10.0),
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10.0, bottom: 15.0),
                                    child: Text(
                                      "Posts",
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        // fontWeight: FontWeight.bold,
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
                            ),
                    ],
                  ),
                )
          : Container(
              // width: double.infinity,
              // height: 280.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  newsLoading == true
                      ? Container()
                      : Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: 10.0, bottom: 5.0, left: 20.0),
                                    child: Text(
                                      "Headlines",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18.0,
                                      ),
                                    ),
                                  ),
                                  // IconButton(
                                  //   onPressed: () {
                                  //     currentSearchPage = 1;
                                  //     displayNews();
                                  //     setState(() {});
                                  //   },
                                  //   icon: Icon(
                                  //     Icons.keyboard_arrow_right_outlined,
                                  //   ),
                                  // ),
                                ],
                              ),
                              for (var eachNews in [0, 2, 3, 4, 5])
                                EachNews(
                                  newsObject: news[eachNews],
                                  extended: false,
                                ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    "Read More",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14.0,
                                    ),
                                  ),
                                  // SizedBox(width: 15.0),
                                  IconButton(
                                    onPressed: () {
                                      currentSearchPage = 1;
                                      displayNews();
                                      setState(() {});
                                    },
                                    icon: Icon(
                                      Icons.keyboard_arrow_right_outlined,
                                      size: 20.0,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                  cryptoLoading == true
                      ? Container()
                      : Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: 20.0, bottom: 10.0, left: 15.0),
                                    child: Text(
                                      "Top Cryptos",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18.0,
                                      ),
                                    ),
                                  ),
                                  // IconButton(
                                  //   onPressed: () {
                                  //     currentSearchPage = 2;
                                  //     displayCrypto();
                                  //     setState(() {});
                                  //   },
                                  //   icon: Icon(
                                  //     Icons.keyboard_arrow_right_outlined,
                                  //   ),
                                  // ),
                                ],
                              ),
                              for (var eachCrypto in [0, 2, 3, 4, 5])
                                GestureDetector(
                                  onTap: () {
                                    showCryptoDetails(cryptos[eachCrypto]);
                                  },
                                  child: EachCrypto(
                                    cryptoObject: cryptos[eachCrypto],
                                  ),
                                ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    "List More",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14.0,
                                    ),
                                  ),
                                  // SizedBox(width: 15.0),
                                  IconButton(
                                    onPressed: () {
                                      currentSearchPage = 2;
                                      displayCrypto();
                                      setState(() {});
                                    },
                                    icon: Icon(
                                      Icons.keyboard_arrow_right_outlined,
                                      size: 20.0,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                  moviesLoading == true
                      ? Container()
                      : Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: 25.0, bottom: 15.0, left: 15.0),
                                    child: Text(
                                      "Trending Movies",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18.0,
                                      ),
                                    ),
                                  ),
                                  // IconButton(
                                  //   onPressed: () {
                                  //     currentSearchPage = 3;
                                  //     displayMovies();
                                  //     setState(() {});
                                  //   },
                                  //   icon: Icon(
                                  //     Icons.keyboard_arrow_right_outlined,
                                  //   ),
                                  // ),
                                ],
                              ),
                            ],
                          ),
                        ),
                  moviesLoading == true
                      ? Container()
                      : Container(
                          width: double.infinity,
                          height: 280.0,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: [
                              for (var eachMovie in [
                                0,
                                1,
                                2,
                                3,
                                4,
                                5,
                                6,
                                7,
                                8,
                                9
                              ])
                                GestureDetector(
                                  onTap: () {
                                    showMovieDetails(movies[eachMovie]);
                                  },
                                  child: EachMovie(
                                    movieObject: movies[eachMovie],
                                  ),
                                ),
                            ],
                          ),
                        ),
                  moviesLoading == true
                      ? Container()
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              "Checkout More",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14.0,
                              ),
                            ),
                            // SizedBox(width: 15.0),
                            IconButton(
                              onPressed: () {
                                currentSearchPage = 3;
                                displayMovies();
                                setState(() {});
                              },
                              icon: Icon(
                                Icons.keyboard_arrow_right_outlined,
                                size: 20.0,
                              ),
                            ),
                          ],
                        ),

                  // EOP
                  SizedBox(height: 200.0),
                ],
              ),
            ),
      // Container(
      //   child: Column(
      //     children: [
      //       // Post Results
      //       curSearchTerm == "" || curSearchTerm == " "
      //           ? Column(
      //               children: [
      //                 // Trending Results
      //                 Container(
      //                   margin: EdgeInsets.symmetric(
      //                       horizontal: 4.0, vertical: 4.0),
      //                   padding: EdgeInsets.symmetric(vertical: 8.0),
      //                   decoration: BoxDecoration(
      //                     color: Colors.grey[900]!.withOpacity(0.0),
      //                     borderRadius: BorderRadius.all(
      //                       Radius.circular(10.0),
      //                     ),
      //                   ),
      //                   child: Column(
      //                     crossAxisAlignment: CrossAxisAlignment.start,
      //                     children: [
      //                       Padding(
      //                         padding: const EdgeInsets.symmetric(
      //                             horizontal: 15.0, vertical: 5.0),
      //                         child: Text(
      //                           "Trending",
      //                           style: TextStyle(
      //                             fontSize: 20.0,
      //                             fontWeight: FontWeight.bold,
      //                             color: Colors.white,
      //                           ),
      //                         ),
      //                       ),
      //                       Row(
      //                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //                         children: [
      //                           Container(
      //                             clipBehavior: Clip.hardEdge,
      //                             margin: EdgeInsets.symmetric(
      //                                 horizontal: 4.0, vertical: 4.0),
      //                             decoration: BoxDecoration(
      //                               borderRadius: BorderRadius.all(
      //                                 Radius.circular(10.0),
      //                               ),
      //                             ),
      //                             child: Image.asset(
      //                               "assets/images/INR.jpg",
      //                               width: 180.0,
      //                             ),
      //                           ),
      //                           Container(
      //                             clipBehavior: Clip.hardEdge,
      //                             margin: EdgeInsets.symmetric(
      //                                 horizontal: 4.0, vertical: 4.0),
      //                             decoration: BoxDecoration(
      //                               borderRadius: BorderRadius.all(
      //                                 Radius.circular(10.0),
      //                               ),
      //                             ),
      //                             child: Image.asset(
      //                               "assets/images/me2.jpg",
      //                               width: 180.0,
      //                             ),
      //                           ),
      //                         ],
      //                       ),
      //                     ],
      //                   ),
      //                 ),

      //                 Divider(
      //                   // color: Colors.black,
      //                   height: 20.0,
      //                 ),

      //                 // Chat Results
      //                 Container(
      //                   margin: EdgeInsets.symmetric(
      //                       horizontal: 4.0, vertical: 0.0),
      //                   padding: EdgeInsets.symmetric(
      //                       vertical: 0.0, horizontal: 5.0),
      //                   decoration: BoxDecoration(
      //                     color: Colors.grey[900]!.withOpacity(0.0),
      //                     borderRadius: BorderRadius.all(
      //                       Radius.circular(10.0),
      //                     ),
      //                   ),
      //                   child: Column(
      //                     crossAxisAlignment: CrossAxisAlignment.start,
      //                     children: [
      //                       Padding(
      //                         padding: EdgeInsets.symmetric(horizontal: 15.0),
      //                         child: Text(
      //                           "Accounts",
      //                           style: TextStyle(
      //                             fontSize: 20.0,
      //                             fontWeight: FontWeight.bold,
      //                             color: Colors.white,
      //                           ),
      //                         ),
      //                       ),
      //                       SizedBox(height: 15.0),
      //                       Chats(
      //                         borderRadius: 20.0,
      //                         currentUsername: widget.currentUser["username"],
      //                         chatObject: {
      //                           "profilepic":
      //                               "https://assets.entrepreneur.com/content/3x2/2000/20150224165308-jeff-bezos-amazon.jpeg",
      //                           "fullname": "Jeff Bezos",
      //                           "username": "jeffyman",
      //                         },
      //                         backgroundColor: Colors.grey[900]!,
      //                         currentUser: widget.currentUser,
      //                       ),
      //                       Chats(
      //                         borderRadius: 20.0,
      //                         currentUsername: widget.currentUser["username"],
      //                         chatObject: {
      //                           "profilepic":
      //                               "https://media.vanityfair.com/photos/5d41c7688df537000832361b/4:3/w_2668,h_2001,c_limit/GettyImages-945005812.jpg",
      //                           "fullname": "Mark Zuckerberg",
      //                           "username": "repitilian",
      //                         },
      //                         backgroundColor: Colors.grey[900]!,
      //                         currentUser: widget.currentUser,
      //                       ),
      //                     ],
      //                   ),
      //                 ),
      //               ],
      //             )
      //           : searchResults["postResults"] == null &&
      //                   searchResults["accountResults"] == null
      //               ? Container()
      //               : searchResults["postResults"].length == 0 &&
      //                       searchResults["accountResults"].length == 0
      //                   ? Container(
      //                       padding: EdgeInsets.only(top: 50.0),
      //                       child: Text(
      //                         "No Results Found",
      //                         style: TextStyle(
      //                           color: Colors.grey[500]!,
      //                         ),
      //                       ),
      //                     )
      //                   : Container(
      //                       margin: EdgeInsets.symmetric(
      //                           horizontal: 4.0, vertical: 4.0),
      //                       padding: EdgeInsets.symmetric(
      //                           vertical: 8.0, horizontal: 5.0),
      //                       decoration: BoxDecoration(
      //                         color: Colors.grey[900]!.withOpacity(0.4),
      //                         borderRadius: BorderRadius.all(
      //                           Radius.circular(10.0),
      //                         ),
      //                       ),
      //                       child: Column(
      //                         children: [
      //                           searchResults["postResults"].length > 0
      //                               ? Container(
      //                                   child: Column(
      //                                     crossAxisAlignment:
      //                                         CrossAxisAlignment.start,
      //                                     children: [
      //                                       Padding(
      //                                         padding:
      //                                             const EdgeInsets.symmetric(
      //                                                 horizontal: 15.0,
      //                                                 vertical: 8.0),
      //                                         child: Text(
      //                                           "Posts",
      //                                           style: TextStyle(
      //                                             fontSize: 20.0,
      //                                             fontWeight: FontWeight.bold,
      //                                             color: Colors.white,
      //                                           ),
      //                                         ),
      //                                       ),
      //                                       for (var eachPostResult
      //                                           in searchResults["postResults"])
      //                                         Posts(
      //                                           post: eachPostResult,
      //                                           currentUser: widget.currentUser,
      //                                         ),
      //                                     ],
      //                                   ),
      //                                 )
      //                               : Container(),
      //                           searchResults["accountResults"].length > 0
      //                               ? Container(
      //                                   child: Column(
      //                                     crossAxisAlignment:
      //                                         CrossAxisAlignment.start,
      //                                     children: [
      //                                       Padding(
      //                                         padding:
      //                                             const EdgeInsets.symmetric(
      //                                                 horizontal: 15.0,
      //                                                 vertical: 8.0),
      //                                         child: Text(
      //                                           "Accounts",
      //                                           style: TextStyle(
      //                                             fontSize: 20.0,
      //                                             fontWeight: FontWeight.bold,
      //                                             color: Colors.white,
      //                                           ),
      //                                         ),
      //                                       ),
      //                                       for (var eachAccountResult
      //                                           in searchResults[
      //                                               "accountResults"])
      //                                         Chats(
      //                                           borderRadius: 20.0,
      //                                           chatObject: eachAccountResult,
      //                                           currentUsername: widget
      //                                               .currentUser["username"],
      //                                           backgroundColor:
      //                                               Colors.grey[900]!,
      //                                           currentUser: widget.currentUser,
      //                                         ),
      //                                     ],
      //                                   ),
      //                                 )
      //                               : Container(),
      //                         ],
      //                       ),
      //                     ),
      //       SizedBox(height: 300.0),
      //     ],
      //   ),
      // ),
      // News

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

      // Space
      aPOTDLoading
          ? Container(
              width: double.infinity,
              height: 200.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(
                    color: Colors.grey,
                    strokeWidth: 1.0,
                  ),
                  SizedBox(height: 15.0),
                  Text(
                    "Exploring the Stars",
                    style: TextStyle(
                      color: Colors.grey[700],
                    ),
                  ),
                ],
              ),
            )
          : Column(
              children: [
                // Today
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.only(top: 10.0, bottom: 6.0, left: 25.0),
                      child: Text(
                        "Today",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => APOTDPage(
                          aPOTDObj: aPOTDToday,
                          tag: aPOTDToday["hdurl"].toString(),
                        ),
                      ),
                    );
                  },
                  child: EachAPOTD(
                    aPOTDObj: aPOTDToday,
                    tag: aPOTDToday["hdurl"].toString(),
                  ),
                ),
                SizedBox(height: 5.0),

                // This Week
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.only(top: 10.0, bottom: 6.0, left: 25.0),
                      child: Text(
                        "This Week",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                  ],
                ),
                for (var eachAPOTD in aPOTDWeek)
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => APOTDPage(
                            aPOTDObj: eachAPOTD,
                            tag: eachAPOTD["date"].toString(),
                          ),
                        ),
                      );
                    },
                    child: EachAPOTD(
                      aPOTDObj: eachAPOTD,
                      tag: eachAPOTD["date"].toString(),
                    ),
                  ),
                SizedBox(height: 5.0),

                // Other Days
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.only(top: 10.0, bottom: 6.0, left: 25.0),
                      child: Text(
                        "Other Days",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                  ],
                ),
                for (var eachAPOTD in aPOTDs)
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => APOTDPage(
                            aPOTDObj: eachAPOTD,
                            tag: eachAPOTD["explanation"].toString(),
                          ),
                        ),
                      );
                    },
                    child: EachAPOTD(
                      aPOTDObj: eachAPOTD,
                      tag: eachAPOTD["explanation"].toString(),
                    ),
                  ),
                SizedBox(height: 200.0),
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

      // Books
      booksLoading
          ? Container(
              width: double.infinity,
              height: 200.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(
                    color: Colors.grey,
                    strokeWidth: 1.0,
                  ),
                  SizedBox(height: 15.0),
                  Text(
                    "Going Through Shelves",
                    style: TextStyle(
                      color: Colors.grey[700],
                    ),
                  ),
                ],
              ),
            )
          : Container(
              child: books.length == 0
                  ? Column(
                      children: [
                        SizedBox(height: 100.0),
                        Container(
                          child: Text(
                            "No Books Found",
                            style: TextStyle(
                              color: Colors.grey[700],
                            ),
                          ),
                        ),
                      ],
                    )
                  : Column(
                      children: [
                        for (var eachBook in eachBookWidget) eachBook,
                        SizedBox(height: 200.0),
                      ],
                    ),
            ),
      // Github
      Container(),

      // Memes
      Container(),

      // Reddit
      redditLoading == true
          ? Container(
              width: double.infinity,
              height: 200.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(
                    color: Colors.grey,
                    strokeWidth: 1.0,
                  ),
                  SizedBox(height: 15.0),
                  Text(
                    "Loading Subreddit",
                    style: TextStyle(
                      color: Colors.grey[700],
                    ),
                  ),
                ],
              ),
            )
          : Column(
              children: [
                Container(
                  child: Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onHorizontalDragEnd: (value) async {
                            var randomSubredditIndex =
                                Random().nextInt(subredditList.length);
                            chosenSubreddit =
                                subredditList[randomSubredditIndex];
                            redditLoading = true;
                            subRedditPostsWidget = [];
                            setState(() {});
                            await getSubreddit(
                                subredditList[randomSubredditIndex]);
                            displaySubreddit();
                          },
                          child: Container(
                            // width: double.infinity,
                            margin: EdgeInsets.symmetric(
                                horizontal: 25.0, vertical: 5.0),
                            padding: EdgeInsets.symmetric(
                                horizontal: 15.0, vertical: 10.0),
                            decoration: BoxDecoration(
                              color: Colors.deepOrange.withOpacity(0.5),
                              border: Border.all(
                                color: Colors.deepOrange.withOpacity(0.5),
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(20.0),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                "r/" + chosenSubreddit.toString(),
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          sortSubredditPostsBottomSheet();
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 8.0),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.deepOrange.withOpacity(0.5),
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(100.0),
                            ),
                          ),
                          child: Icon(
                            Icons.sort,
                          ),
                        ),
                      ),
                      SizedBox(width: 30.0),
                    ],
                  ),
                ),
                SizedBox(height: 10.0),
                Container(
                  child: Column(
                    children: [
                      for (var eachSubredditPost in subRedditPostsWidget)
                        eachSubredditPost,
                      SizedBox(height: 200.0),
                    ],
                  ),
                ),
              ],
            ),
    ];

    return ListView(
      children: [
        // Search Box
        RoundedSearchInputBox(
          textEditingController: searchTextController,
          onChangedFunction: search,
          focusNode: widget.searchFocusNode,
        ),

        // Search Pages
        Container(
          height: 50.0,
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
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  for (var eachSearchCategory in searchCategoriesWidgets)
                    chosenSearchCategories
                                .contains(eachSearchCategory["label"]) ==
                            true
                        ? Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  eachSearchCategory["onClickFunction"]();
                                },
                                child: IconPillButton(
                                  chosenColor:
                                      eachSearchCategory["chosenColor"],
                                  icon: eachSearchCategory["pillIcon"],
                                  label: eachSearchCategory["label"],
                                  chosen: (currentSearchPage ==
                                          eachSearchCategory["searchPageIndex"]
                                      ? true
                                      : false),
                                ),
                              ),
                              SizedBox(width: 8.0),
                            ],
                          )
                        : Container(),

                  // Search Category Options
                  IconButton(
                    onPressed: () {
                      searchCategories();
                    },
                    icon: Icon(
                      Ionicons.settings_outline,
                      size: 18.0,
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
