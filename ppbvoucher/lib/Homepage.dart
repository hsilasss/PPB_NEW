import 'package:flutter/material.dart';
import "RewardStorePage.dart";
import "ProfileScreen.dart";
import 'package:shared_preferences/shared_preferences.dart';
import 'MissionSubmitScreen.dart';


class HomePage extends StatefulWidget  {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;

   @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: [
        HomeContent(),   
        RewardStorePage(), 
        ProfileScreen(),  
      ][currentIndex],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.card_giftcard),
              label: 'Reward'
          ),
           BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
          ),
        ],
      ),
    );
  }
}

class HomeContent extends StatefulWidget {
  const HomeContent({super.key});

  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  String userName = "Kenny";

  @override
  void initState() {
    super.initState();
    loadUser();
  }

  Future<void> loadUser() async {
    final pref = await SharedPreferences.getInstance();
    setState(() {
      userName = pref.getString("username") ?? "Kenny";
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(20, 60, 20, 20),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFFF5F3DA), Color(0xFFEAE6C8)],
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children:[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hello, $userName!',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'ready to scan some mission?',
                        style: TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                  Icon(Icons.eco, size: 28),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Color(0xFF6B8E5F),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Green Point',
                          style: TextStyle(color: Colors.white),
                        ),
                        SizedBox(height: 6),
                        Text(
                          '100.000',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Icon(Icons.attach_money, color: Colors.green),
                    ),
                  ],
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: const [
                    BoxShadow(color: Colors.black12, blurRadius: 4),
                  ],
                ),
                child: Row(
                  children: const [
                    Icon(Icons.assignment_turned_in, color: Colors.green),
                    SizedBox(width: 10),
                    Text('1/2  '),
                    Expanded(
                      child: Text(
                        'misi belum dikerjakan',
                        style: TextStyle(color: Colors.green),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Misi Hari Ini!',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),

            const SizedBox(height: 12),

            _missionCard(
              context: context,
              title: 'Membersihkan Kamar',
              point: '40 Poin',
              image: Icons.bed,
              actionText: 'Submit',
            ),

            _missionCard(
              context: context,
              title: 'Membersihkan Halaman Rumah',
              point: '80 Poin',
              image: Icons.park,
              actionText: 'Selesai',
            ),

            const SizedBox(height: 40),
          ],
        ),
      );
  }

  Widget _missionCard({
    required BuildContext context,
    required String title,
    required String point,
    required IconData image,
    required String actionText,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4)],
        ),
        child: Row(
          children: [
            Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                color: Colors.green.shade100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(image, size: 40, color: Color(0xFF6B8E5F)),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(point, style: const TextStyle(color: Colors.green)),
                ],
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: actionText == 'Submit'
                    ? Colors.green
                    : Colors.grey,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                _handleMissionAction(title, actionText);
              },
              child: Text(actionText),
            ),
          ],
        ),
      ),
    );
  }

  void _handleMissionAction(String missionTitle, String actionText) {
    if (actionText == 'Submit') {
      // Buka MissionSubmitScreen untuk capture foto dan submit
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MissionSubmitScreen(
            missionTitle: missionTitle,
            missionPoint: '40 Poin', // Atau ambil dari parameter
          ),
        ),
      );
    } else if (actionText == 'Selesai') {
      // Langsung tandai selesai tanpa foto
      String message = 'Misi "$missionTitle" telah diselesaikan!';
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Colors.green,
          duration: const Duration(seconds: 2),
        ),
      );
      print('Mission completed: $missionTitle');
    }
  }
}