import '../models/card.dart';

enum FbCardId {
  hop1,
  hop2,
  hop3,
  click,
  back,
}

const Map<Card<FbCardId>, int> fbDeckData = {
  Card<FbCardId>(id: FbCardId.hop1, imagePath: 'assets/images/one.jpg'): 18,
  Card<FbCardId>(id: FbCardId.hop2, imagePath: 'assets/images/two.jpg'): 12,
  Card<FbCardId>(id: FbCardId.hop3, imagePath: 'assets/images/three.jpg'): 6,
  Card<FbCardId>(id: FbCardId.click, imagePath: 'assets/images/click.jpg'): 12,
};

const cardBack = Card<FbCardId>(id: FbCardId.back, imagePath: 'assets/images/funny_bunny_logo.jpg');