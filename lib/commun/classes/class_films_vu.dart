class FilmsVu {
  static int nbFilms = 0;
  int id;
  late String titre;
  int? duree;
  double? note;
  List<String>? genre;
  List<String>? plateforme;
  int? annee;
  String? description;
  List<String>? citations;
  List<String>? acteurs;
  String? realisateur;
  String? contexte;
  bool? cinema;
  DateTime? date;

  FilmsVu({
    required this.titre,
    this.annee,
    this.description,
    this.duree,
    this.genre,
    this.note,
    this.plateforme,
    this.acteurs,
    this.citations,
    this.realisateur,
    this.cinema,
    this.contexte,
    this.date,
    required this.id,
  });

  void setTitre(String titre) {
    this.titre = titre;
  }

  void setDuree(int? d) {
    duree = d;
  }

  void setNote(double? n) {
    note = n;
  }

  void setGenre(List<String>? genre) {
    this.genre = genre;
  }

  void setPlateforme(List<String>? p) {
    plateforme = p;
  }

  void setAnnee(int? a) {
    annee = a;
  }

  void setDescription(String? d) {
    description = d;
  }

  void setActeurs(List<String>? a) {
    acteurs = a;
  }

  void setCitations(List<String>? c) {
    citations = c;
  }

  void setRealisateur(String? r) {
    realisateur = r;
  }

  void setCinema(bool? c) {
    cinema = c;
  }

  void setDate(DateTime? d) => date = d;

  void setContexte(String? c) => contexte = c;
}
