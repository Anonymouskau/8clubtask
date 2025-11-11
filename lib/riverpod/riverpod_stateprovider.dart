import 'dart:ffi';

import 'package:flutter_riverpod/flutter_riverpod.dart';

// Stores full experience list
final experiencesProvider = StateProvider<List<dynamic>>((ref) => []);

// Stores selected experience IDs
final selectedExperienceIdsProvider = StateProvider<List<int>>((ref) => []);

// Stores the description text
final descriptionProvider = StateProvider<String>((ref) => "");
// Tracks progress from 0.0 → 1.0
final progressProvider = StateProvider<double>((ref) => 0.33); 
final currentStepProvider = StateProvider<int>((ref) => 0);
  
final audioRecordedProvider = StateProvider<bool>((ref) => false);
final videoRecordedProvider = StateProvider<bool>((ref) => false);
