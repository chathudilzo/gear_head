import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gear_head/core/theme/app_colors.dart';

class GearHeadDrawer extends StatelessWidget {
  const GearHeadDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.transparent,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.surface.withOpacity(0.7),
            border: Border(right: BorderSide(color: Colors.white10, width: 1)),
          ),
          child: SafeArea(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 35,
                      backgroundColor: Colors.blueAccent,
                      child: Icon(
                        Icons.person,
                        size: 40,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    const Text("CHATHURA",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            letterSpacing: 1)),
                    Text("Premium Member",
                        style: TextStyle(
                            color: Colors.blueAccent.withOpacity(0.7),
                            fontSize: 12)),
                  ],
                ),
              ),
              const Divider(color: Colors.white10, indent: 20, endIndent: 20),
              _drawerItem(Icons.garage_rounded, "My Garage", () {}),
              _drawerItem(Icons.analytics_outlined, "Vehicle Health", () {}),
              _drawerItem(
                  Icons.settings_suggest_outlined, "AI Settings", () {}),
              _drawerItem(Icons.help_outline_rounded, "Support", () {}),
              const Spacer(),
              _drawerItem(Icons.logout_rounded, "Sign Out", () {},
                  color: Colors.redAccent),
              const SizedBox(height: 20),
            ],
          )),
        ),
      ),
    );
  }

  Widget _drawerItem(IconData icon, String title, VoidCallback onTap,
      {Color color = Colors.white70}) {
    return ListTile(
      leading: Icon(icon, color: color, size: 22),
      title: Text(title,
          style: TextStyle(
              color: color, fontSize: 15, fontWeight: FontWeight.w400)),
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
    );
  }
}
