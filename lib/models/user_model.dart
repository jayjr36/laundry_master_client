class UserModel {
  String name;
  String email;
  String phoneNumber;

  UserModel({required this.name, required this.email, required this.phoneNumber});
  
  static Future<UserModel> fetchUserData() async {
    // Fetch user data from Firebase
    return UserModel(name: 'John Doe', email: 'john.doe@example.com', phoneNumber: '123-456-7890');
  }
}
