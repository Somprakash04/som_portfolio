import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

/// Social / contact link entry.
class SocialLinkModel {
  const SocialLinkModel({
    required this.platform,
    required this.url,
    required this.icon,
    this.username,
    this.color,
  });

  final String platform;
  final String url;
  final FaIconData icon;
  final String? username;
  final Color? color;
}
