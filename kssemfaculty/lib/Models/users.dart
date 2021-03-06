import 'package:flutter/foundation.dart';
import 'package:kssem/Models/faculty.dart';

class Users {
  final String uid;
  final String name;
  final String displayName;
  // final String usn;
  final String email;
  final String phone;
  final String branch;
  final String degree;
  final String department;
  final String designation;
  String photoUrl;
  ProfileLinks links;

  Users({
    @required this.uid,
    // this.usn,
    /*@required*/ this.name,
    this.displayName,
    /*@required*/ this.email,
    /*@required*/ this.phone,
    /*@required*/ this.branch,
    /*@required*/ this.degree,
    this.designation,
    this.department,
    this.photoUrl,
    this.links,
  });

  factory Users.fromStudentMap(Map<String, dynamic> data) {
    if (data == null) {
      return null;
    }
    final String uid = data['uid'];
    final String name = data['name'];
    final String displayName = data['displayName'];
    // final String usn = data['usn'];
    final String email = data['email'];
    final String phone = data['phone'];
    final String branch = data['branch'];
    final String degree = data['degree'];
    final String photoUrl = data['photoUrl'];
    Map<dynamic, dynamic> links = data['links'];
    return Users(
      uid: uid,
      // usn: usn,
      name: name,
      displayName: displayName,
      phone: phone,
      email: email,
      branch: branch,
      photoUrl: photoUrl,
      degree: degree,
      links: ProfileLinks.fromMap(links),
    );
  }
  factory Users.fromFacultyMap(Map<String, dynamic> data) {
    if (data == null) {
      return null;
    }
    final String uid = data['uid'];
    final String name = data['name'];
    final String displayName = data['displayName'];
    final String branch = data['branch'];
    // final String usn = data['usn'];
    final String email = data['email'];
    final String phone = data['phone'];
    final String department = data['department'];
    final String designation = data['designarion'];
    final String photoUrl = data['photoUrl'];
    Map<dynamic, dynamic> links = data['links'];
    return Users(
      uid: uid,
      // usn: usn,
      name: name,
      displayName: displayName,
      phone: phone,
      email: email,
      branch: branch,
      department: department,
      photoUrl: photoUrl,
      designation: designation,
      links: ProfileLinks.fromMap(links),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      // 'usn': usn ?? '',
      'name': name ?? '',
      'displayName': displayName ?? '',
      'phone': phone ?? '',
      'email': email ?? '',
      'branch': branch ?? '',
      'department': department,
      'degree': degree ?? '',
      'photoUrl': photoUrl ?? '',
      'links': {},
    };
  }
}
