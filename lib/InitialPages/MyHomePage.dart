import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/InitialPages/Blog.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:flutter_application_1/InitialPages/Profile.dart';
import 'package:flutter_application_1/InitialPages/Premium.dart';

class MyHomePage extends StatefulWidget {
  final String username;

  MyHomePage({required this.username});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late PageController _pageController;
  int _currentPageIndex = 0;
  List<String> _carouselItems = ["News", "Blog", "Research"];
  List<String> _newsTitles = [];
  List<Map<String, String>> _researchPapers = [];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentPageIndex);
    _startCarousel();
    _fetchNews();
    _fetchResearchPapers();
  }

  Future<void> _fetchNews() async {
    const apiKey = '0c8df587446941f282f38555606b70bd';
    const apiUrl =
        'https://newsapi.org/v2/everything?q=food%20contamination%20OR%20food%20safety%20OR%20food%20recalls&language=en&apiKey=$apiKey';
    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final articles = data['articles'] as List;

        setState(() {
          _newsTitles =
              articles.map((article) => article['title'].toString()).toList();
          _carouselItems = _newsTitles;
        });
      } else {
        print("Failed to load news");
      }
    } catch (e) {
      print("Error fetching news: $e");
    }
  }

  Future<void> _fetchResearchPapers() async {
    setState(() {
      _researchPapers = [
        {
          'title': 'Food Scanner App Impact on Healthy Food Choice',
          'pdfLink': 'WhatsInMyFood-main/assets/research_paper/F2.pdf'
        },
        {
          'title':
              'A Mobile Adviser of Healthy Eating by Reading Ingredient Labels',
          'pdfLink': 'WhatsInMyFood-main/assets/research_paper/F1.pdf'
        },
        {
          'title':
              'A Comprehensive Review on Barcode TEchnologies in the Context of Food Labeling',
          'pdfLink': 'WhatsInMyFood-main/assets/research_paper/F2.pdf'
        },
      ];
    });
  }

  void _startCarousel() {
    Timer.periodic(const Duration(seconds: 5), (timer) {
      if (_currentPageIndex < _carouselItems.length - 1) {
        _currentPageIndex++;
      } else {
        _currentPageIndex = 0;
      }
      _pageController.animateToPage(
        _currentPageIndex,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

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
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PremiumPlanPage()),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfilePage()),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.home),
            onPressed: () {
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
            child: SingleChildScrollView(
              // Added SingleChildScrollView
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 16),
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
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.black, width: 1),
                      ),
                      child: const Center(
                        child: Text(
                          "Search Products 🔍",
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
                  const Text(
                    "News 📰",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    height: 120,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.blueAccent.shade100,
                          Colors.blueAccent.shade400
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: PageView.builder(
                      controller: _pageController,
                      itemCount: _carouselItems.length,
                      itemBuilder: (context, index) {
                        return _buildCarouselItem(
                            context, _carouselItems[index]);
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    "Research Backing Us 🔬",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: _researchPapers.map((paper) {
                        return SizedBox(
                          width: MediaQuery.of(context).size.width / 3 - 24,
                          child: _buildResearchPaperItem(context, paper),
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // const Text(
                  //   "Find Blogs",
                  //   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  // ),
                  const SizedBox(height: 8),
                  GestureDetector(
                    onTap: () {
                      // Navigate to Blogs page or open a new page with blog list
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => BlogPostPage()),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.black, width: 1),
                      ),
                      child: const Center(
                        child: Text(
                          "Explore Blogs 🖋️",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 200),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRoundButton(BuildContext context, String label, IconData icon) {
    return GestureDetector(
      onTap: () {},
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

  Widget _buildCarouselItem(BuildContext context, String title) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(16),
        color: Colors.transparent,
        child: Text(
          title,
          style: const TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildResearchPaperItem(
      BuildContext context, Map<String, String> paper) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PDFViewerPage(pdfLink: paper['pdfLink']!),
          ),
        );
      },
      child: Container(
        width: MediaQuery.of(context).size.width / 3 - 24,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.8),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.black, width: 1),
        ),
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(
              Icons.picture_as_pdf,
              size: 40,
              color: Colors.red,
            ),
            const SizedBox(height: 8),
            Text(
              paper['title']!,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

class PDFViewerPage extends StatelessWidget {
  final String pdfLink;

  PDFViewerPage({required this.pdfLink});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Research Paper')),
      body: PDFView(
        filePath: pdfLink,
      ),
    );
  }
}
