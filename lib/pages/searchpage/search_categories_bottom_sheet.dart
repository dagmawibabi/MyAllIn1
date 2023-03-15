import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:myallin1/pages/components/icon_pill_button.dart';

class SearchCategoriesBottomSheet extends StatefulWidget {
  const SearchCategoriesBottomSheet({
    super.key,
    required this.chosenSearchCategories,
    required this.setChosenCategories,
  });

  final List chosenSearchCategories;
  final Function setChosenCategories;

  @override
  State<SearchCategoriesBottomSheet> createState() =>
      _SearchCategoriesBottomSheetState();
}

class _SearchCategoriesBottomSheetState
    extends State<SearchCategoriesBottomSheet> {
  List chosenSearchCategories = [];

  // Choose Search Categories
  void addOrRemoveSearchCategory(String searchCategoryLabel) {
    if (chosenSearchCategories.contains(searchCategoryLabel) == true) {
      chosenSearchCategories.remove(searchCategoryLabel);
    } else {
      chosenSearchCategories.add(searchCategoryLabel);
    }
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    chosenSearchCategories = widget.chosenSearchCategories;
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> searchCategoriesWidgets = [
      GestureDetector(
        onTap: () {
          addOrRemoveSearchCategory("Books");
        },
        child: IconPillButton(
          icon: Ionicons.book_outline,
          label: "Books",
          backgroundColor: Colors.black.withOpacity(0.4),
          border: 0.4,
          chosenColor: Colors.limeAccent,
          chosen: chosenSearchCategories.contains("Books"),
        ),
      ),
      GestureDetector(
        onTap: () {
          addOrRemoveSearchCategory("Crypto");
        },
        child: IconPillButton(
          icon: Ionicons.cash_outline,
          label: "Crypto",
          backgroundColor: Colors.black.withOpacity(0.4),
          border: 0.4,
          chosenColor: Colors.greenAccent,
          chosen: chosenSearchCategories.contains("Crypto"),
        ),
      ),
      GestureDetector(
        onTap: () {
          addOrRemoveSearchCategory("Github");
        },
        child: IconPillButton(
          icon: Ionicons.git_branch_outline,
          label: "Github",
          backgroundColor: Colors.black.withOpacity(0.4),
          border: 0.4,
          chosenColor: Colors.white,
          chosen: chosenSearchCategories.contains("Github"),
        ),
      ),
      GestureDetector(
        onTap: () {
          addOrRemoveSearchCategory("Memes");
        },
        child: IconPillButton(
          icon: Icons.photo_outlined,
          label: "Memes",
          backgroundColor: Colors.black.withOpacity(0.4),
          border: 0.4,
          chosenColor: Colors.tealAccent,
          chosen: chosenSearchCategories.contains("Memes"),
        ),
      ),
      GestureDetector(
        onTap: () {
          addOrRemoveSearchCategory("Movies");
        },
        child: IconPillButton(
          icon: Ionicons.film_outline,
          label: "Movies",
          backgroundColor: Colors.black.withOpacity(0.4),
          border: 0.4,
          chosenColor: Colors.amberAccent,
          chosen: chosenSearchCategories.contains("Movies"),
        ),
      ),
      GestureDetector(
        onTap: () {
          addOrRemoveSearchCategory("News");
        },
        child: IconPillButton(
          icon: Ionicons.newspaper_outline,
          label: "News",
          backgroundColor: Colors.black.withOpacity(0.4),
          border: 0.4,
          chosenColor: Colors.lightBlue,
          chosen: chosenSearchCategories.contains("News"),
        ),
      ),
      GestureDetector(
        onTap: () {
          addOrRemoveSearchCategory("Reddit");
        },
        child: IconPillButton(
          icon: Ionicons.logo_reddit,
          label: "Reddit",
          backgroundColor: Colors.black.withOpacity(0.4),
          border: 0.4,
          boldLabel: true,
          chosenColor: Colors.deepOrange,
          chosen: chosenSearchCategories.contains("Reddit"),
        ),
      ),
      GestureDetector(
        onTap: () {
          addOrRemoveSearchCategory("Space");
        },
        child: IconPillButton(
          icon: Ionicons.sparkles_outline,
          label: "Space",
          backgroundColor: Colors.black.withOpacity(0.4),
          border: 0.4,
          chosenColor: Colors.grey[300]!,
          chosen: chosenSearchCategories.contains("Space"),
        ),
      ),
      GestureDetector(
        onTap: () {
          addOrRemoveSearchCategory("Wikis");
        },
        child: IconPillButton(
          icon: Icons.library_books_outlined,
          label: "Wikis",
          backgroundColor: Colors.black.withOpacity(0.4),
          border: 0.4,
          boldLabel: true,
          chosenColor: Color.fromARGB(255, 255, 110, 158),
          chosen: chosenSearchCategories.contains("Wikis"),
        ),
      ),
    ];
    return ListView(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.55,
          padding: EdgeInsets.only(top: 2.0, left: 0.0, right: 0.0),
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(20.0),
            ),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.pink,
                Colors.blueAccent,
                Colors.greenAccent,
              ],
            ),
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              ),
              color: Color.fromARGB(255, 18, 18, 18),
            ),
            child: Column(
              children: [
                // // Back Button
                // Row(
                //   children: [
                //     Container(
                //       decoration: BoxDecoration(
                //         color: Colors.grey[900]!,
                //         borderRadius: BorderRadius.only(
                //           topRight: Radius.circular(20.0),
                //           bottomRight: Radius.circular(20.0),
                //         ),
                //       ),
                //       child: IconButton(
                //         onPressed: () {
                //           Navigator.pop(context);
                //         },
                //         icon: Icon(
                //           Icons.arrow_back,
                //         ),
                //       ),
                //     ),
                //   ],
                // ),
                SizedBox(height: 25.0),

                Text(
                  "Choose Search Categories",
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 25.0),

                Container(
                  // color: Colors.red,
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.2,
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: GridView.count(
                    primary: true,
                    shrinkWrap: true,
                    crossAxisCount: 3,
                    childAspectRatio: 3.0,
                    children: searchCategoriesWidgets,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 12.0,
                  ),
                ),
                SizedBox(height: 25.0),

                ElevatedButton(
                  onPressed: () {
                    widget.setChosenCategories(chosenSearchCategories);
                    Navigator.pop(context);
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      Colors.grey[900],
                    ),
                    fixedSize: MaterialStateProperty.all(
                      Size(200.0, 40.0),
                    ),
                  ),
                  child: Text(
                    "Save Categories",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
