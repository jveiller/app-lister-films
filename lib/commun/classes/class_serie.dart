class Episode {
  int numero;
  String? titre;
  bool vu;
  int? duree;
  double? note;
  String? description;
  List<String>? avecQui;

  Episode({
    required this.numero,
    this.titre,
    this.vu = false,
    this.duree,
    this.note,
    this.description,
    this.avecQui,
  });

  void setTitre(String? t) => titre = t;
  void setVu(bool v) => vu = v;
  void setDuree(int? d) => duree = d;
  void setNote(double? n) => note = n;
  void setDescription(String? d) => description = d;
  void setAvecQui(List<String>? a) => avecQui = a;

  Map<String, dynamic> toMap() => {
    'numero': numero,
    'titre': titre,
    'vu': vu,
    'duree': duree,
    'note': note,
    'description': description,
    'avecQui': avecQui,
  };

  factory Episode.fromMap(Map<String, dynamic> map) => Episode(
    numero: map['numero'] as int,
    titre: map['titre'] as String?,
    vu: map['vu'] as bool? ?? false,
    duree: map['duree'] as int?,
    note: map['note'] == null ? null : (map['note'] as num).toDouble(),
    description: map['description'] as String?,
    avecQui: map['avecQui'] == null
        ? null
        : List<String>.from(map['avecQui'] as List),
  );
}

class Saison {
  int numero;
  int? nbEpisodes;
  double? note;
  String? commentaire;
  List<Episode> episodes;

  Saison({
    required this.numero,
    this.nbEpisodes,
    this.note,
    this.commentaire,
    List<Episode>? episodes,
  }) : episodes = episodes ?? [];

  // Ajuste le nombre d'épisodes : ajoute des épisodes vides ou retire les
  // derniers, en conservant les données des épisodes déjà définis.
  void setNbEpisodes(int? n) {
    nbEpisodes = n;
    if (n == null) return;
    if (episodes.length > n) {
      episodes = episodes.sublist(0, n);
    } else {
      while (episodes.length < n) {
        episodes.add(Episode(numero: episodes.length + 1));
      }
    }
  }

  void setNote(double? n) => note = n;
  void setCommentaire(String? c) => commentaire = c;

  bool get definie => nbEpisodes != null && episodes.isNotEmpty;
  bool get complete => definie && episodes.every((e) => e.vu);
  bool get enCours => definie && episodes.any((e) => e.vu) && !complete;

  Map<String, dynamic> toMap() => {
    'numero': numero,
    'nbEpisodes': nbEpisodes,
    'note': note,
    'commentaire': commentaire,
    'episodes': episodes.map((e) => e.toMap()).toList(),
  };

  factory Saison.fromMap(Map<String, dynamic> map) => Saison(
    numero: map['numero'] as int,
    nbEpisodes: map['nbEpisodes'] as int?,
    note: map['note'] == null ? null : (map['note'] as num).toDouble(),
    commentaire: map['commentaire'] as String?,
    episodes: map['episodes'] == null
        ? []
        : (map['episodes'] as List)
              .map((e) => Episode.fromMap(Map<String, dynamic>.from(e as Map)))
              .toList(),
  );
}

class Serie {
  int id;
  late String titre;
  List<String>? genre;
  List<String>? plateforme;
  int? annee;
  String? createur;
  List<String>? acteurs;
  String? description;
  List<String>? avecQui;
  List<String>? recommandePar;
  List<String>? citations;
  int? nbSaisons;
  int? nbEpisodesMoyen;
  int? dureeMoyenneEpisode;
  double? note;
  List<Saison> saisons;

  Serie({
    required this.id,
    required this.titre,
    this.genre,
    this.plateforme,
    this.annee,
    this.createur,
    this.acteurs,
    this.description,
    this.avecQui,
    this.recommandePar,
    this.citations,
    this.nbSaisons,
    this.nbEpisodesMoyen,
    this.dureeMoyenneEpisode,
    this.note,
    List<Saison>? saisons,
  }) : saisons = saisons ?? [];

  void setTitre(String titre) => this.titre = titre;
  void setGenre(List<String>? g) => genre = g;
  void setPlateforme(List<String>? p) => plateforme = p;
  void setAnnee(int? a) => annee = a;
  void setCreateur(String? c) => createur = c;
  void setActeurs(List<String>? a) => acteurs = a;
  void setDescription(String? d) => description = d;
  void setAvecQui(List<String>? a) => avecQui = a;
  void setRecommandePar(List<String>? r) => recommandePar = r;
  void setCitations(List<String>? c) => citations = c;
  void setNbEpisodesMoyen(int? n) => nbEpisodesMoyen = n;
  void setDureeMoyenneEpisode(int? d) => dureeMoyenneEpisode = d;
  void setNote(double? n) => note = n;

  // Ajuste le nombre de saisons : ajoute des saisons vides ou retire les
  // dernières, en conservant les données des saisons déjà définies.
  void setNbSaisons(int? n) {
    nbSaisons = n;
    if (n == null) return;
    if (saisons.length > n) {
      saisons = saisons.sublist(0, n);
    } else {
      while (saisons.length < n) {
        saisons.add(Saison(numero: saisons.length + 1));
      }
    }
  }

  List<Episode> get tousLesEpisodes =>
      saisons.expand((s) => s.episodes).toList();

  // Statut calculé à partir de la progression réelle plutôt que stocké, pour
  // qu'il ne puisse jamais se désynchroniser des épisodes cochés.
  String get statut {
    final episodes = tousLesEpisodes;
    final saisonsCompletes =
        saisons.isNotEmpty &&
        (nbSaisons == null || saisons.length == nbSaisons) &&
        saisons.every((s) => s.definie);
    if (episodes.isEmpty || episodes.every((e) => !e.vu)) return 'a_voir';
    if (saisonsCompletes && episodes.every((e) => e.vu)) return 'vu';
    return 'en_cours';
  }
}
