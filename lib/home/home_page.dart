import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:timmer/home/widgets/clipped_parts.dart';
import 'package:timmer/home/widgets/drawer.dart';
import 'package:timmer/home/widgets/history.dart';
import 'package:timmer/models/timmer.dart';
import 'package:timmer/tracking/tracking_page.dart';
import 'package:timmer/widgets/app_title.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<InOutAnimationState> _fabAnimationController =
      GlobalKey<InOutAnimationState>();

  bool _handleScrollNotification(ScrollNotification notification) {
    if (notification.depth == 0) {
      if (notification is UserScrollNotification) {
        final UserScrollNotification userScroll = notification;
        switch (userScroll.direction) {
          case ScrollDirection.forward:
            if (userScroll.metrics.maxScrollExtent !=
                userScroll.metrics.minScrollExtent) {
              _fabAnimationController.currentState.animateIn();
            }
            break;
          case ScrollDirection.reverse:
            if (userScroll.metrics.maxScrollExtent !=
                userScroll.metrics.minScrollExtent) {
              _fabAnimationController.currentState.animateOut();
            }
            break;
          case ScrollDirection.idle:
            break;
        }
      }
    }
    return false;
  }

  void _onStartFlight() {
    Navigator.push(
        context,
        PageTransition(
            type: PageTransitionType.downToUp, child: TrackingPage()));
  }

  @override
  void dispose() {
    super.dispose();
    _fabAnimationController.currentState.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Timmer>(builder: (context, timmer, child) {
      return Scaffold(
          drawer: buildDrawer(),
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.blue[400],
            elevation: 0,
            centerTitle: true,
            title: appTitle(),
          ),
          body: ClippedPartsWidget(
            top: Container(
              width: MediaQuery.of(context).size.width,
              height: 150,
              color: Colors.blue[400],
            ),
            bottom: Stack(children: <Widget>[
              Container(
                height: 190,
                color: Colors.blue[100],
              ),
              Container(
                  child: History(
                      onStartFlight: _onStartFlight,
                      timmer: timmer,
                      handleScrollNotification: _handleScrollNotification))
            ]),
            splitFunction: (Size size, double x) {
              // normalizing x to make it exactly one wave
              final normalizedX = x / size.width * 3 * pi;
              final waveHeight = size.height / 40;
              final y = size.height / 14 - sin(cos(normalizedX)) * waveHeight;

              return y;
            },
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: InOutAnimation(
              inDefinition: SlideInUpAnimation(
                  preferences: AnimationPreferences(
                      duration: Duration(milliseconds: 500))),
              outDefinition: SlideOutDownAnimation(
                  preferences: AnimationPreferences(
                      duration: Duration(milliseconds: 500))),
              key: _fabAnimationController,
              child: Visibility(
                visible: timmer.flightHistory.length > 0,
                child: FloatingActionButton.extended(
                    backgroundColor: Colors.green,
                    icon: Icon(Icons.flight_takeoff),
                    onPressed: _onStartFlight,
                    label: Text(
                      'Start a flight',
                      style: TextStyle(fontSize: 20),
                    )),
              )));
    });
  }
}
