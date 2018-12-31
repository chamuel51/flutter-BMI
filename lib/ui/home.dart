import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new HomeState();
  }
}

class HomeState extends State<Home> {
  String _bmiCalculatedText = '';
  double bmiTotal = 0;
  String _messageBMI = '';

  final TextEditingController _ageController = new TextEditingController();
  final TextEditingController _heightController = new TextEditingController();
  final TextEditingController _weightController = new TextEditingController();

  void handleCategoryValueChanged() {
    setState(() {


      if (bmiTotal < 18.5) {
        _messageBMI = 'Underweight';
      } else if (bmiTotal >= 18.5 && bmiTotal <= 24.9) {
        _messageBMI = 'Normal';
      } else if (bmiTotal > 24.9 && bmiTotal <= 29.9) {
        _messageBMI = 'Overweight';
      } else {
        _messageBMI = 'Obese';
      }
    });


  }

  void handleBMIchanged() {

    setState(() {
      _bmiCalculatedText = bmiTotal.toStringAsFixed(2);

    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text("BMI"),
          backgroundColor: Colors.pinkAccent,
          centerTitle: true,
        ),
        body: new ListView(
          children: <Widget>[
            new Container(
              alignment: Alignment.topCenter,
              child: new Image.asset(
                "images/bmilogo.png",
                height: 100,
                width: 130,
              ),
            ),
            new Container(
              margin: const EdgeInsets.all(3.0),
              padding: const EdgeInsets.all(4.0),
              color: Colors.black12,
              child: new Column(
                children: <Widget>[
                  new TextField(
                    controller: _ageController,
                    keyboardType: TextInputType.number,
                    decoration: new InputDecoration(
                      icon: Icon(Icons.person_outline),
                      hintText: "Age",
                      labelText: "Age",
                    ),
                  ),
                  new TextField(
                    controller: _heightController,
                    keyboardType: TextInputType.number,
                    decoration: new InputDecoration(
                        icon: Icon(Icons.insert_chart),
                        hintText: "Height in inches",
                        labelText: "Heigh in inches"),
                  ),
                  new TextField(
                    controller: _weightController,
                    keyboardType: TextInputType.number,
                    decoration: new InputDecoration(
                        icon: Icon(Icons.line_weight),
                        hintText: "Weight in lb",
                        labelText: "Weight in lb",
                        fillColor: Colors.greenAccent),
                  ),
                  new Padding(padding: EdgeInsets.all(5.0)),
                  new RaisedButton(
                    onPressed: calculateBMI,
                    color: Colors.pinkAccent,
                    textColor: Colors.white,
                    child: new Text(
                      "Calculate",
                    ),
                  ),
                ],
              ),
            ),
            new Text(
              "Your BMI: $_bmiCalculatedText",
              textAlign: TextAlign.center,
              style: new TextStyle(
                  color: Colors.blue,
                  fontSize: 19.9,
                  fontWeight: FontWeight.w500,
                  fontStyle: FontStyle.italic),
            ),
            new Padding(padding: EdgeInsets.only(top: 10)),
            new Text(
              _messageBMI,
              textAlign: TextAlign.center,
              style: new TextStyle(
                color: Colors.pinkAccent,
                fontSize: 16.9,
                fontWeight: FontWeight.w500,
              ),
            )
          ],
        ));
  }

  double calculateBMI() {


    double weight = double.tryParse(_weightController.text.toString());
    double height = double.tryParse(_heightController.text.toString());

    if (weight.toString().isNotEmpty && weight > 0
        && height.toString().isNotEmpty && height> 0) {
      bmiTotal =(weight / (height * height)) *
          703;

      handleCategoryValueChanged();
      handleBMIchanged();

      return bmiTotal;
    }

    else{
      debugPrint("Wrong!!");
      handleBMIchanged();
      handleCategoryValueChanged();

      return 0;
    }
  }
}
