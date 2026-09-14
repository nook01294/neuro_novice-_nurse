import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

/// Persists member accounts and per-feature usage logs to Firestore so
/// usage can be reviewed later.
class UsageLogService {
  UsageLogService._();

  static final UsageLogService instance = UsageLogService._();

  // A getter (not a field) so touching `UsageLogService.instance` never
  // itself throws when Firebase hasn't been initialized (e.g. in widget
  // tests that don't exercise auth/Firestore) — only actually logging does,
  // and that's caught below.
  FirebaseFirestore get _db => FirebaseFirestore.instance;

  /// Creates or updates the `users/{uid}` document. Call after sign-up and
  /// after every sign-in so `lastLoginAt` stays current.
  Future<void> ensureUserDoc(User user) async {
    final ref = _db.collection('users').doc(user.uid);
    final existing = await ref.get();

    await ref.set({
      'email': user.email,
      'lastLoginAt': FieldValue.serverTimestamp(),
      if (!existing.exists) 'createdAt': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
  }

  /// Fire-and-forget log of a feature tap. Never throws: a logging failure
  /// must not block navigation into the feature itself.
  void logFeatureUsage(String featureTitle) {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) return;
      unawaited(_logFeatureUsage(user.uid, featureTitle));
    } catch (_) {
      // Usage logging is best-effort; ignore failures.
    }
  }

  Future<void> _logFeatureUsage(String uid, String featureTitle) async {
    try {
      await _db.collection('users').doc(uid).collection('usage_logs').add({
        'feature': featureTitle,
        'timestamp': FieldValue.serverTimestamp(),
      });
    } catch (_) {
      // Usage logging is best-effort; ignore failures.
    }
  }

  /// Fire-and-forget log of a completed Quiz Test set (which set, and the
  /// score achieved), for later review.
  void logQuizResult({
    required String setId,
    required String setTitle,
    required int score,
    required int total,
  }) {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) return;
      unawaited(_logQuizResult(
        uid: user.uid,
        setId: setId,
        setTitle: setTitle,
        score: score,
        total: total,
      ));
    } catch (_) {
      // Quiz result logging is best-effort; ignore failures.
    }
  }

  Future<void> _logQuizResult({
    required String uid,
    required String setId,
    required String setTitle,
    required int score,
    required int total,
  }) async {
    try {
      await _db.collection('users').doc(uid).collection('quiz_results').add({
        'setId': setId,
        'setTitle': setTitle,
        'score': score,
        'total': total,
        'timestamp': FieldValue.serverTimestamp(),
      });
    } catch (_) {
      // Quiz result logging is best-effort; ignore failures.
    }
  }
}
