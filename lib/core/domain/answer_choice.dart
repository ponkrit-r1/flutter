import 'dart:ui';

class AnswerChoice {
  final AnswerOption option;
  final Locale locale;

  AnswerChoice({
    required this.option,
    required this.locale,
  });

  @override
  String toString() {
    switch (option) {
      case AnswerOption.yes:
        return 'Yes';
      case AnswerOption.no:
        return 'No';
      case AnswerOption.doNotKnow:
        return 'Don\'t know';
    }
  }

  @override
  bool operator ==(Object other) =>
      other is AnswerChoice && toString() == other.toString();
      @override
      int get hashCode => Object.hash(option.index, toString()

  );
}

enum AnswerOption {
  yes,
  no,
  doNotKnow;
}
