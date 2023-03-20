import 'package:flutter/material.dart';
import 'package:myallin1/pages/components/icon_pill_button.dart';

class SortSubredditBottomSheet extends StatefulWidget {
  const SortSubredditBottomSheet({
    super.key,
    required this.sortRedditPosts,
    required this.timeSort,
    required this.postListing,
  });

  final Function sortRedditPosts;
  final int timeSort;
  final int postListing;

  @override
  State<SortSubredditBottomSheet> createState() =>
      _SortSubredditBottomSheetState();
}

class _SortSubredditBottomSheetState extends State<SortSubredditBottomSheet> {
  int timeSort = 1;
  int postListing = 1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    timeSort = widget.timeSort + 1;
    postListing = widget.postListing + 1;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
        width: double.infinity,
        padding: EdgeInsets.only(top: 2.0, left: 0.0, right: 0.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
          color: Color.fromARGB(255, 18, 18, 18),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 25.0),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Text(
                "Sort Subreddit Posts",
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 25.0),

            // Time
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Text(
                "Choose Time",
                style: TextStyle(
                  fontSize: 15.0,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 14.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    timeSort = 1;
                    setState(() {});
                  },
                  child: IconPillButton(
                    label: "Hour",
                    iconOff: true,
                    chosen: timeSort == 1 ? true : false,
                    chosenColor: Colors.grey[400]!,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    timeSort = 2;
                    setState(() {});
                  },
                  child: IconPillButton(
                    label: "Day",
                    iconOff: true,
                    chosen: timeSort == 2 ? true : false,
                    chosenColor: Colors.grey[400]!,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    timeSort = 3;
                    setState(() {});
                  },
                  child: IconPillButton(
                    label: "Week",
                    iconOff: true,
                    chosen: timeSort == 3 ? true : false,
                    chosenColor: Colors.grey[400]!,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    timeSort = 4;
                    setState(() {});
                  },
                  child: IconPillButton(
                    label: "Month",
                    iconOff: true,
                    chosen: timeSort == 4 ? true : false,
                    chosenColor: Colors.grey[400]!,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    timeSort = 5;
                    setState(() {});
                  },
                  child: IconPillButton(
                    label: "Year",
                    iconOff: true,
                    chosen: timeSort == 5 ? true : false,
                    chosenColor: Colors.grey[400]!,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    timeSort = 6;
                    setState(() {});
                  },
                  child: IconPillButton(
                    label: "All",
                    iconOff: true,
                    chosen: timeSort == 6 ? true : false,
                    chosenColor: Colors.grey[400]!,
                  ),
                ),
              ],
            ),
            SizedBox(height: 25.0),

            // Rating
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Text(
                "Choose Rating",
                style: TextStyle(
                  fontSize: 15.0,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 14.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    postListing = 1;
                    setState(() {});
                  },
                  child: IconPillButton(
                    label: "New",
                    iconOff: true,
                    chosen: postListing == 1 ? true : false,
                    chosenColor: Colors.grey[400]!,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    postListing = 2;
                    setState(() {});
                  },
                  child: IconPillButton(
                    label: "Hot",
                    iconOff: true,
                    chosen: postListing == 2 ? true : false,
                    chosenColor: Colors.grey[400]!,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    postListing = 3;
                    setState(() {});
                  },
                  child: IconPillButton(
                    label: "Rising",
                    iconOff: true,
                    chosen: postListing == 3 ? true : false,
                    chosenColor: Colors.grey[400]!,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    postListing = 4;
                    setState(() {});
                  },
                  child: IconPillButton(
                    label: "Best",
                    iconOff: true,
                    chosen: postListing == 4 ? true : false,
                    chosenColor: Colors.grey[400]!,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    postListing = 5;
                    setState(() {});
                  },
                  child: IconPillButton(
                    label: "Random",
                    iconOff: true,
                    chosen: postListing == 5 ? true : false,
                    chosenColor: Colors.grey[400]!,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    postListing = 6;
                    setState(() {});
                  },
                  child: IconPillButton(
                    label: "Top",
                    iconOff: true,
                    chosen: postListing == 6 ? true : false,
                    chosenColor: Colors.grey[400]!,
                  ),
                ),
              ],
            ),

            SizedBox(height: 25.0),
            Padding(
              padding: EdgeInsets.only(left: 15.0),
              child: ElevatedButton(
                onPressed: () {
                  widget.sortRedditPosts(timeSort, postListing);
                  Navigator.pop(context);
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    Colors.grey[900],
                  ),
                  fixedSize: MaterialStateProperty.all(
                    Size(180.0, 35.0),
                  ),
                ),
                child: Text(
                  "Sort Posts",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
