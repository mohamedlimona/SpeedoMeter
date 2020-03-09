import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Speedometer Demo',
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Speedometer'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Timer _timer;
  double _value = 130;

  _MyHomePageState() {
    _timer = Timer.periodic(const Duration(milliseconds: 1000), (_timer) {
      setState(() {
        _value = (Random().nextDouble() * 40) + 60;
        _value = double.parse(_value.toStringAsFixed(1));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: SfRadialGauge(axes: <RadialAxis>[
          RadialAxis(
              startAngle: 270,
              endAngle: 270,
              minimum: 0,
              maximum: 80,
              interval: 10,
              radiusFactor: 0.4,
              showAxisLine: false,
              showLastLabel: false,
              minorTicksPerInterval: 4,
              majorTickStyle:
                  MajorTickStyle(length: 8, thickness: 3, color: Colors.white),
              minorTickStyle:
                  MinorTickStyle(length: 3, thickness: 1.5, color: Colors.grey),
              axisLabelStyle: GaugeTextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14),
              onLabelCreated: labelCreated),
          RadialAxis(
              minimum: 0,
              maximum: 200,
              labelOffset: 30,
              axisLineStyle: AxisLineStyle(
                  thicknessUnit: GaugeSizeUnit.factor, thickness: 0.03),
              majorTickStyle:
                  MajorTickStyle(length: 6, thickness: 4, color: Colors.white),
              minorTickStyle:
                  MinorTickStyle(length: 3, thickness: 3, color: Colors.white),
              axisLabelStyle: GaugeTextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14),
              ranges: <GaugeRange>[
                GaugeRange(
                    startValue: 0,
                    endValue: 200,
                    sizeUnit: GaugeSizeUnit.factor,
                    startWidth: 0.03,
                    endWidth: 0.03,
                    gradient: SweepGradient(colors: const <Color>[
                      Colors.green,
                      Colors.yellow,
                      Colors.red
                    ], stops: const <double>[
                      0.0,
                      0.5,
                      1
                    ]))
              ],
              pointers: <GaugePointer>[
                NeedlePointer(
                    value: _value,
                    needleLength: 0.95,
                    enableAnimation: true,
                    animationType: AnimationType.ease,
                    needleStartWidth: 1.5,
                    needleEndWidth: 6,
                    needleColor: Colors.red,
                    knobStyle: KnobStyle(
                        knobRadius: 0.09, sizeUnit: GaugeSizeUnit.factor))
              ],
              annotations: <GaugeAnnotation>[
                GaugeAnnotation(
                    widget: Container(
                        child: Column(children: <Widget>[
                      Text(_value.toString(),
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold)),
                      SizedBox(height: 20),
                      Text('mph',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold))
                    ])),
                    angle: 90,
                    positionFactor: 0.75)
              ])
        ]));
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void labelCreated(AxisLabelCreatedArgs args) {
    if (args.text == '0') {
      args.text = 'N';
      args.labelStyle = GaugeTextStyle(
          color: Colors.red, fontWeight: FontWeight.bold, fontSize: 14);
    } else if (args.text == '10')
      args.text = '';
    else if (args.text == '20')
      args.text = 'E';
    else if (args.text == '30')
      args.text = '';
    else if (args.text == '40')
      args.text = 'S';
    else if (args.text == '50')
      args.text = '';
    else if (args.text == '60')
      args.text = 'W';
    else if (args.text == '70') args.text = '';
  }
}
