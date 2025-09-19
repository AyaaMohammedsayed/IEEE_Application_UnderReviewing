class CommunityMemberModel {
  final String name;
  final String role;
  final String imagePath;
  final String linkedIn;
  final String email;
  final String section;
  final String experience;
  final String faculty;


  const CommunityMemberModel(
      {required this.name,
      required this.role,
      required this.imagePath,
      this.linkedIn = "",
      this.experience = "",
      this.section = "",
      this.faculty = "",
      this.email = "",});
}
