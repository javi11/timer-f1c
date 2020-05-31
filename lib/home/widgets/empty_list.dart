import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class EmptyList extends StatelessWidget {
  final Function onStartFlight;
  final Widget logo = SvgPicture.asset(
    'assets/images/logo.svg',
    semanticsLabel: 'Logo',
    width: 100,
    height: 100,
  );
  EmptyList({Key key, @required this.onStartFlight}) : super(key: key);

  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsetsDirectional.only(top: 140),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(children: <Widget>[
          logo,
          Text(
            'No Flights Done Yet',
            style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.black54),
          ),
          SizedBox(
            height: 24,
          ),
          SizedBox(
            width: 210,
            child: Text('Make sure that bluetooth device is on before start.',
                style: TextStyle(
                    fontWeight: FontWeight.w500, color: Colors.black38)),
          ),
          SizedBox(
            height: 24,
          ),
          ButtonTheme(
              minWidth: 250.0,
              height: 60.0,
              child: RaisedButton.icon(
                  shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.black12)),
                  elevation: 0,
                  icon: Icon(
                    Icons.flight_takeoff,
                    color: Colors.blue,
                  ),
                  textColor: Colors.black87,
                  label: Text(
                    'Start a flight',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
                  ),
                  color: Colors.green[50],
                  onPressed: onStartFlight))
        ]));
  }
}
