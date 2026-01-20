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

implement the "Channel" interface in your "Objective" class and compile the widget into EVC bytecode

---

the interface currently has just 3 functions:  
- `void init(String state, Function(String transaction) send, Stream<Signal> missedTransactions)`
  - state is a string that describes the current state of the widget
  - send is a callback used by the widget afterwards to send a string of data to the other instances  
  of the same widget type across the different users
  - missedTransactions is a stream of signals that should be synchronized with the current state
- `void receive(Signal transaction)`
  - a function that receives a signal with sent data in the content field and a metadata object with the server-added timestamp, 
  sid and uid of sender and changes the state of the widget accordingly
- `String dump()`
  - a function that is called upon the apps closure to get the objective's state and commit it to the database  

IMPORTANT: to ensure consistency and reliability the original message is echoed back to its sender too with relevant data.  
this should be taken into account when sending a transaction as adding it offline as well would cause it to be duplicated

NOTE: while the interface allows the app to use any arbitrary string for state/Signal.content,  
it's generally preferred to use json for the data for uniformity and readability.

---

to compile the widget to an EVC bytecode file use dart_eval, and running `flutter pub get dart_eval` and `dart pub global activate dart_eval`,  
you can open the the directory in the project where objective.dart is and run `dart_eval compile -o objective.evc`

---

the widgets lifecycle is this:
1. the widget is created upon opening the group it is a part of and Objective.init(savedState, send) is called on it to initially build it
2. the missed transactions are fetched and Objective.sync(transactions) is called to update it
3. main loop: the widget can call send(transaction) to send messages and has Objective.receive(transaction) called to change its own state
4. onDetach is called which prompts Objective.dump() to be called on the widget, on the next open savedState will be set to the returned string

in objective.dart 

```dart
class Objective extends Widget implements Channel { // state can also be managed by a more internal widget
  // your code here
}
```

## Additional information

the EVC bytecode file can be loaded by the app in the admin settings as part of adding an objective

for further research on the topic the app's implementation of widget loading is stored in lib/components/loader.dart
