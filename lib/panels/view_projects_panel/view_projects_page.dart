import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sub_editor/logic/cubits/project_icon_cubit/project_icon_cubit.dart';
import 'package:sub_editor/logic/cubits/project_icon_cubit/project_icon_state.dart';
import 'package:sub_editor/panels/view_projects_panel/project_icon_box.dart';

import '../temp_player/editor_panel.dart';

class ViewProjectsPage extends StatefulWidget {
  const ViewProjectsPage({super.key});

  @override
  State<ViewProjectsPage> createState() => _ViewProjectsPageState();
}

class _ViewProjectsPageState extends State<ViewProjectsPage> {
  late ProjectIconCubit projectIconCubit;

  @override
  void initState() {
    super.initState();
    projectIconCubit = ProjectIconCubit();
    projectIconCubit.updateProjects();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => projectIconCubit,
      child: BlocBuilder<ProjectIconCubit, ProjectIconState>(
        builder: (context, state) {
          return GridView.extent(
            maxCrossAxisExtent: 200,
            padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            children: [
              for (int i = 0; i < state.projectIcons.length; i++)
                ProjectIconBox(
                  projectIcon: state.projectIcons[i],
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EditorPanel(model: state.projectIcons[i])));
                  },
                )
            ],
          );
        },
      ),
    );
  }
}
