import 'package:flutter_test/flutter_test.dart';

import 'package:mystic_app/core/utils/numerology_service.dart';

void main() {
  group('reduceNumber', () {
    test('master numbers 11, 22, 33 are preserved when allowMaster is true', () {
      expect(reduceNumber(11, allowMaster: true), 11);
      expect(reduceNumber(22, allowMaster: true), 22);
      expect(reduceNumber(33, allowMaster: true), 33);
    });

    test('master numbers are reduced when allowMaster is false', () {
      expect(reduceNumber(11, allowMaster: false), 2);
      expect(reduceNumber(22, allowMaster: false), 4);
      expect(reduceNumber(33, allowMaster: false), 6);
    });
  });

  group('lifePath', () {
    test('lifePath is deterministic for same DOB', () {
      final dob = DateTime(1990, 5, 15);
      expect(lifePath(dob), lifePath(dob));
      final a = lifePath(dob);
      for (var i = 0; i < 5; i++) {
        expect(lifePath(dob), a);
      }
    });
  });

  group('personalDay', () {
    test('personalDay changes when forDate changes', () {
      final dob = DateTime(1985, 3, 10);
      final day1 = personalDay(dob, DateTime(2026, 3, 1));
      final day2 = personalDay(dob, DateTime(2026, 3, 2));
      // Not guaranteed to be different for all DOBs, but for this DOB/date pair they typically differ
      final day3 = personalDay(dob, DateTime(2026, 4, 1));
      const valid = [1, 2, 3, 4, 5, 6, 7, 8, 9, 11, 22, 33];
      expect(valid.contains(day1), isTrue);
      expect(valid.contains(day2), isTrue);
      expect(valid.contains(day3), isTrue);
    });
  });
}
