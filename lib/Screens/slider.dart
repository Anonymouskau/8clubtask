import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hotspothosts/api_service.dart';
import '../riverpod/riverpod_stateprovider.dart';

class ExperienceSliderScreen extends ConsumerStatefulWidget {
  const ExperienceSliderScreen({super.key});

  @override
  ConsumerState<ExperienceSliderScreen> createState() => _ExperienceSliderScreenState();
}

class _ExperienceSliderScreenState extends ConsumerState<ExperienceSliderScreen> {
  final TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    descriptionController.addListener(() {
      ref.read(descriptionProvider.notifier).state = descriptionController.text.trim();
    });
    loadData();
  }

  Future<void> loadData() async {
    final data = await ApiService().fetchExperiences();
    ref.read(experiencesProvider.notifier).state = data;
  }

  void toggleSelection(int id) {
    final selected = ref.read(selectedExperienceIdsProvider.notifier);
    final list = [...selected.state];

    list.contains(id) ? list.remove(id) : list.add(id);
    selected.state = list;
  }

  @override
  Widget build(BuildContext context) {
    final experiences = ref.watch(experiencesProvider);
    final selectedIds = ref.watch(selectedExperienceIdsProvider);
    final description = ref.watch(descriptionProvider);

    final bool isFilled = selectedIds.isNotEmpty && description.isNotEmpty;

    return Scaffold(
      backgroundColor: Colors.black,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // Title
              Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
                child: const Text(
                  "What kind of Hotspots do you want to host?",
                  style: TextStyle(
                    fontFamily: 'SpaceGrotesk',
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.8,
                    color: Colors.white,
                  ),
                ),
              ),

              const SizedBox(height: 10),

              // Slider Cards
              experiences.isEmpty
                  ? const Center(child: Padding(
                      padding: EdgeInsets.only(top: 40),
                      child: CircularProgressIndicator(),
                    ))
                  : SizedBox(
                      height: 120,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.only(left: 16),
                        children: experiences.map((exp) {
                          final int id = exp["id"] is int ? exp["id"] : int.tryParse(exp["id"].toString()) ?? -1;

                          final bool isSelected = selectedIds.contains(id);

                          return _experienceCard(
                            imageUrl: exp["image_url"],
                            isSelected: isSelected,
                            onTap: () => toggleSelection(id),
                          );
                        }).toList(),
                      ),
                    ),

              const SizedBox(height: 12),

              // Description Input
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TextField(
                  controller: descriptionController,
                  maxLength: 250,
                  maxLines: 4,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: "/ Describe your perfect hotspot",
                    hintStyle: const TextStyle(color: Colors.white54),
                    filled: true,
                    fillColor: const Color(0xFF1A1A1A),
                    counterStyle: const TextStyle(color: Colors.white54),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Colors.white24),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              // Next Button
              Center(
                child: GestureDetector(
                  onTap: isFilled
                      ? () {
          // Print values (optional debugging)
          print("✅ Selected IDs: $selectedIds");
          print("✅ Description: $description");

          // --- Update Progress ---
          final current = ref.read(progressProvider);
          ref.read(progressProvider.notifier).state =
              (current + 0.4).clamp(0.0, 1.0); 
          ref.read(currentStepProvider.notifier).state = 1;
          // --- Navigate to next (if needed) ---
          // Navigator.push(context, MaterialPageRoute(builder: (_) => NextScreen()));
        }
      : null,
                  child: Container(
                    width: 360,
                    height: 56,
                    decoration: BoxDecoration(
                      color: const Color(0xFF2A2A2A),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Center(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Next",
                            style: TextStyle(
                              fontFamily: 'SpaceGrotesk',
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: isFilled
                                  ? Colors.white
                                  : Colors.white.withOpacity(0.24),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Icon(
                            Icons.arrow_forward_sharp,
                            size: 22,
                            color: isFilled
                                ? Colors.white
                                : Colors.white.withOpacity(0.24),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _experienceCard({
    required String imageUrl,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 100,
        margin: const EdgeInsets.only(right: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
            color: isSelected ? const Color(0xFF9196FF) : Colors.transparent,
            width: 2,
          ),
          image: DecorationImage(
            image: NetworkImage(imageUrl),
            fit: BoxFit.cover,
            colorFilter: isSelected
                ? null
                : const ColorFilter.mode(Colors.grey, BlendMode.saturation),
          ),
        ),
      ),
    );
  }
}
