class FilmsVoir {
  static int nbFilms = 0;
  int id;
  late String titre;
  int? duree;
  double? note;
  List<String>? genre;
  String? plateforme;
  int? annee;
  String? description;
  List<String>? acteurs;
  String? realisateur;

  FilmsVoir({
    required this.titre,
    this.annee,
    this.description,
    this.duree,
    this.genre,
    this.note,
    this.plateforme,
    this.acteurs,
    this.realisateur,
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

  void setPlateforme(String? p) {
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

  void setRealisateur(String? r) {
    realisateur = r;
  }
}
