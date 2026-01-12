import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';


class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  String? profileImagePath;
  final ImagePicker picker = ImagePicker();  

  final TextEditingController _name = TextEditingController(text: "Ken");
  final TextEditingController _email = TextEditingController(
    text: "Kenny@gmail.com",
  );
  final TextEditingController _phone = TextEditingController(text: "08xxxxxxx");
  final TextEditingController _dob = TextEditingController(
    text: "Tidak bisa diubah",
  );

  @override
  void initState() {
    super.initState();
    loadProfileImage();
  }

Future<void> loadProfileImage() async {
  final pref = await SharedPreferences.getInstance();
    setState(() {
      profileImagePath = pref.getString("profileImage");
    });
}
  

Future<void> pickImage() async {
final XFile? image =
      await picker.pickImage(source: ImageSource.gallery);
      if (image == null) return;
        final pref = await SharedPreferences.getInstance();
         await pref.setString("profileImage", image.path);
        setState(() {
          profileImagePath = image.path;
        }
      );

  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(content: Text("Foto profil disimpan")),
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(top: 50, left: 20),
              width: double.infinity,
              height: 260,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFFF5F3DA), Color(0xFFD9D7B8)],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios_new),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const SizedBox(height: 10),
                  Center(
                    child: Stack(
                      children: [
                        CircleAvatar(
                          radius: 40,
                          backgroundColor: Colors.grey,
                          backgroundImage: (profileImagePath != null && File(profileImagePath!).existsSync())
                            ? FileImage(File(profileImagePath!))
                            : null,
                          child: profileImagePath == null
                            ? Icon(
                              Icons.person,
                              size: 50,
                              color: Colors.white,
                            )
                            : null,
                        ),
                        
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: CircleAvatar(
                            radius: 18,
                            backgroundColor: Colors.white,
                            child: IconButton(
                              padding: EdgeInsets.zero,
                              icon: Icon(Icons.camera_alt, size: 18),
                              onPressed: () => pickImage(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            Container(
              width: double.infinity,
              decoration: const BoxDecoration(color: Color(0xFF6D7753)),
              child: Column(
                children: [
                  const SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _label("Nama"),
                          _input(_name),

                          _label("Email"),
                          _input(
                            _email,
                            validator: (v) {
                              if (!v!.contains('@')) return "Email tidak valid";
                              return null;
                            },
                          ),

                          _label("No. Handphone"),
                          _input(
                            _phone,
                            validator: (v) {
                              if (v == null || v.isEmpty) {
                               return "Nomor wajib diisi";
                              }
                              if (v.length < 10) {
                                 return "Nomor tidak valid";
                              }
                              return null;
                            },

                          ),

                          _label("Tanggal Lahir"),
                          _input(_dob, enabled: false),

                          const SizedBox(height: 30),

                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFF4F1E3),
                                foregroundColor: Colors.black,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 14,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              onPressed: () async{
                                final pref = await SharedPreferences.getInstance();
                                await pref.setString("username", _name.text);
                                if (_formKey.currentState!.validate()) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text("Perubahan disimpan"),
                                    ),
                                  );
                                  Navigator.pop(context,_name.text);
                                }
                              },
                              child: const Text(
                                "Simpan",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 40),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _label(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6, top: 20),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }


  Widget _input(
    TextEditingController c, {
    bool enabled = true,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: c,
      enabled: enabled,
      validator: validator,
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color(0xFFF4F1E3),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
      ),
    );
  }
}
