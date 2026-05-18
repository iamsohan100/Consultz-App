import 'package:consultz/feature/bookings/pages/bookings_screen.dart';
import 'package:consultz/feature/discover/pages/discover_screen.dart';
import 'package:consultz/feature/expert/pages/expert_details_screen.dart';
import 'package:consultz/feature/home/pages/home_screen.dart';
import 'package:consultz/feature/post/pages/post_screen.dart';
import 'package:consultz/feature/profile/pages/consultee_profile_screen.dart';
import 'package:flutter/material.dart';

class MainPageData {
  static List<Widget> consulteePages = [
    const HomeScreen(),
    const BookingsScreen(),
    const DiscoverScreen(),
    const ConsulteeProfileScreen(),
  ];
  static List<Widget> expertPages = [
    const HomeScreen(),
    const BookingsScreen(),
    const PostScreen(),
    const DiscoverScreen(),
    const ExpertDetailsScreen(isProfile: true),
  ];
}
