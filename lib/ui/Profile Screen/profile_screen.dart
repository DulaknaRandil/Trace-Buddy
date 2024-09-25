import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:trace_buddy/service/auth_service.dart';
import 'package:trace_buddy/ui/Profile%20Settings%20Screen/profile_update.dart';
import 'package:trace_buddy/ui/Slide%20Screen/slide_screen.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final AuthService authService = AuthService();
  Map<String, dynamic>? userData;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    try {
      String uid = FirebaseAuth.instance.currentUser!.uid;
      Map<String, dynamic>? data = await authService.getUserData(uid);
      setState(() {
        userData = data;
        isLoading = false;
      });
    } catch (e) {
      print('Error fetching user data: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    color: Colors.amber,
                    child: SafeArea(
                      child: Column(
                        children: [
                          SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                icon: SvgPicture.asset(
                                    'assets/bell-pin-fill.svg'),
                                onPressed: () {
                                  // Notification action
                                },
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          CircleAvatar(
                            radius: 50,
                            backgroundImage: userData?['imageUrl'] != null
                                ? NetworkImage(userData!['imageUrl'])
                                : AssetImage('assets/images/user.png')
                                    as ImageProvider,
                          ),
                          SizedBox(height: 10),
                          Text(
                            '${userData?['firstName'] ?? 'First Name'} ${userData?['lastName'] ?? 'Last Name'}',
                            style: GoogleFonts.poppins(
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                              letterSpacing: -0.32,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 5),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 5),
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Text(
                              'Gold Member',
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            '1000 XP',
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 30),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        SizedBox(height: 16),
                        _buildSettingCard(
                            'Settings', 'assets/back-button-2.svg', () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => UpdateProfileScreen()),
                          );
                        }),
                        SizedBox(height: 16),
                        _buildSettingCard(
                            'History', 'assets/back-button-2.svg'),
                        SizedBox(height: 16),
                        _buildSettingCard(
                            'Total Trips', 'assets/back-button-3.svg'),
                        SizedBox(height: 16),
                        _buildSettingCard(
                            'Clear User Data', 'assets/back-button-4.svg'),
                        SizedBox(height: 30),
                        _buildLogoutButton(context),
                        SizedBox(height: 30),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildSettingCard(String title, String iconPath,
      [VoidCallback? onTap]) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        decoration: BoxDecoration(
          color: Color(0xFFFFE0B2),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.black,
                letterSpacing: 0.2,
              ),
            ),
            SvgPicture.asset(iconPath),
          ],
        ),
      ),
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await authService.signout(context: context);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => SlideScreen()),
        );
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Center(
          child: Text(
            'Logout',
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Colors.white,
              letterSpacing: 0.2,
            ),
          ),
        ),
      ),
    );
  }
}
