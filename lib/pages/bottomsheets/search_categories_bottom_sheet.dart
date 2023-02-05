import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:myallin1/pages/components/icon_pill_button.dart';

class SearchCategoriesBottomSheet extends StatefulWidget {
  const SearchCategoriesBottomSheet({super.key});

  @override
  State<SearchCategoriesBottomSheet> createState() =>
      _SearchCategoriesBottomSheetState();
}

class _SearchCategoriesBottomSheetState
    extends State<SearchCategoriesBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
      child: Container(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
          child: Column(
            children: [
              // Back Button
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[900]!,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20.0),
                        bottomRight: Radius.circular(20.0),
                      ),
                    ),
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.arrow_back,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 25.0),

              Text(
                "Choose Search Categories",
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 25.0),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconPillButton(
                    icon: Ionicons.book_outline,
                    label: "Books",
                    backgroundColor: Colors.black.withOpacity(0.4),
                    border: 0.4,
                  ),
                  IconPillButton(
                    icon: Ionicons.cash_outline,
                    label: "Crypto",
                    backgroundColor: Colors.black.withOpacity(0.4),
                    border: 0.4,
                  ),
                  IconPillButton(
                    icon: Ionicons.git_branch_outline,
                    label: "Github",
                    backgroundColor: Colors.black.withOpacity(0.4),
                    border: 0.4,
                  ),
                ],
              ),
              SizedBox(height: 20.0),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconPillButton(
                    icon: Icons.photo_outlined,
                    label: "Memes",
                    backgroundColor: Colors.black.withOpacity(0.4),
                    border: 0.4,
                  ),
                  IconPillButton(
                    icon: Ionicons.film_outline,
                    label: "Movies",
                    backgroundColor: Colors.black.withOpacity(0.4),
                    border: 0.4,
                  ),
                  IconPillButton(
                    icon: Ionicons.newspaper_outline,
                    label: "News",
                    backgroundColor: Colors.black.withOpacity(0.4),
                    border: 0.4,
                  ),
                ],
              ),
              SizedBox(height: 20.0),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconPillButton(
                    icon: Ionicons.logo_reddit,
                    label: "Reddit",
                    backgroundColor: Colors.black.withOpacity(0.4),
                    border: 0.4,
                  ),
                  IconPillButton(
                    icon: Ionicons.sparkles_outline,
                    label: "Space",
                    backgroundColor: Colors.black.withOpacity(0.4),
                    border: 0.4,
                  ),
                  IconPillButton(
                    icon: Icons.library_books_outlined,
                    label: "Wikis",
                    backgroundColor: Colors.black.withOpacity(0.4),
                    border: 0.4,
                  ),
                ],
              ),
              SizedBox(height: 20.0),
            ],
          ),
        ),
      ),
    );
  }
}
