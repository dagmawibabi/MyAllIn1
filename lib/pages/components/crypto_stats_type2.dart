import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class CryptoStatType2 extends StatefulWidget {
  const CryptoStatType2({
    super.key,
    required this.mainTitle,
    required this.title1,
    required this.value1,
    required this.title2,
    required this.value2,
  });

  final String mainTitle;
  final String title1;
  final dynamic value1;
  final String title2;
  final dynamic value2;

  @override
  State<CryptoStatType2> createState() => _CryptoStatType2State();
}

class _CryptoStatType2State extends State<CryptoStatType2> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // width: 100.0,
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
      decoration: BoxDecoration(
        // color: Colors.grey[900]!.withOpacity(0.2),
        borderRadius: BorderRadius.all(
          Radius.circular(15.0),
        ),
      ),
      child: Column(
        children: [
          // Padding(
          //   padding: EdgeInsets.symmetric(vertical: 5.0),
          //   child: Text(
          //     widget.mainTitle,
          //     style: TextStyle(
          //       color: Colors.white,
          //     ),
          //   ),
          // ),
          // SizedBox(height: 5.0),
          Container(
            // padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
            decoration: BoxDecoration(
              color: Colors.grey[900]!.withOpacity(0.2),
              // borderRadius: BorderRadius.only(
              //   bottomLeft: Radius.circular(15.0),
              //   bottomRight: Radius.circular(15.0),
              // ),
              borderRadius: BorderRadius.all(
                Radius.circular(15.0),
              ),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Main Title
                    Container(
                      width: 150.0,
                      height: 58.0,
                      padding: EdgeInsets.only(left: 15.0),
                      decoration: BoxDecoration(
                        // color: Colors.grey[900]!.withOpacity(0.4),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15.0),
                          bottomLeft: Radius.circular(15.0),
                        ),
                      ),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          widget.mainTitle,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        // color: Colors.grey[900]!.withOpacity(0.2),
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(15.0),
                          bottomRight: Radius.circular(15.0),
                        ),
                      ),
                      // Title and Value 1 and 2
                      child: Row(
                        children: [
                          // Title and Value 1
                          Container(
                            width: 120.0,
                            // color: Colors.grey[900]!.withOpacity(0.2),
                            padding: EdgeInsets.only(
                                right: 10.0, left: 6, top: 10.0, bottom: 10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  widget.title1,
                                  style: TextStyle(
                                    fontSize: 12.0,
                                    color: Colors.grey[600]!,
                                  ),
                                ),
                                SizedBox(height: 5.0),
                                Text(
                                  widget.value1.toString(),
                                  maxLines: 1,
                                  style: TextStyle(
                                    fontSize: 13.0,
                                    color: Colors.white,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // Title and Value 2
                          Container(
                            width: 125.0,
                            decoration: BoxDecoration(
                              // color: Colors.grey[900]!.withOpacity(0.3),
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(15.0),
                                bottomRight: Radius.circular(15.0),
                              ),
                            ),
                            padding: EdgeInsets.only(
                                right: 10.0, top: 10.0, bottom: 10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  widget.title2,
                                  style: TextStyle(
                                    fontSize: 12.0,
                                    color: Colors.grey[600]!,
                                  ),
                                ),
                                SizedBox(height: 5.0),
                                Text(
                                  widget.value2.toString(),
                                  maxLines: 1,
                                  style: TextStyle(
                                    overflow: TextOverflow.ellipsis,
                                    color: Colors.white,
                                    fontSize: 13.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
