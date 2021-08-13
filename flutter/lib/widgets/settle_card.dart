import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettleCard extends StatelessWidget {
  final String title;
  // final optionType; // TODO

  SettleCard(this.title);

  final List<Color> pastelColors = [
    Color(0xFFBFFCC6), // green
    Color(0xFFFFCCF9), // pink
    Color(0xFFC2EDFF), // blue
    Color(0xFFD6D8FF), // purple
    Color(0xFFFFCFC2), // orange
  ];

  @override
  Widget build(BuildContext context) {
    // if (optionType == custom) // TODO
    return _buildCustomOptionCard();
  }

  Widget _buildCustomOptionCard() {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        color: pastelColors[title.hashCode % pastelColors.length],
      ),
      child: Align(
        alignment: Alignment.center,
        child: Text(title,
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
            fontWeight: FontWeight.w700
          ),
        ),
      )
    );
  }

  /* Ali's template for cards (use for options that aren't custom):

  List<Widget> cards = List.generate(
    colors.length,
    (int index) {
      return Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              color: colors[index],
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/adamoo.jpg'),
              )),
          child: Align(
            alignment: Alignment.bottomLeft,
            child: Container(
                padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('Card number $index',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.w700)),
                    Padding(padding: EdgeInsets.only(bottom: 8.0)),
                    Text('A short description.',
                        textAlign: TextAlign.start,
                        style: TextStyle(color: Colors.white)),
                  ],
                )),
          ));
    },
  );

  */

}
