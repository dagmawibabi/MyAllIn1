import 'package:flutter/material.dart';

class EachCrypto extends StatefulWidget {
  const EachCrypto({
    super.key,
    this.cryptoObject,
  });

  final dynamic cryptoObject;

  @override
  State<EachCrypto> createState() => _EachCryptoState();
}

class _EachCryptoState extends State<EachCrypto> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      decoration: BoxDecoration(
        color: Colors.grey[900]!.withOpacity(0.4),
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Crypto ID
          Container(
            child: Row(
              children: [
                Image.network(
                  widget.cryptoObject["image"],
                  width: 40.0,
                  height: 40.0,
                ),
                SizedBox(width: 10.0),
                Container(
                  width: 100.0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.cryptoObject["name"],
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        widget.cryptoObject["symbol"],
                        style: TextStyle(
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // High and Low
          Container(
            width: 100.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "\$${widget.cryptoObject["high_24h"]}",
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 12.0,
                    color: Colors.greenAccent,
                  ),
                ),
                SizedBox(height: 5.0),
                Text(
                  "\$${widget.cryptoObject["low_24h"]}",
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 12.0,
                    color: Colors.redAccent,
                  ),
                ),
              ],
            ),
          ),
          // Current Price
          Container(
            width: 100.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "\$${widget.cryptoObject["current_price"]}",
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
