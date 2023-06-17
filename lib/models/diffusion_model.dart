class DiffusionModel {
  final String uid;
  final String date;
  final String dateComplete;
  final List<dynamic> diffusions;

  DiffusionModel({
    required this.uid,
    required this.date,
    required this.dateComplete,
    required this.diffusions,
  });

  factory DiffusionModel.fromJson(Map<String, dynamic> json) {
    return DiffusionModel(
      uid: json['userid'],
      date: json['date'],
      dateComplete: json['datecomplete'],
      diffusions: json['diffusions'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userid': uid,
      'date': date,
      'dateComplete': dateComplete,
      'diffusions': diffusions,
    };
  }
}
