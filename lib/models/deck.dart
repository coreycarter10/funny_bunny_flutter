import 'card.dart';

class Deck<T> {
  final List<Card<T>> _cards;
  final List<Card<T>> _discards = [];
  final bool autoShuffle;

  Deck(this._cards, {this.autoShuffle = true}) {
    if (autoShuffle) {
      shuffle();
    }
  }

  factory Deck.fromQtyTable(Map<Card<T>, int> table, {bool autoShuffle = true}) {
    List<Card<T>> cards = [];

    table.forEach((Card<T> card, int qty) {
      cards += List.filled(qty, card);
    });

    return Deck<T>(cards, autoShuffle:  autoShuffle);
  }

  Card<T> draw() {
    if (_cards.isEmpty) {
      if (autoShuffle && hasDiscards) {
        shuffle();
      }
      else {
        return null;
      }
    }

    return _cards.removeLast();
  }

  List<Card<T>> multiDraw(int qty) =>
      List<Card<T>>.generate(qty, (_) => draw());

  void shuffle() {
    _cards..addAll(_discards)..shuffle();
    _discards.clear();
  }

  void add(Card<T> card) => _cards.add(card);
  void discard(Card<T> card) => _discards.add(card);
  void discardAll(List<Card<T>> cards) => _discards.addAll(cards);
  Card<T> undoDiscard() => _discards.isNotEmpty ? _discards.removeLast() : null;

  Card<T> get top => _cards.isNotEmpty ? _cards.last : null;
  Card<T> get topDiscard => _cards.isNotEmpty ? _discards.last : null;
  int get cardsRemaining => _cards.length;
  int get discardsRemaining => _discards.length;
  bool get hasCards => _cards.isNotEmpty;
  bool get hasDiscards => _discards.isNotEmpty;

  @override
  String toString() => "Cards ($cardsRemaining): $_cards\nDiscards ($discardsRemaining): $_discards";
}