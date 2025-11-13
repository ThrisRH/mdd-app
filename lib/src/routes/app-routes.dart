part of 'app-pages.dart';

abstract class Routes {
  static const home = "/home";
  static const blogDetails = "/home/detail/:slug";
  static const blogSearch = "/home/search/:query";
  static const category = "/topics/:id";
  static const author = "/author";
  static const login = "/login";
  static const oauthGoogle = "/oauthGoogle";
  static const register = "/register";
  static const about = "/about";
  static const faq = "/faq";
}
