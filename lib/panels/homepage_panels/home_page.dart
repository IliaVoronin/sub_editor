import 'package:flutter/material.dart';
import 'package:sub_editor/logic/models/project_icon_model.dart';
import 'package:sub_editor/panels/homepage_panels/search_field.dart';
import 'package:sub_editor/panels/homepage_panels/side_layout.dart';
import 'package:sub_editor/logic/models/side_layout_model.dart';
import '../create_project_panel/create_project_page.dart';
import '../view_projects_panel/view_projects_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int index = 1;

  List<ProjectIconModel> projectIcons = [];

  List<SideLayoutModel> panelList = [
    SideLayoutModel(
      panel: CreateProjectPage(), 
      menuButton: SideLayoutButton(
        buttonText: 'Create project', 
        buttonIcon: Icons.add, 
        buttonColor: const Color.fromARGB(255, 126, 197, 255))),
    SideLayoutModel(
      panel: const ViewProjectsPage(), 
      menuButton: SideLayoutButton(
        buttonText: 'View projects', 
        buttonIcon: Icons.folder, 
        buttonColor: const Color.fromARGB(255, 126, 197, 255))),    
  ];

  void changePanel(int newIndex) {
    setState(() {
      index = newIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 214, 214, 214),
      body: Row(
        children: [
          SideLayout(
            changePanel: changePanel, 
            menuButtons: panelList.map((e) => e.menuButton).toList()
          ),
          Expanded(
            flex: 6,
            child: Column(
              children: [
                const SearchField(),
                Expanded(
                  child: panelList[index].panel
                )
              ],
            )
          ),
        ],
      ),
    );
  }
}