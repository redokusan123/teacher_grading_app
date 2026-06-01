import 'package:cloud_firestore/cloud_firestore.dart';

class TodoService {
  // This targets the 'tasks' collection in your Firebase database
  final CollectionReference tasksCollection = FirebaseFirestore.instance
      .collection('tasks');

  // 1. CREATE: Add a new task to Firebase
  Future<void> addTask(String title, String subtitle, String status) {
    return tasksCollection.add({
      'title': title,
      'subtitle': subtitle,
      'status': status, // e.g., 'In Progress', 'Completed'
      'createdAt': FieldValue.serverTimestamp(), // Keeps them in order
    });
  }

  // 2. READ: Get a live stream of tasks from Firebase
  Stream<QuerySnapshot> getTasks() {
    return tasksCollection.orderBy('createdAt', descending: true).snapshots();
  }

  // 3. UPDATE: Change the status or edit a task
  Future<void> updateTask(String docId, String newStatus) {
    return tasksCollection.doc(docId).update({'status': newStatus});
  }

  // 4. DELETE: Remove a task from Firebase
  Future<void> deleteTask(String docId) {
    return tasksCollection.doc(docId).delete();
  }
}
