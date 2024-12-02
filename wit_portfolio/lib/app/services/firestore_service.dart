import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // User Progress
  Future<void> updateUserProgress(String stepId, {bool completed = true}) async {
    final userId = _auth.currentUser?.uid;
    if (userId == null) return;

    await _firestore.collection('users').doc(userId).collection('progress').add({
      'stepId': stepId,
      'completedAt': Timestamp.now(),
      'status': completed ? 'completed' : 'in_progress',
    });
  }

  // Get User Progress
  Stream<QuerySnapshot> getUserProgress() {
    final userId = _auth.currentUser?.uid;
    if (userId == null) throw Exception('User not authenticated');

    return _firestore
        .collection('users')
        .doc(userId)
        .collection('progress')
        .orderBy('completedAt', descending: true)
        .snapshots();
  }

  // Get Guide Content
  Stream<QuerySnapshot> getGuideSteps() {
    return _firestore
        .collection('guides')
        .doc('portfolio')
        .collection('steps')
        .orderBy('orderIndex')
        .snapshots();
  }

  // Submit Feedback
  Future<void> submitFeedback(String stepId, String content) async {
    final userId = _auth.currentUser?.uid;
    if (userId == null) return;

    await _firestore.collection('users').doc(userId).collection('feedback').add({
      'stepId': stepId,
      'content': content,
      'submittedAt': Timestamp.now(),
      'status': 'pending'
    });
  }
}
