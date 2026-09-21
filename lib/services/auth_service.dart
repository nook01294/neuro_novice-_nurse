import 'package:firebase_auth/firebase_auth.dart';

/// Wraps [FirebaseAuth] and translates its errors into Thai messages
/// suitable for showing directly to the user.
class AuthService {
  AuthService._();

  static final AuthService instance = AuthService._();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<User?> get authStateChanges => _auth.authStateChanges();

  User? get currentUser => _auth.currentUser;

  Future<UserCredential> signUp({
    required String email,
    required String password,
  }) async {
    try {
      return await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw AuthFailure(_messageFor(e.code));
    }
  }

  Future<UserCredential> signIn({
    required String email,
    required String password,
  }) async {
    try {
      return await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw AuthFailure(_messageFor(e.code));
    }
  }

  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw AuthFailure(_messageFor(e.code));
    }
  }

  Future<void> signOut() => _auth.signOut();

  /// Re-authenticates with the account's own password. Firebase refuses
  /// destructive operations such as [deleteAccount] unless the sign-in is
  /// recent, and a password prompt is also the confirmation step the user
  /// deserves before an irreversible delete.
  Future<void> reauthenticate(String password) async {
    final user = _auth.currentUser;
    final email = user?.email;
    if (user == null || email == null) {
      throw const AuthFailure('ไม่พบบัญชีผู้ใช้ กรุณาเข้าสู่ระบบใหม่');
    }
    try {
      await user.reauthenticateWithCredential(
        EmailAuthProvider.credential(email: email, password: password),
      );
    } on FirebaseAuthException catch (e) {
      throw AuthFailure(_messageFor(e.code));
    }
  }

  /// Permanently deletes the signed-in account. Delete the user's Firestore
  /// documents *before* calling this: once the account is gone `request.auth`
  /// is null and the security rules reject every further write, which would
  /// strand the data with no owner able to remove it.
  Future<void> deleteAccount() async {
    final user = _auth.currentUser;
    if (user == null) {
      throw const AuthFailure('ไม่พบบัญชีผู้ใช้ กรุณาเข้าสู่ระบบใหม่');
    }
    try {
      await user.delete();
    } on FirebaseAuthException catch (e) {
      throw AuthFailure(_messageFor(e.code));
    }
  }

  String _messageFor(String code) {
    switch (code) {
      case 'invalid-email':
        return 'รูปแบบอีเมลไม่ถูกต้อง';
      case 'user-disabled':
        return 'บัญชีนี้ถูกระงับการใช้งาน';
      case 'user-not-found':
        return 'ไม่พบบัญชีผู้ใช้นี้';
      case 'wrong-password':
      case 'invalid-credential':
        return 'อีเมลหรือรหัสผ่านไม่ถูกต้อง';
      case 'email-already-in-use':
        return 'อีเมลนี้มีผู้ใช้งานแล้ว';
      case 'weak-password':
        return 'รหัสผ่านไม่ปลอดภัยพอ กรุณาตั้งรหัสผ่านอย่างน้อย 6 ตัวอักษร';
      case 'network-request-failed':
        return 'เชื่อมต่ออินเทอร์เน็ตไม่ได้ กรุณาลองใหม่อีกครั้ง';
      case 'requires-recent-login':
        return 'เพื่อความปลอดภัย กรุณาออกจากระบบแล้วเข้าสู่ระบบใหม่ก่อนลบบัญชี';
      case 'too-many-requests':
        return 'มีการพยายามเข้าสู่ระบบบ่อยเกินไป กรุณาลองใหม่ภายหลัง';
      default:
        return 'เกิดข้อผิดพลาด กรุณาลองใหม่อีกครั้ง';
    }
  }
}

/// A user-facing auth error carrying an already-translated Thai [message].
class AuthFailure implements Exception {
  final String message;

  const AuthFailure(this.message);

  @override
  String toString() => message;
}
