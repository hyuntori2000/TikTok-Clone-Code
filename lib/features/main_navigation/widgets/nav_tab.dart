import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';

class NavTab extends StatelessWidget {
  const NavTab({
    super.key,
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
    required this.selectedIcon,
    required this.selectedIndex,
  });
  final IconData icon;
  final IconData selectedIcon;
  final String label;
  final bool isSelected;
  final Function onTap;
  final int selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () => onTap(),
        child: Container(
          color: selectedIndex == 0 ? Colors.black : Colors.white,
          child: AnimatedOpacity(
            opacity: isSelected ? 1 : 0.5,
            duration: const Duration(milliseconds: 300),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                FaIcon(
                  isSelected ? selectedIcon : icon,
                  color: selectedIndex == 0 ? Colors.white : Colors.black,
                ),
                Gaps.v10,
                Text(
                  label,
                  style: TextStyle(
                    color: selectedIndex == 0 ? Colors.white : Colors.black,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
