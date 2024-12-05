import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'model/pet.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pet Shop',
      theme: ThemeData(
        fontFamily: 'BalsamiqSans',
      ),
      home: PetScreen(),
    );
  }
}

class PetScreen extends StatefulWidget {
  @override
  _PetListScreenState createState() => _PetListScreenState();
}

class _PetListScreenState extends State<PetScreen> {
  List<Pet> petList = [];

  @override
  void initState() {
    super.initState();
    loadPetData();
  }

  Future<void> loadPetData() async {
    try {
      final String data = await rootBundle.loadString('assets/petsdata.json');

      List<dynamic> jsonData = jsonDecode(data);
      List<Pet> pets = jsonData.map((jsonItem) => Pet.fromJson(jsonItem)).toList();

      setState(() {
        petList = pets;
      });
    } catch (e) {
      print("Error loading data: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pet Shop'),
        centerTitle: true,
        backgroundColor: Colors.grey,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(16.0),
              child: TextField(
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.orangeAccent,
                  ),
                  labelText: 'Search by pet type',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            petList.isEmpty
                ? Center(child: Text('Loading...'))
                : Column(
              children: petList.map((pet) => PetCard(pet: pet)).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class PetCard extends StatelessWidget {
  final Pet pet;

  PetCard({required this.pet});

  String getImageUrl(String image) {
    String fileId = image.split('/')[5];
    return "https://drive.google.com/uc?export=view&id=$fileId";
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListTile(
        contentPadding: EdgeInsets.all(12),
        leading: Image.network(
          getImageUrl(pet.petPic),
          width: 50,
          height: 50,
          fit: BoxFit.cover,
        ),
        title: Text(pet.petCategory),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${pet.petType}'),
            Text('Love Count: ${pet.petLoveCount}'),
          ],
        ),
      ),
    );
  }
}