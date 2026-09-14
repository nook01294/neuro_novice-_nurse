import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

/// Persists member accounts and per-feature usage logs to Firestore so
/// usage can be reviewed later.
class UsageLogService {
  UsageLogService._();

  static final UsageLogService instance = UsageLogService._();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

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
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    unawaited(_logFeatureUsage(user.uid, featureTitle));
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
}
