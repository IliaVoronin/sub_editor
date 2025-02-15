import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sub_editor/panels/create_project_panel/create_button.dart';
import 'package:sub_editor/panels/create_project_panel/create_textfield.dart';

class CreateProjectPage extends StatefulWidget {
  const CreateProjectPage({super.key});

  @override
  State<CreateProjectPage> createState() => _CreateProjectPageState();
}

class _CreateProjectPageState extends State<CreateProjectPage> {
  FilePickerResult? result;
  UploadTask? uploadTask;
  UploadTask? uploadTaskSubs;

  final String defaultSubs = '''1
00:00:00,000 --> 00:00:02,000
Subtitle 1

2
00:00:02,000 --> 00:00:04,500
Subtitle 2''';

  final projectNameController = TextEditingController();
  final user = FirebaseAuth.instance.currentUser;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future selectFile() async {
    final newResult = await FilePicker.platform
        .pickFiles(type: FileType.any, allowMultiple: false);

    setState(() {
      result = newResult;
    });
  }

  Future createProject() async {
    if (result != null && result!.files.isNotEmpty) {
      // Загрузка выбранного видео
      final fileBytes = result?.files.first.bytes;
      final fileNameVideo = result?.files.first.name;
      final projectName = projectNameController.text;
      CollectionReference projects =
          firestore.collection('users/${user?.uid}/projects');

      final DateTime now = DateTime.now();
      final DateFormat formatter = DateFormat('dd.MM.yyyy H:m');
      final String formatted = formatter.format(now);

      final ref = FirebaseStorage.instance
          .ref('${user?.uid}/$projectName/$fileNameVideo');
      setState(() {
        uploadTask = ref.putData(fileBytes!);
      });

      final snapshot = await uploadTask!.whenComplete(() => null);
      final urlDownload = await snapshot.ref.getDownloadURL();

      // Загрузка дефолтного файла субтитров
      setState(() {
        uploadTaskSubs = FirebaseStorage.instance
            .ref('${user?.uid}/$projectName/$projectName.srt')
            .putString(defaultSubs);
      });

      final snapshotSubs = await uploadTaskSubs!.whenComplete(() => null);
      final urlSubs = await snapshotSubs.ref.getDownloadURL();

      //Добавление проекта в базу данных
      await projects.add({
        'name': projectName,
        'time': formatted,
        'description': 'test_description',
        'video_link': '${user?.uid}/$projectName/$fileNameVideo',
        'video_download_url': urlDownload,
        'sub_link': '${user?.uid}/$projectName/$projectName.srt',
        'sub_download_url': urlSubs
      });
    }
  }

  Widget buildProgress() => StreamBuilder<TaskSnapshot>(
        stream: uploadTask?.snapshotEvents,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.data!;
            double progress = data.bytesTransferred / data.totalBytes;

            return SizedBox(
              height: 40,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  LinearProgressIndicator(
                    value: progress,
                    backgroundColor: Colors.grey,
                    color: Colors.green,
                  ),
                  Center(
                    child: Text(
                      '${result?.files.first.name} : ${(100 * progress).roundToDouble()}%',
                      style: const TextStyle(color: Colors.white),
                    ),
                  )
                ],
              ),
            );
          } else {
            return const SizedBox(height: 50);
          }
        },
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 214, 214, 214),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 15),
              child: Text(
                'Create your new project',
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w400,
                    color: Colors.black54),
              ),
            ),
            const SizedBox(height: 30),

            CreateTextField(
              controller: projectNameController,
              hintText: 'Name your project...',
            ),
            const SizedBox(height: 10),

            // Text(result?.files.first.name ?? 'Select a file'),
            Column(
              children: [
                SizedBox(width: 400, child: buildProgress()),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CreateButton(
                      buttonColor: const Color.fromARGB(255, 126, 197, 255),
                      buttonIcon: Icons.attach_file,
                      onTap: selectFile,
                    ),
                    const SizedBox(width: 10),
                    CreateButton(
                      buttonColor: const Color.fromARGB(255, 126, 197, 255),
                      buttonIcon: Icons.upload,
                      onTap: createProject,
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
