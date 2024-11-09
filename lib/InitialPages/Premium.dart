import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PremiumPlanPage(),
    );
  }
}

class PremiumPlanPage extends StatelessWidget {
  Widget _buildFeatureCard(
      String icon, String title, String description, String benefit) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9), // Increased opacity of box
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
            color: Color.fromARGB(255, 182, 131, 43)), // Gold outline for boxes
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(
            Icons.star, // Replace with actual relevant icon
            color: Colors.amber, // Golden stars
            size: 40,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  benefit,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF006400), // Darker green shade
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Premium Plan'),
        backgroundColor: Colors.white, // White appbar
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/bg2.png'), // Background image
            fit: BoxFit.cover,
          ),
        ),
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Single box for Heading and Subheading
              Container(
                padding: const EdgeInsets.all(16.0),
                margin: const EdgeInsets.symmetric(vertical: 10.0),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                      color: Color.fromARGB(
                          255, 182, 131, 43)), // Gold outline for box
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Premium Plan Features',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Unlock advanced tools to optimize your health and wellness - all at just INR 199/month 🔥',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // Feature Cards
              _buildFeatureCard(
                'assets/icons/diet_tracking.png',
                'Diet Tracking & Personalized Recommendations',
                'Track your food intake and receive tailored suggestions to optimize your diet.',
                'Stay on track with your nutrition and reach your health goals faster.',
              ),
              _buildFeatureCard(
                'assets/icons/product_recommendations.png',
                'Product Alternative Recommendations',
                'Scan products for healthier alternatives based on nutritional value.',
                'Replace unhealthy options with safer, more nutritious choices.',
              ),
              _buildFeatureCard(
                'assets/icons/nutrient_breakdown.png',
                'Nutrient & Caloric Breakdown',
                'Get detailed nutritional insights to help balance your diet.',
                'Understand how each product fits within your dietary goals.',
              ),
              // _buildFeatureCard(
              //   'assets/icons/health_integration.png',
              //   'Integration with Health & Wellness Devices',
              //   'Sync with wearables to get real-time health data and personalized advice.',
              //   'Optimize your diet and physical activity for better health outcomes.',
              // ),
              _buildFeatureCard(
                'assets/icons/medical_reports.png',
                'Medical Report Uploading',
                'Upload medical reports and get health advice tailored to your needs.',
                'Manage chronic conditions and make informed dietary decisions.',
              ),

              const SizedBox(height: 30),

              // Call to Action Button
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // Handle premium upgrade logic
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(
                        255, 213, 196, 86), // Or another accent color
                    padding: const EdgeInsets.symmetric(
                        vertical: 18, horizontal: 80),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    shadowColor: Colors.black,
                    elevation: 3,
                  ),
                  child: const Text(
                    "Upgrade to Premium",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
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
}
