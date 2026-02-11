import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../features/auth/domain/models/social_log_in_body.dart';

class GoogleAuthHelper {
  final GoogleSignIn _googleSignIn = GoogleSignIn.instance;

  Future<SocialLogInBody?> signIn() async {
    try {
      // Force fresh login (fixes reauth issues)
      await _googleSignIn.signOut();

      final account = await _googleSignIn.authenticate(
        scopeHint: ['email', 'profile'],
      );

      // 🔴 VERY IMPORTANT
      if (account == null) {
        debugPrint('Google Sign-In canceled by user');
        return null;
      }


      return SocialLogInBody(
        email: account.email,
        name: account.displayName ?? '',
        loginType: 'google',
        socialId: account.id,
        image: account.photoUrl ?? '',
      );
    } catch (e, s) {
      debugPrint('Google sign-in failed: $e');
      debugPrintStack(stackTrace: s);
      return null;
    }
  }

  Future<void> signOut() async {
    await _googleSignIn.signOut();
  }
}
