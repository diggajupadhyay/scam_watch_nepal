import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(ScamWatchNepalApp());
}

class ScamWatchNepalApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Scam Watch Nepal',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  User? user;

  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      setState(() {
        this.user = user;
      });
    });
  }

  Future<void> signInWithGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
    if (googleUser != null) {
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      await FirebaseAuth.instance.signInWithCredential(credential);
    }
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scam Watch Nepal'),
        actions: [
          if (user != null)
            IconButton(
              icon: Icon(Icons.logout),
              onPressed: signOut,
            ),
        ],
      ),
      body: Center(
        child: user == null
            ? ElevatedButton(
                onPressed: signInWithGoogle,
                child: Text('Sign in with Google'),
              )
            : ScamSubmissionForm(user: user!),
      ),
    );
  }
}

class ScamSubmissionForm extends StatefulWidget {
  final User user;

  ScamSubmissionForm({required this.user});

  @override
  _ScamSubmissionFormState createState() => _ScamSubmissionFormState();
}

class _ScamSubmissionFormState extends State<ScamSubmissionForm> {
  final _formKey = GlobalKey<FormState>();
  String name = '';
  String status = 'Active';
  String source = '';
  String description = '';

  void submitScam() {
    if (_formKey.currentState!.validate()) {
      FirebaseFirestore.instance.collection('scam_submissions').add({
        'name': name,
        'status': status,
        'source': source,
        'description': description,
        'submitted_by': widget.user.uid,
        'submitted_at': DateTime.now(),
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Scam Submitted!')));
      _formKey.currentState!.reset();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(labelText: 'Scam Name'),
              onChanged: (val) => name = val,
              validator: (val) => val!.isEmpty ? 'Please enter a name' : null,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Source'),
              onChanged: (val) => source = val,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Description'),
              onChanged: (val) => description = val,
            ),
            DropdownButtonFormField<String>(
              value: status,
              items: ['Active', 'Inactive'].map((status) {
                return DropdownMenuItem(value: status, child: Text(status));
              }).toList(),
              onChanged: (val) => setState(() => status = val!),
            ),
            ElevatedButton(
              onPressed: submitScam,
              child: Text('Submit Scam'),
            ),
          ],
        ),
      ),
    );
  }
}
