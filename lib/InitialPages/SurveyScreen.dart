import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SurveyScreen extends StatefulWidget {
  @override
  _SurveyScreenState createState() => _SurveyScreenState();
}

class _SurveyScreenState extends State<SurveyScreen> {
  List<String> selectedAllergies = [];
  List<String> selectedHealthConcerns = [];
  String? selectedGoal;
  String? selectedPeople;
  String otherAllergy = '';
  String otherHealthConcern = '';

  // Method to handle allergy selection
  void _onAllergySelected(String value) {
    setState(() {
      if (selectedAllergies.contains(value)) {
        selectedAllergies.remove(value);
        if (value == 'Other (please specify)') {
          otherAllergy = ''; // Clear "Other" text when unchecked
        }
      } else {
        selectedAllergies.add(value);
        if (value == 'Other (please specify)') {
          otherAllergy = ''; // Ensure the "Other" field is cleared
        }
      }
    });
  }

  // Method to handle health concern selection
  void _onHealthConcernSelected(String value) {
    setState(() {
      if (selectedHealthConcerns.contains(value)) {
        selectedHealthConcerns.remove(value);
        if (value == 'Other (please specify)') {
          otherHealthConcern = ''; // Clear "Other" text when unchecked
        }
      } else {
        selectedHealthConcerns.add(value);
        if (value == 'Other (please specify)') {
          otherHealthConcern = ''; // Ensure the "Other" field is cleared
        }
      }
    });
  }

  // Method to handle radio selection for goals and number of people
  void _onRadioSelected(String? value, String type) {
    setState(() {
      if (type == "goal") {
        selectedGoal = value;
      } else if (type == "people") {
        selectedPeople = value;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Survey'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
        ),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Opacity(
              opacity: 0.7,
              child: Image.asset(
                "assets/bg2.png",
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const Center(
                      child: Text("Image not found or loading error."));
                },
              ),
            ),
          ),
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Welcome to What's In My Food!",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Let's get you started towards a healthier life!",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 30),
                const Text("What should we call you?",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black)),
                TextField(
                  decoration: InputDecoration(
                    hintText: "Enter your name",
                    fillColor: Colors.white.withOpacity(0.8),
                    filled: true,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                const SizedBox(height: 20),
                const Text("Can you tell us about any allergies you may have?",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black)),
                Column(
                  children: [
                    _buildCheckBoxOption('Peanuts', selectedAllergies),
                    _buildCheckBoxOption('Shellfish', selectedAllergies),
                    _buildCheckBoxOption('Milk', selectedAllergies),
                    _buildCheckBoxOption('Eggs', selectedAllergies),
                    _buildCheckBoxOption('Wheat', selectedAllergies),
                    _buildCheckBoxOption(
                        'Other (please specify)', selectedAllergies),
                    // Show text field for "Other" allergy
                    if (selectedAllergies.contains('Other (please specify)'))
                      TextField(
                        onChanged: (value) {
                          setState(() {
                            otherAllergy = value;
                          });
                        },
                        decoration: InputDecoration(
                          hintText: "Please specify",
                          fillColor: Colors.white.withOpacity(0.8),
                          filled: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 20),
                const Text("What are some health issues that concern you?",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black)),
                Column(
                  children: [
                    _buildCheckBoxOption(
                        'Heart Disease', selectedHealthConcerns),
                    _buildCheckBoxOption('Diabetes', selectedHealthConcerns),
                    _buildCheckBoxOption(
                        'High Blood Pressure', selectedHealthConcerns),
                    _buildCheckBoxOption('Obesity', selectedHealthConcerns),
                    _buildCheckBoxOption('Cancer', selectedHealthConcerns),
                    _buildCheckBoxOption(
                        'Other (please specify)', selectedHealthConcerns),
                    // Show text field for "Other" health concern
                    if (selectedHealthConcerns
                        .contains('Other (please specify)'))
                      TextField(
                        onChanged: (value) {
                          setState(() {
                            otherHealthConcern = value;
                          });
                        },
                        decoration: InputDecoration(
                          hintText: "Please specify",
                          fillColor: Colors.white.withOpacity(0.8),
                          filled: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 20),
                const Text("What are your goals with this app?",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black)),
                Column(
                  children: [
                    _buildRadioOption('Eating Green', "goal"),
                    _buildRadioOption('Less Unhealthy Food', "goal"),
                    _buildRadioOption('Eating Safer and More Organic', "goal"),
                  ],
                ),
                const SizedBox(height: 20),
                const Text("How many people do you live with/shop for?",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black)),
                Column(
                  children: [
                    _buildRadioOption('0', "people"),
                    _buildRadioOption('1', "people"),
                    _buildRadioOption('2', "people"),
                    _buildRadioOption('3', "people"),
                    _buildRadioOption('4', "people"),
                    _buildRadioOption('5', "people"),
                  ],
                ),
                const SizedBox(height: 40),
                Center(
                  child: SizedBox(
                    width: 250,
                    height: 60,
                    child: OutlinedButton(
                      onPressed: () {
                        // Handle survey submission (navigate or save data)
                      },
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.white,
                        side: const BorderSide(color: Colors.black, width: 2),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                      ),
                      child: const Text(
                        "Submit Survey",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCheckBoxOption(String text, List<String> selectedOptions) {
    return CheckboxListTile(
      title: Text(text, style: const TextStyle(color: Colors.black)),
      value: selectedOptions.contains(text),
      onChanged: (bool? newValue) {
        setState(() {
          if (newValue == true) {
            selectedOptions.add(text);
          } else {
            selectedOptions.remove(text);
          }
        });
      },
      controlAffinity: ListTileControlAffinity.leading,
      activeColor: Colors.green,
      checkColor: Colors.white,
    );
  }

  Widget _buildRadioOption(String text, String type) {
    return RadioListTile<String>(
      title: Text(text, style: const TextStyle(color: Colors.black)),
      value: text,
      groupValue: type == "goal" ? selectedGoal : selectedPeople,
      onChanged: (String? value) {
        _onRadioSelected(value, type);
      },
    );
  }
}
