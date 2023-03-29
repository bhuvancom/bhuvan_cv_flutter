import 'package:bhuvan_cv/models/user_details_model.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../config/config.dart';
import '../exception/APIException.dart';
import '../util/rest_api.dart';

class TokenBloc with ChangeNotifier {
  UserDetails? _user;

  UserDetails? get user => _user;
  bool _isLoading = false;

  bool get isLoading => _isLoading;
  String? _error;

  String? get error => _error;

  Future<UserDetails?> getUserData(int userId, String tokenSP) async {
    _user = UserDetails(
        "name",
        "subject line",
        "role",
        "location",
        "https://avatars3.githubusercontent.com/u/26062816?s=400&u=183b286c638a153b03b056b27028dcc16dae4c84&v=4",
        List.generate(
            10, (index) => Skill(Config.getRandom(), "title $index")),
        List.generate(
            10,
            (index) => SocialMedia(
                Config.getRandom(), "url $index", "userNameUrl $index")),
        List.generate(
            10,
            (index) => Experience("role $index", "company $index",
                "start $index", "end $index")));
    return _user ??
        UserDetails(
            "name",
            "subject line",
            "role",
            "location",
            "https://avatars3.githubusercontent.com/u/26062816?s=400&u=183b286c638a153b03b056b27028dcc16dae4c84&v=4",
            List.generate(
                10, (index) => Skill(Config.getRandom(), "title $index")),
            List.generate(
                10,
                (index) => SocialMedia(
                    Config.getRandom(), "url $index", "userNameUrl $index")),
            List.generate(
                10,
                (index) => Experience("role $index", "company $index",
                    "start $index", "end $index")));
  }

  Future getUserDetails(int userId) async {
    try {
      _isLoading = true;
      _error = "";
      Future.delayed(const Duration(microseconds: 200))
          .then((value) => notifyListeners());
      var tokenSP = "Redcat";
      _user = await RestApi().getUserData(userId, tokenSP);
      _isLoading = false;
      _error = "";
      notifyListeners();
    } on APIException catch (e) {
      _isLoading = false;
      _error = e.toString();
      notifyListeners();
    }
  }
}
