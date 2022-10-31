import 'package:major_try/model/words.dart';

class PronounData {
  final List<Words> _pronounList = <Words>[
    Words(word: 'म'),
    Words(word: 'हामी'),
    Words(word: 'तँ'),
    Words(word: 'तिमी'),
    Words(word: 'तपाईँ'),
    Words(word: ' हजुर'),
    Words(word: 'ऊ'),
    Words(word: 'उनी'),
    Words(word: 'उहाँ'),
    Words(word: 'तिनी'),
    Words(word: 'म'),
    Words(word: 'म'),
    Words(word: 'म'),
    Words(word: 'म'),
    Words(word: 'म'),
    Words(word: 'म'),
    Words(word: 'म'),
    Words(word: 'म'),
    Words(word: 'म'),
    Words(word: 'म'),
    Words(word: 'म'),
  ];

  List<Words> get pronounList => _pronounList;
}

class NounData {
  final List<Words> _nounList = <Words>[
    Words(word: 'खाना'),
    Words(word: 'रोटी'),
    Words(word: 'पानी'),
    Words(word: 'हाथ'),
    Words(word: 'खुट्टा'),
    Words(word: 'मुख'),
    Words(word: 'निद्रा'),
    Words(word: 'भोक'),
    Words(word: 'तिर्खा'),
    Words(word: 'चर्पी'),
    Words(word: 'स्कुल'),
    Words(word: 'घर'),
    Words(word: 'कोठा'),
    Words(word: 'कता'),
    Words(word: 'किन'),
    Words(word: 'म'),
    Words(word: 'म'),
    Words(word: 'म'),
    Words(word: 'म'),
    Words(word: 'म'),
    Words(word: 'म'),
  ];

  List<Words> get nounList => _nounList;
}

class VerbData {
  final List<Words> _verbList = <Words>[
    Words(word: 'खानु'),
    Words(word: 'जानु'),
    Words(word: 'लानु'),
    Words(word: 'धुनु'),
    Words(word: 'पढ्नु'),
    Words(word: 'गर्नु'),
    Words(word: 'लेख्नु'),
    Words(word: 'चलाउनु'),
    Words(word: 'पियुनु'),
    Words(word: 'सुत्नु'),
    Words(word: 'लाग्नु'),
    Words(word: 'verb'),
    Words(word: 'verb'),
    Words(word: 'verb'),
    Words(word: 'verb'),
    Words(word: 'verb'),
  ];

  List<Words> get verbList => _verbList;
}

class MatraData {
  final List<Words> _matraList = <Words>[
    Words(word: 'लाई'),
    Words(word: 'रो'),
    Words(word: 'री'),
    Words(word: 'को'),
    Words(word: 'हरु'),
    Words(word: 'aau'),
    Words(word: 'uu'),
    Words(word: 'ki'),
    Words(word: 'kau'),
    Words(word: 'kaha'),
  ];

  List<Words> get matraList => _matraList;
}
