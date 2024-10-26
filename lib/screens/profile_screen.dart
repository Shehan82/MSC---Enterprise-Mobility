import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'dart:io';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final ImagePicker _picker = ImagePicker();
  File? _profileImage;
  String? _profileImageUrl;
  String? _email;
  late Box _imageBox;
  Timer? _timer;
  bool _isUploading = false;

  @override
  void initState() {
    super.initState();
    Hive.initFlutter();
    _openHiveBox();
    _loadUserProfile();
    _startTimer();
  }

  Future<void> _openHiveBox() async {
    _imageBox = await Hive.openBox('profile');
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 10), (Timer timer) {
      _checkAndUploadImage();
    });
  }

  Future<void> _checkAndUploadImage() async {
    final connectivity = await Connectivity().checkConnectivity();
    if (!connectivity.contains(ConnectivityResult.none)) {
      final User? user = _auth.currentUser;
      if (user != null && _imageBox.containsKey('profileImage')) {
        File localImage = File(_imageBox.get('profileImage'));

        final DocumentSnapshot snapshot =
            await _firestore.collection('users').doc(user.uid).get();
        if (snapshot.exists) {
          Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;

          if (data != null) {
            try {
              final Reference storageRef =
                  _storage.ref().child('profileImages/${user.uid}');
              await storageRef.putFile(localImage);
              final String downloadUrl = await storageRef.getDownloadURL();

              await _firestore.collection('users').doc(user.uid).set({
                'profileImageUrl': downloadUrl,
              }, SetOptions(merge: true));

              _imageBox.delete('profileImage');
            } catch (e) {
              print("Failed to upload image: $e");
            }
          }
        }
      }
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Future<void> _loadUserProfile() async {
    final User? user = _auth.currentUser;
    setState(() {
      _email = user?.email;
    });
    await _fetchProfileImage();
  }

  Future<void> _fetchProfileImage() async {
    final connectivity = await Connectivity().checkConnectivity();
    if (connectivity.contains(ConnectivityResult.none)) {
      if (_imageBox.containsKey('profileImage')) {
        setState(() {
          _profileImage = File(_imageBox.get('profileImage'));
        });
      }
    } else {
      final DocumentSnapshot snapshot = await _firestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .get();
      if (snapshot.exists) {
        String? imageUrl = snapshot.get('profileImageUrl');
        if (imageUrl != null) {
          setState(() {
            _profileImageUrl = imageUrl;
          });
        }
      }
    }
  }

  Future<void> _captureImage() async {
    final connectivity = await Connectivity().checkConnectivity();
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      setState(() {
        _profileImageUrl = null;
        _profileImage = File(image.path);
      });
      if (!connectivity.contains(ConnectivityResult.none)) {
        await _uploadImage(File(image.path));
      } else {
        _imageBox.put('profileImage', image.path);
      }
    }
  }

  Future<void> _uploadImage(File image) async {
    setState(() {
      _isUploading = true;
    });

    try {
      final User? user = _auth.currentUser;
      final String uid = user!.uid;
      final Reference storageRef = _storage.ref().child('profileImages/$uid');
      await storageRef.putFile(image);
      final String downloadUrl = await storageRef.getDownloadURL();

      await _firestore.collection('users').doc(uid).set({
        'profileImageUrl': downloadUrl,
      }, SetOptions(merge: true));

      if (_imageBox.containsKey('profileImage')) {
        _imageBox.delete('profileImage');
      }

      setState(() {
        _isUploading = false;
      });
    } catch (e) {
      setState(() {
        _isUploading = false;
      });
    }
  }

  Future<void> _signOut() async {
    await _auth.signOut();
    Navigator.of(context).pushReplacementNamed('/');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
      ),
      body: AnimatedContainer(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("android/assets/images/background.png"),
            fit: BoxFit.fill,
          ),
        ),
        curve: Curves.easeOut,
        duration: const Duration(milliseconds: 400),
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.all(20),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 50),
            GestureDetector(
              onTap: _captureImage,
              child: CircleAvatar(
                radius: 100,
                backgroundImage: _profileImageUrl != null
                    ? NetworkImage(_profileImageUrl!)
                    : _profileImage != null
                        ? FileImage(_profileImage!)
                        : null,
                child: _profileImageUrl == null && _profileImage == null
                    ? const Icon(Icons.camera_alt, size: 40)
                    : null,
              ),
            ),
            const SizedBox(height: 20),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: "Email: ",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[700],
                    ),
                  ),
                  TextSpan(
                    text: _email ?? "Loading...",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      letterSpacing: 1.1,
                      shadows: [
                        Shadow(
                          color: Colors.black.withOpacity(0.2),
                          offset: const Offset(1, 1),
                          blurRadius: 2,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),
            if (_isUploading)
              const Padding(
                padding: EdgeInsets.only(top: 20),
                child: CircularProgressIndicator(),
              ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: _signOut,
              icon: const Icon(Icons.logout),
              label: const Text("Sign Out"),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.redAccent,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                textStyle:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
