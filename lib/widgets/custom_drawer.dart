import 'package:flutter/material.dart';
import 'package:routineapp/config/design_system.dart';
import 'package:routineapp/viewmodels/auth_viewmodel.dart';
import 'package:routineapp/views/auth/splash_view.dart';

class CustomDrawer extends StatelessWidget {
  final String currentRoute;

  CustomDrawer({super.key, required this.currentRoute});
  final AuthViewmodel _authViewModel = AuthViewmodel();

  @override
  Widget build(BuildContext context) {
    
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              gradient: AppColors.secondaryGradient, 
            ),
            child: Text(
              'Menu',
              style: TextStyle(
                color: AppColors.onPrimary, 
                fontSize: 24,
              ),
            ),
          ),
          _createDrawerItem(
            context,
            icon: Icons.home,
            text: 'Home',
            route: '/home',
          ),
          _createDrawerItem(
            context,
            icon: Icons.list,
            text: 'Tasks',
            route: '/tasks',
          ),
          const Divider(),

          _createDrawerItem(
            context,
            icon: Icons.settings,
            text: 'Configurações',
            route: '/settings',
          ),
          _createDrawerItem(
            context,
            icon: Icons.logout,
            text: 'Logout',
            onTap: () {
              _authViewModel.removeToken();
               
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const SplashView(),
                      ));
                    
            },
          ),
        ],
      ),
    );
  }

  Widget _createDrawerItem(
    BuildContext context, {
    required IconData icon,
    required String text,
    String? route,
    VoidCallback? onTap,
  }) {
    final bool isActive = currentRoute == route;
    return ListTile(
      leading: Icon(
        icon,
        color: isActive ? AppColors.secondary : AppColors.onBackground, 
      ),
      title: Text(
        text,
        style: TextStyle(
          fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
          color: isActive ? AppColors.secondary : AppColors.onBackground, 
        ),
      ),
      onTap: () {
        if (onTap != null) {
          onTap();
        } else if (route != null && currentRoute != route) {
          Navigator.pushReplacementNamed(context, route);
        }
      },
      selected: isActive,
      selectedTileColor: AppColors.secondary.withOpacity(0.1),
    );
  }
}
