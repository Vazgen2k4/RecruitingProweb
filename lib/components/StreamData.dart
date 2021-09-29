import 'package:cloud_firestore/cloud_firestore.dart';

class MainData {
  final QuerySnapshot<Map<String, dynamic>> user;
  MainData({required this.user});
}

class DirectionData extends MainData {
  final List<QueryDocumentSnapshot<Map<String, dynamic>>> direction;
  DirectionData({required this.direction, user}) : super(user: user);
}

class UsersListData extends DirectionData {
  final List<QueryDocumentSnapshot<Map<String, dynamic>>> userList;
  UsersListData({required this.userList, user, direction})
      : super(direction: direction, user: user);
}
