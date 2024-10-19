import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore package
import 'package:tapyn/Pages/login_page.dart';
import 'package:qr_flutter/qr_flutter.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final User? user = FirebaseAuth.instance.currentUser;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Map<String, String>> _links = []; // Initialize as an empty list

  @override
  void initState() {
    super.initState();
    _loadLinks(); // Load links when the app starts
  }

  void signUserOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => LoginPage(onTap: () {}),
      ),
    );
  }

  void _addLink(String link) {
  if (user != null && link.isNotEmpty) {
    Map<String, String> linkInfo = _getLinkInfo(link);
    _firestore.collection('users').doc(user!.uid).collection('links').add(linkInfo).then((docRef) {
      setState(() {
        _links.add({...linkInfo, 'docId': docRef.id}); // Add the document ID to the link info
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Link added successfully!')),
      );
    }).catchError((e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to add link: $e')),
      );
    });
  } else if (user == null) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Please log in to add links.')),
      );
    }
  }


  Map<String, String> _getLinkInfo(String link) {
    String name = '';
    String iconPath = '';

    if (link.contains('linkedin.com')) {
      name = 'LinkedIn';
      iconPath = 'images/linkedin.png';
    } else if (link.contains('instagram.com')) {
      name = 'Instagram';
      iconPath = 'images/instagram.png';
    } else if (link.contains('twitter.com')) {
      name = 'Twitter';
      iconPath = 'images/twitter.png';
    } else if (link.contains('github.com')) {
      name = 'GitHub';
      iconPath = 'images/github.png';
    } else {
      name = 'Link';
      iconPath = 'images/link.png';
    }

    return {'name': name, 'link': link, 'icon': iconPath};
  }

  Future<void> _showLinkInputDialog(BuildContext context) async {
    final TextEditingController _linkController = TextEditingController();

    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Enter a Link'),
          content: TextField(
            controller: _linkController,
            decoration: const InputDecoration(hintText: 'Link'),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Add'),
              onPressed: () {
                _addLink(_linkController.text);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _deleteLink(String docId) {
    _firestore.collection('links').doc(docId).delete().then((_) {
      setState(() {
        _links.removeWhere((link) => link['docId'] == docId);
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Link deleted successfully!')),
      );
    });
  }
  Future<void> _loadLinks() async {
    if (user != null) {
      try {
        QuerySnapshot querySnapshot = await _firestore.collection('users').doc(user!.uid).collection('links').get();
        setState(() {
          _links = querySnapshot.docs.map((doc) {
            var data = doc.data() as Map<String, dynamic>;
            return {
              'name': data['name'] as String? ?? '',
              'link': data['link'] as String? ?? '',
              'icon': data['icon'] as String? ?? '',
              'docId': doc.id, // You can keep the docId if needed
            };
          }).toList();
        });
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error loading links: $e')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please log in to load links.')),
      );
    }
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Home Page',
          style: TextStyle(fontSize: 20),
        ),
        actions: [
          IconButton(
            onPressed: () => signUserOut(context),
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Text(
              user != null ? "LOGGED IN AS: ${user!.email}" : "No user logged in",
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: _links.length,
                itemBuilder: (context, index) {
                  return LinkCard(
                    linkInfo: _links[index],
                    onDelete: () => _deleteLink(_links[index]['docId']!), // Pass document ID for deletion
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showLinkInputDialog(context),
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: const Icon(Icons.home),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}

class LinkCard extends StatelessWidget {
  final Map<String, String> linkInfo;
  final VoidCallback onDelete; // Callback for deleting the card

  const LinkCard({super.key, required this.linkInfo, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Show QR code in a dialog
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            content: SizedBox(
              width: 200,
              height: 200,
              child: Center(
                child: QrImageView(
                  data: linkInfo['link']!,
                  version: QrVersions.auto,
                  size: 200.0,
                  gapless: false,
                  backgroundColor: Colors.white,
                ),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Close'),
              ),
            ],
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: const LinearGradient(
            colors: [Colors.pinkAccent, Colors.blueAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 5,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Image.asset(
                    linkInfo['icon']!, // Load the appropriate icon
                    width: 30,
                    height: 30,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    linkInfo['name']!,
                    style: const TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ],
              ),
              IconButton(
                icon: const Icon(Icons.delete, color: Colors.white),
                onPressed: onDelete, // Call the delete function when pressed
              ),
            ],
          ),
        ),
      ),
    );
  }
}
