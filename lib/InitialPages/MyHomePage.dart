import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyHomePage extends StatefulWidget {
  final String username;

  MyHomePage({required this.username});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage("assets/user_icon.png"),
              radius: 16,
            ),
            const SizedBox(width: 8),
            Text(
              'Hello, ${widget.username}',
              style: const TextStyle(color: Colors.black),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () {
              // Add your onPressed logic for the heart icon here
            },
          ),
          IconButton(
            icon: const Icon(Icons.home),
            onPressed: () {
              // Navigates to the homepage (same page)
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        MyHomePage(username: widget.username)),
              );
            },
          ),
        ],
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 16),

                // Scan Barcode and Scan Ingredients Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildRoundButton(
                        context, "Scan Barcode", Icons.qr_code_scanner),
                    _buildRoundButton(
                        context, "Scan Ingredients", Icons.list_alt),
                  ],
                ),

                const SizedBox(height: 16),

                // Search Products Button
                GestureDetector(
                  onTap: () {
                    // Navigate to the search products page
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Center(
                      child: Text(
                        "Search Products",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // Carousel for News, Blog, Research
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildCarouselItem(context, "News"),
                    _buildCarouselItem(context, "Blog"),
                    _buildCarouselItem(context, "Research"),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Helper method for the round buttons
  Widget _buildRoundButton(BuildContext context, String label, IconData icon) {
    return GestureDetector(
      onTap: () {
        // Define what happens when the button is tapped
      },
      child: Container(
        width: 170,
        height: 120,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.8),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.black, width: 1),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.black, size: 32),
            const SizedBox(height: 8),
            Text(
              label,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper method for carousel items
  Widget _buildCarouselItem(BuildContext context, String title) {
    return GestureDetector(
      onTap: () {
        // Define the navigation for each carousel item
      },
      child: Container(
        width: 120,
        height: 120,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.8),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.black, width: 1),
        ),
        child: Center(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
