import 'package:flutter/material.dart';
import 'package:tourist/theme/theme.dart';

class BizDetails extends StatelessWidget {
  final String name;
  final String image;
  final String address;
  final int price;

  const BizDetails(
      {Key? key,
      required this.name,
      required this.image,
      required this.address,
      required this.price})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(7.0),
              child: SizedBox(
                height: 300,
                width: double.infinity,
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18)),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(18),
                    child: Image.network(
                      image,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(5, 5, 0, 5),
              child: Text(
                name,
                style: heading2.copyWith(color: textBlack, fontSize: 35),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      "Located at " + address,
                      style: heading2.copyWith(
                          color: Colors.grey[700], fontSize: 17),
                    ),
                  ),
                ),
              ],
            ),
            Row(children: [
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.fromLTRB(12, 5, 0, 0),
                child: Text(
                  "Rs. " + price.toString(),
                  style:
                      heading2.copyWith(color: Colors.grey[700], fontSize: 17),
                ),
              )),
            ])
          ],
        ),
      ),
    );
  }
}
