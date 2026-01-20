this is a package used to make a widget that can interface with the orchastrator app easily

## Features

this package just declares classes and interfaces required for the widget to work with the app

## Getting started

- add the following to the dependencies section of your pubspec.yaml
    ```yaml
    dependencies:
      flutter_sdk:
        git:
          url: https://github.com/thePrivacyFanatic/orchastrator_sdk.git
    ```
- import orchastrator_sdk.dart in your objective.dart file  
- follow the implementation detailed in the usage section

## Usage

create a class named Objective extending the ObjectiveWidget class in objective.dart

---

the class has just a stream as an attribute and extends StatelessWidget,   
the build method should register for the stream in order to receive signals

IMPORTANT: to ensure consistency across devices the original message is broadcasted with metadata added to its sender as well.  
this should be taken into account when sending a transaction as also adding it offline would cause it to be duplicated

---

to compile the widget to an EVC bytecode file use dart_eval, and running `flutter pub get dart_eval` and `dart pub global activate dart_eval`,  
you can open the the directory in the project where objective.dart is and run `dart_eval compile -o objective.evc`

---

the widgets lifecycle is this:
1. the widget is constructed upon opening the group, and Objective.init(transactions, send) is called on it to initially populate it, where transactions is loaded from a file
2. the widget is built
3. the missed transactions are synchronized and sent to the signal
4. main loop: the widget can call send(transaction) to send messages and has new signals streamed to it (and to the file storing all transactions)


```dart
import 'package:orchastrator_sdk/orchastrator_sdk.dart';
class Objective extends ObjectiveWidget { // state will be managed by the internal widgets
  // your code here
}
```

## Additional information

the EVC bytecode file can be loaded by the app in the admin settings as part of adding an objective

for further research on the topic the app's implementation of widget loading is stored in lib/components/loader.dart
