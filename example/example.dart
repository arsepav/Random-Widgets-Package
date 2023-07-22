import 'package:diceandcoin/BouncingDiceButton.dart';
import 'package:diceandcoin/CoinButton.dart';
import 'package:flutter/material.dart';
import '../lib/RandomColorfulWheel.dart';
import '../lib/magic_sphere.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Example for Random Widget Tools package',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Example for Random Widget Tools package'),
        ),
        body: Center(
            child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 100,
              ),
              RandomColorWheel(
                colors: const [
                  Colors.black,
                  Colors.amber,
                  Colors.black12,
                  Color(0xFF9D53CC),
                  Color(0xFF67508D),
                  Color(0xff141460),
                  Color.fromRGBO(10, 186, 181, 1),
                ],
                size: 100,
                onPressed: () {
                  print("Wheel is spinning");
                },
                duration: const Duration(seconds: 1),
                waitForAnimation: false,
              ),
              const SizedBox(
                width: 30,
                height: 30,
              ),
              const SizedBox(
                height: 50,
              ),
              BouncingDiceButton(
                start: 1,
                end: 6,
                duration: Duration(milliseconds: 500),
                onPressed: () {
                  print("hello");
                },
              ),
              const SizedBox(
                height: 50,
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CoinButton(
                    onPressed: () {},
                    radius: 100,
                    coin: Coins.Euro,
                    duration: const Duration(seconds: 2),
                  ),
                  const SizedBox(
                    width: 25,
                  ),
                  CoinButton(
                    onPressed: () {},
                    radius: 100,
                    coin: Coins.Ruble,
                    duration: const Duration(seconds: 2),
                  ),
                  const SizedBox(
                    width: 25,
                  ),
                  CoinButton(
                    onPressed: () {},
                    radius: 100,
                    coin: Coins.Cent,
                    duration: const Duration(seconds: 2),
                  ),
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              const Magic8Ball(
                radius: 100,
                shakeDistance: 15,
                numberOfShakes: 10,
                durationOfShake: Duration(milliseconds: 100),
                answers: ["yes", "definetly yes"],
              ),
              const SizedBox(
                height: 50,
              ),
            ],
          ),
        )),
      ),
    );
  }
}
