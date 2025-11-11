# hotspothosts
Folder Structure:
lib/
  -main.dart
  api/-api-service.dart
  riverpod/-answer_state.dart
           -riverpod_state.dart
  Screens/All Screens         

  Above Folder Structure show the seperate Modules of the Assignment 
  In Api/Api_service.dart dio dependency is used to fethch the response and used in sliders in screens to display the cards
  riverpod is used to save the ids of hotspots and save text entered by user, also state management with operational LinearProgressIndicator for Manuvering from 
  One screen to another Handled the state changes with button clicks and gesture taps, Experience Screen consist of Textfield with 10 lnes MaxLenth and 600  maxwords
  Dummy audio recorded and video recorded modules are shown just below the textfield while disabling other button
  To run App locally
  Use following Commands
  git clone https://github.com/yourusername/hotspot-host-onboarding.git
  cd hotspot-host-onboarding
  flutter pub get
  flutter run 


  Below are Some Screenshots of working app

  
  
  
## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
