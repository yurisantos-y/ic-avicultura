import 'package:avicultura_app/common/constants/app_colors.dart';
import 'package:avicultura_app/common/constants/routes.dart';
import 'package:flutter/material.dart';

class CustomFloatingBottomNavbar extends StatefulWidget {
  const CustomFloatingBottomNavbar({super.key});

  @override
  State<CustomFloatingBottomNavbar> createState() => _CustomFloatingBottomNavbarState();
}

List<IconData> navIcons = [
  Icons.home,
  Icons.description,
  Icons.vaccines,
  Icons.person,
];

List<String> navLabels = [
  'Home',
  'Relatório',
  'Vacinas',
  'Perfil',
];

int selectedIndex = 0;

class _CustomFloatingBottomNavbarState extends State<CustomFloatingBottomNavbar> {

  double get textScaleFactor =>
      MediaQuery
          .of(context)
          .size
          .width < 360 ? 0.7 : 1.0;

  double get iconSize =>
      MediaQuery
          .of(context)
          .size
          .width < 360 ? 16.0 : 24.0;
  final pageController = PageController();

  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      setState(() {
        selectedIndex = pageController.page?.round() ?? 0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65,
      margin: const EdgeInsets.only(right: 24, left: 24, bottom: 24),
      decoration: BoxDecoration(
        color: AppColors.bgBottomNavBar,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withAlpha(20),
            blurRadius: 20,
            spreadRadius: 12,
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(navIcons.length, (index) {
          bool isSelected = selectedIndex == index;
          return Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                setState(() {
                  selectedIndex = index;
                });
                
                // Navigate based on selected index
                if (index == 0) {
                  Navigator.pushReplacementNamed(context, NamedRoute.home);
                } else if (index == 1) {
                  Navigator.pushNamed(context, NamedRoute.relatorio);
                } else if (index == 2) {
                  Navigator.pushNamed(context, NamedRoute.vaccineControl);
                } else if (index == 3) {
                  Navigator.pushNamed(context, NamedRoute.userProfile);
                }
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(top: 8, bottom: 4),
                    child: Icon(
                      navIcons[index],
                      color: isSelected ? AppColors.primary : AppColors.stroke,
                      size: iconSize,
                    ),
                  ),
                  Text(
                    navLabels[index],
                    style: TextStyle(
                      color: isSelected ? AppColors.primary : AppColors.stroke,
                      fontSize: 12 * textScaleFactor,
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}

