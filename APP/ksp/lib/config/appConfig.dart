import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IndiaPoliceHackAppConfig {
  static const String app_name = "KSP";
  static const String app_version = "Version 1.0.0";
  static const int app_version_code = 1;
  static const String app_color = "#FF9800";
  static const String backColor = '#0xFF323538';
  static Color primaryAppColor = Colors.white;
  static Color secondaryAppColor = Colors.black;
  static const String worksans = "WorkSans";
  static bool isDebugMode = true;
  static bool isCheckModeBanner = false;

  //* Preferences
  static SharedPreferences prefs;
  static const String darkModePref = "darkModePref";
}