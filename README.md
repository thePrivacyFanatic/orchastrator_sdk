this is a package used to make a widget that can interface with the orchastrator app easily

## Features

this package just declares the interface the widget would need to implement

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
- `void init(String state, Function(String transaction) send)`
  - state is a string that describes the current state of the widget
  - send is a callback used by the widget afterwards to send a string of data to the other instances  
  of the same widget type across the different users
- `void receive(String transaction)`
  - a function that receives the string of data describing a transaction and changes the state of the widget accordingly
- `String dump()`
  - a function that is called upon the apps closure to get the objective's state and commit it to the database  

NOTE: while the interface allows the app tto use any arbitrary string for state/transaction,  
it's generally preferred to use json for the data for uniformity and readability.

---

to compile the widget to an EVC bytecode file use dart_eval, and running `flutter pub get dart_eval` and `dart pub global activate dart_eval`,  
you can open the the directory in the project where objective.dart is and run `dart_eval compile -o objective.evc`

---

the widgets lifecycle is this:
1. the widget is created upon opening the group it is a part of and init(savedState, send) is called on it to initially build it
2. the widget calls send(transaction) to send message and has receive(transaction) called to change it's own state
3. onDetach is called which prompts dump() to be called on the widget, on the next open savedState will be set to the returned string

in objective.dart 

```dart
class Objective extends Widget implements Channel { // state can also be managed by a more internal widget
  // your code here
}
```

## Additional information

the EVC bytecode file can be loaded by the app in the admin settings as part of adding an objective

for further research on the topic the app's implementation of widget loading is stored in lib/components/loader.dart
(TODO: make this actually exist)
