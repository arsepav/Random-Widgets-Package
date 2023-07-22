# Animated Random Button Flutter Package

![Flutter Version](https://img.shields.io/badge/flutter-%5E2.0.0-blue)
![License](https://img.shields.io/badge/license-MIT-green)

The Animated Random Button Flutter Package provides a set of four animated buttons that generate random values for different scenarios. The buttons included are:

1. Coin Button: Gives random output of "Odd" or "Even" when pressed.
2. Dice Button: Gives a random value between 1 and 6 when pressed by default, but range can be changed.
3. Spinning Wheel Button: Gives a random passed color when pressed.
4. Magic 8-Ball Button: Gives a random answer like a classic magic 8-ball toy when pressed.

## Installation

Add the following line to your `pubspec.yaml` file:

```yaml
dependencies:
  animated_random_buttons: ^1.0.0
```

Then run `flutter pub get` in your terminal to install the package.

## Usage

Import the package in your Dart file:

```dart
import 'package:animated_random_buttons/animated_random_buttons.dart';
```

### Coin Button

The Coin button can be used as follows:

```dart
CoinButton(
  onPressed: () {},
  radius: 100,
  coin: Coins.Cent,
  duration: const Duration(seconds: 2),
),
```

### Dice Button

The Dice button can be used as follows:

```dart
BouncingDiceButton(
  start: 1, // by default
  end: 6, // by default
  duration: Duration(milliseconds: 500),
  onPressed: () {
    print("hello");
  },
),
```

### Spinning Wheel Button

The Spinning Wheel button can be used as follows:

```dart
RandomColorWheel(
  colors: const [
    Colors.black,
    Colors.amber,
    Colors.black12,
    Color(0xFF9D53CC),
  ],
  size: 100,
  onPressed: () {
    print("Wheel is spinning");
  },
  duration: const Duration(seconds: 1),
  waitForAnimation: false,
),
```

### Magic 8-Ball Button

The Magic 8-Ball button can be used as follows:

```dart
Magic8Ball(
  radius: 100,
  shakeDistance: 15,
  numberOfShakes: 10,
  durationOfShake: Duration(milliseconds: 100),
  answers: ["yes", "no"], // default answers can be used
),
```

## Customization

You can change duration of animation, change sample and size of button.

## Example

For a more comprehensive example of how to use the Animated Random Button package, check the `example` folder provided in the package.

## License

This package is open-source and available under the MIT License. See the [LICENSE](LICENSE) file for more information.