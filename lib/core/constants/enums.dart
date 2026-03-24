enum ProductType {
  cleanser(labelFr: 'Nettoyant', labelEn: 'Cleanser'),
  toner(labelFr: 'Tonique', labelEn: 'Toner'),
  serum(labelFr: 'Sérum', labelEn: 'Serum'),
  moisturizer(labelFr: 'Hydratant', labelEn: 'Moisturizer'),
  sunscreen(labelFr: 'Crème solaire', labelEn: 'Sunscreen'),
  oil(labelFr: 'Huile', labelEn: 'Oil'),
  mask(labelFr: 'Masque', labelEn: 'Mask'),
  exfoliant(labelFr: 'Exfoliant', labelEn: 'Exfoliant'),
  eyeCream(labelFr: 'Contour des yeux', labelEn: 'Eye Cream'),
  lipCare(labelFr: 'Soin des lèvres', labelEn: 'Lip Care'),
  mist(labelFr: 'Brume', labelEn: 'Mist'),
  spotTreatment(labelFr: 'Traitement ciblé', labelEn: 'Spot Treatment'),
  other(labelFr: 'Autre', labelEn: 'Other');

  const ProductType({required this.labelFr, required this.labelEn});

  final String labelFr;
  final String labelEn;

  String localizedLabel(String locale) {
    return locale.startsWith('fr') ? labelFr : labelEn;
  }
}

enum BodyZone {
  fullFace(labelFr: 'Visage entier', labelEn: 'Full Face'),
  forehead(labelFr: 'Front', labelEn: 'Forehead'),
  cheeks(labelFr: 'Joues', labelEn: 'Cheeks'),
  nose(labelFr: 'Nez', labelEn: 'Nose'),
  chin(labelFr: 'Menton', labelEn: 'Chin'),
  eyes(labelFr: 'Yeux', labelEn: 'Eyes'),
  lips(labelFr: 'Lèvres', labelEn: 'Lips'),
  neck(labelFr: 'Cou', labelEn: 'Neck'),
  decollete(labelFr: 'Décolleté', labelEn: 'Décolleté'),
  hands(labelFr: 'Mains', labelEn: 'Hands'),
  body(labelFr: 'Corps', labelEn: 'Body'),
  other(labelFr: 'Autre', labelEn: 'Other');

  const BodyZone({required this.labelFr, required this.labelEn});

  final String labelFr;
  final String labelEn;

  String localizedLabel(String locale) {
    return locale.startsWith('fr') ? labelFr : labelEn;
  }
}

enum SkinGoal {
  hydration(
    labelFr: 'Hydratation',
    labelEn: 'Hydration',
    emoji: '💧',
  ),
  antiAging(
    labelFr: 'Anti-âge',
    labelEn: 'Anti-aging',
    emoji: '✨',
  ),
  acne(
    labelFr: 'Acné',
    labelEn: 'Acne',
    emoji: '🔴',
  ),
  brightening(
    labelFr: 'Éclat',
    labelEn: 'Brightening',
    emoji: '🌟',
  ),
  soothing(
    labelFr: 'Apaisement',
    labelEn: 'Soothing',
    emoji: '🧊',
  ),
  firming(
    labelFr: 'Fermeté',
    labelEn: 'Firming',
    emoji: '💪',
  ),
  poreCare(
    labelFr: 'Pores',
    labelEn: 'Pore Care',
    emoji: '🔍',
  ),
  darkSpots(
    labelFr: 'Taches',
    labelEn: 'Dark Spots',
    emoji: '⚫',
  ),
  sensitive(
    labelFr: 'Sensible',
    labelEn: 'Sensitive',
    emoji: '🛡️',
  ),
  general(
    labelFr: 'Général',
    labelEn: 'General',
    emoji: '👤',
  );

  const SkinGoal({
    required this.labelFr,
    required this.labelEn,
    required this.emoji,
  });

  final String labelFr;
  final String labelEn;
  final String emoji;

  String localizedLabel(String locale) {
    return locale.startsWith('fr') ? labelFr : labelEn;
  }
}

enum RecurrenceType {
  daily(labelFr: 'Quotidien', labelEn: 'Daily'),
  everyNDays(labelFr: 'Tous les N jours', labelEn: 'Every N days');

  const RecurrenceType({required this.labelFr, required this.labelEn});

  final String labelFr;
  final String labelEn;

  String localizedLabel(String locale) {
    return locale.startsWith('fr') ? labelFr : labelEn;
  }
}
