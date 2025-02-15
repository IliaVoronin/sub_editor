import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sub_editor/logic/cubits/project_icon_cubit/project_icon_state.dart';
import '../../models/project_icon_model.dart';

class ProjectIconCubit extends Cubit<ProjectIconState> {
  ProjectIconCubit() : super(ProjectIconState(projectIcons: []));

  List<ProjectIconModel> returnList = [];

  Future updateProjects() async {
    final user = FirebaseAuth.instance.currentUser;
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    CollectionReference projects = firestore.collection('users/${user?.uid}/projects');
    QuerySnapshot allResults = await projects.get();
    
    allResults.docs.forEach((DocumentSnapshot result) {
      ProjectIconModel tempModel = ProjectIconModel(
        projectName: result.get('name'), 
        projectDescription: result.get('description'), 
        proejctTime: result.get('time'), 
        proejctVideoLink: result.get('video_link'), 
        projectVideoUrl: result.get('video_download_url'),
        proejctSubLink: result.get('sub_link'),
        proejctSubUrl: result.get('sub_download_url')
      );
      returnList.add(tempModel);
    });
    emit(ProjectIconState(projectIcons: returnList));
  }
}
