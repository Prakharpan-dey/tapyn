import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';

class FlippingProfileCard extends StatefulWidget {
  const FlippingProfileCard({super.key});

  @override
  _FlippingProfileCardState createState() => _FlippingProfileCardState();
}

class _FlippingProfileCardState extends State<FlippingProfileCard> {
  bool isFlipped = false;

  void flipCard() {
    setState(() {
      isFlipped = !isFlipped;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: flipCard, // Tap to flip
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 600),
          transform: Matrix4.rotationY(isFlipped ? pi : 0),
          child: isFlipped ? _buildBackCard() : _buildFrontCard(),
        ),
      ),
    );
  }

  Widget _buildFrontCard() {
    return GlassMorphismContainer(
      child: Column(
        children: [
          const CircleAvatar(
            radius: 50,
            backgroundImage: NetworkImage('https://via.placeholder.com/150'), // Add your profile image here
          ),
          const SizedBox(height: 16),
          const Text(
            "Someone's Name",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "Designer / Developer",
            style: TextStyle(
              color: Colors.grey[400],
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 16),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.favorite, color: Colors.white),
              SizedBox(width: 8),
              Text(
                "1000+",
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(width: 16),
              Icon(Icons.share, color: Colors.white),
              SizedBox(width: 8),
              Text(
                "1500+",
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(width: 16),
              Icon(Icons.chat_bubble, color: Colors.white),
              SizedBox(width: 8),
              Text(
                "850+",
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.facebook, color: Colors.white),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.wb_twighlight, color: Colors.white),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.insert_chart, color: Colors.white),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.youtube_searched_for, color: Colors.white),
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBackCard() {
    return GlassMorphismContainer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Back of the card",
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            "Additional Information here",
            style: TextStyle(
              color: Colors.grey[400],
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}

class GlassMorphismContainer extends StatelessWidget {
  final Widget child;

  const GlassMorphismContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white.withOpacity(0.1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: Colors.white.withOpacity(0.2),
                width: 1.5,
              ),
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}


