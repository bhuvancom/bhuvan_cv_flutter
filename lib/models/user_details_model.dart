class UserDetails {
  String name;
  String subjectLine;
  String currentRole;
  String currentLocation;
  String avatarUrl;
  List<Skill> skills;
  List<SocialMedia> socialMedias;
  List<Experience> experience;

  UserDetails(
      this.name,
      this.subjectLine,
      this.currentRole,
      this.currentLocation,
      this.avatarUrl,
      this.skills,
      this.socialMedias,
      this.experience);
}

class SocialMedia {
  String icon;
  String url;
  String userNameUrl;

  SocialMedia(this.icon, this.url, this.userNameUrl);
}

class Skill {
  String imgUrl;
  String title;

  Skill(this.imgUrl, this.title);
}

class Experience {
  String role;
  String company;
  String start;
  String end;

  Experience(this.role, this.company, this.start, this.end);
}
