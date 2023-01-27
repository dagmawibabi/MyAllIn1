import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:myallin1/pages/components/crypto_stats_type2.dart';

class CryptoDetailBottomSheet extends StatefulWidget {
  const CryptoDetailBottomSheet({
    super.key,
    required this.cryptoObject,
  });

  final Map cryptoObject;

  @override
  State<CryptoDetailBottomSheet> createState() =>
      _CryptoDetailBottomSheetState();
}

class _CryptoDetailBottomSheetState extends State<CryptoDetailBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        // color: Color.fromARGB(255, 18, 18, 18),
        color: Colors.black.withOpacity(0.4),
        borderRadius: BorderRadius.all(
          Radius.circular(15.0),
        ),
        image: DecorationImage(
          image: NetworkImage(widget.cryptoObject["image"]),
          fit: BoxFit.cover,
          opacity: 0.009,
          colorFilter: ColorFilter.srgbToLinearGamma(),
        ),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
          child: Column(
            children: [
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
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.73,
                child: ListView(
                  children: [
                    Column(
                      children: [
                        // SizedBox(height: 20.0),
                        Container(
                          width: 120.0,
                          height: 120.0,
                          child: CachedNetworkImage(
                            imageUrl: widget.cryptoObject["image"],
                            progressIndicatorBuilder:
                                (context, url, downloadProgress) =>
                                    CircularProgressIndicator(
                              value: downloadProgress.progress,
                              color: Colors.grey[800]!,
                              strokeWidth: 2.0,
                            ),
                            errorWidget: (context, url, error) => Icon(
                              Icons.error_outline,
                            ),
                          ),
                          // Image.network(
                          //   widget.cryptoObject["image"],
                          // ),
                        ),
                        SizedBox(height: 15.0),
                        Text(
                          widget.cryptoObject["name"],
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5.0),
                        Text(
                          widget.cryptoObject["symbol"],
                          style: TextStyle(
                            color: Colors.white,
                            // fontSize: 20.0,
                          ),
                        ),
                        SizedBox(height: 25.0),
                        // CryptoStats(
                        //   icon: Icons.abc,
                        //   title: "Current Price",
                        //   value: widget.cryptoObject["current_price"],
                        // ),
                        //
                        CryptoStatType2(
                          mainTitle: "Current Price",
                          title1: "Price",
                          value1:
                              widget.cryptoObject["current_price"].toString(),
                          title2: "Last Update",
                          value2: widget.cryptoObject["last_updated"]
                              .toString()
                              .substring(11, 19),
                        ),
                        //
                        CryptoStatType2(
                          mainTitle: "Daily Price",
                          title1: "High",
                          value1: widget.cryptoObject["high_24h"],
                          title2: "Low",
                          value2: widget.cryptoObject["low_24h"],
                        ),
                        //
                        CryptoStatType2(
                          mainTitle: "All Time High",
                          title1: "Price",
                          value1: widget.cryptoObject["ath"],
                          title2: "Date",
                          value2: widget.cryptoObject["ath_date"]
                              .toString()
                              .substring(0, 10),
                        ),
                        //
                        CryptoStatType2(
                          mainTitle: "All Time Low",
                          title1: "Price",
                          value1: widget.cryptoObject["atl"],
                          title2: "Date",
                          value2: widget.cryptoObject["atl_date"]
                              .toString()
                              .substring(0, 10),
                        ),
                        //
                        CryptoStatType2(
                          mainTitle: "Market",
                          title1: "Market Rank",
                          value1: widget.cryptoObject["market_cap_rank"],
                          title2: "Market Cap",
                          value2: widget.cryptoObject["market_cap"],
                        ),
                        //
                        CryptoStatType2(
                          mainTitle: "Price Change 24h",
                          title1: "Price",
                          value1: widget.cryptoObject["price_change_24h"],
                          title2: "Percentage",
                          value2: widget
                              .cryptoObject["price_change_percentage_24h"],
                        ),
                        //
                        CryptoStatType2(
                          mainTitle: "Supply",
                          title1: "Max",
                          value1: widget.cryptoObject["max_supply"],
                          title2: "Total",
                          value2: widget.cryptoObject["total_supply"],
                        ),

                        //
                        SizedBox(height: 200.0),

                        // CryptoStats(
                        //   icon: Icons.abc,
                        //   title: "High 24",
                        //   value: widget.cryptoObject["high_24h"],
                        // ),
                        // CryptoStats(
                        //   icon: Icons.abc,
                        //   title: "Low 24",
                        //   value: widget.cryptoObject["low_24h"],
                        // ),
                        // CryptoStats(
                        //   icon: Icons.abc,
                        //   title: "Market Cap",
                        //   value: widget.cryptoObject["market_cap"],
                        // ),
                        // CryptoStats(
                        //   icon: Icons.abc,
                        //   title: "ath",
                        //   value: widget.cryptoObject["ath"],
                        // ),
                        // CryptoStats(
                        //   icon: Icons.abc,
                        //   title: "ath_date",
                        //   value:
                        //       widget.cryptoObject["ath_date"].toString().substring(0, 10),
                        // ),
                        // CryptoStats(
                        //   icon: Icons.abc,
                        //   title: "atl",
                        //   value: widget.cryptoObject["atl"],
                        // ),
                        // CryptoStats(
                        //   icon: Icons.abc,
                        //   title: "atl_date",
                        //   value:
                        //       widget.cryptoObject["atl_date"].toString().substring(0, 10),
                        // ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CryptoStats extends StatefulWidget {
  CryptoStats({
    Key? key,
    required this.icon,
    required this.title,
    required this.value,
  }) : super(
          key: key,
        );

  final IconData icon;
  final String title;
  final dynamic value;

  @override
  State<CryptoStats> createState() => _CryptoStatsState();
}

class _CryptoStatsState extends State<CryptoStats> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 4.0),
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      decoration: BoxDecoration(
        color: Colors.grey[900]!,
        borderRadius: BorderRadius.all(
          Radius.circular(15.0),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                widget.icon,
              ),
              SizedBox(width: 5.0),
              Text(
                widget.title.toString(),
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ],
          ),
          Text(
            widget.value.toString(),
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
