class Pet {
  final String petCategory;
  final String petType;
  final int petLoveCount;
  final String petPic;

  Pet({
    required this.petCategory,
    required this.petType,
    required this.petLoveCount,
    required this.petPic,
  });

  factory Pet.fromJson(Map<String,dynamic> json) {
    return Pet(
      petCategory: json['petCategory'],
      petType: json['petType'],
      petLoveCount: json['petLoveCount'],
      petPic: json['petPic'],
    );
  }
}
