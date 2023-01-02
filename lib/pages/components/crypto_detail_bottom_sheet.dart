import 'package:flutter/material.dart';

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
        color: Colors.black,
        image: DecorationImage(
          image: NetworkImage(widget.cryptoObject["image"]),
          fit: BoxFit.cover,
          opacity: 0.1,
        ),
      ),
      child: ListView(
        children: [
          Column(
            children: [
              SizedBox(height: 20.0),
              Container(
                width: 120.0,
                height: 120.0,
                child: Image.network(
                  widget.cryptoObject["image"],
                ),
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
              SizedBox(height: 15.0),
              CryptoStats(
                icon: Icons.abc,
                title: "Current Price",
                value: widget.cryptoObject["current_price"],
              ),
              CryptoStats(
                icon: Icons.abc,
                title: "High 24",
                value: widget.cryptoObject["high_24h"],
              ),
              CryptoStats(
                icon: Icons.abc,
                title: "Low 24",
                value: widget.cryptoObject["low_24h"],
              ),
              CryptoStats(
                icon: Icons.abc,
                title: "Market Cap",
                value: widget.cryptoObject["market_cap"],
              ),
              CryptoStats(
                icon: Icons.abc,
                title: "ath",
                value: widget.cryptoObject["ath"],
              ),
              CryptoStats(
                icon: Icons.abc,
                title: "ath_date",
                value:
                    widget.cryptoObject["ath_date"].toString().substring(0, 10),
              ),
              CryptoStats(
                icon: Icons.abc,
                title: "atl",
                value: widget.cryptoObject["atl"],
              ),
              CryptoStats(
                icon: Icons.abc,
                title: "atl_date",
                value:
                    widget.cryptoObject["atl_date"].toString().substring(0, 10),
              ),
            ],
          ),
        ],
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
