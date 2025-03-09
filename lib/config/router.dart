import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:supplement_app/screens/home_screen.dart';
import 'package:supplement_app/screens/profile_screen.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/profile',
      builder: (context, state) => const ProfileScreen(),
    ),
  ],
); 