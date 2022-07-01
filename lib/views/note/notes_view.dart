import 'package:flutter/material.dart';
import 'package:note/constans/routes.dart';
import 'package:note/enums/menu_action.dart';
import 'package:note/services/auth/auth_service.dart';
import 'package:note/services/crud/note_service.dart';
import 'package:note/utilities/dialog/logout_diolog.dart';
import 'package:note/views/note/notes_list_view.dart';

class NotesView extends StatefulWidget {
  const NotesView({Key? key}) : super(key: key);

  @override
  State<NotesView> createState() => _NotesViewState();
}

class _NotesViewState extends State<NotesView> {
  late final NotesServices _notesServices;
  String get userEmail => AuthService.firebase().currentUser!.email!;

  @override
  void initState() {
    _notesServices = NotesServices();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Your Notes'),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(createOrUpdateNoteRoute);
                },
                icon: const Icon(Icons.add)),
            PopupMenuButton<MenuAction>(
              onSelected: (value) async {
                switch (value) {
                  case MenuAction.logOut:
                    final shouldLogout = await showLogOutDialog(context);
                    if (shouldLogout) {
                      // karna tipe bolean jadi bisa lansung gak pakei persamaan
                      await AuthService.firebase().logOut();
                      Navigator.of(context).pushNamedAndRemoveUntil(
                        loginRoute,
                        (route) => false,
                      );
                    }
                    break;
                }
              },
              itemBuilder: (context) {
                return const [
                  PopupMenuItem<MenuAction>(
                    value: MenuAction.logOut,
                    child: Text('Log Out'),
                  ),
                ];
              },
            ),
          ],
        ),
        body: FutureBuilder(
          future: _notesServices.getOrCreateUser(email: userEmail),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.done:
                return StreamBuilder(
                  stream: _notesServices.allNotes,
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                      case ConnectionState.active:
                        //pastikan koneksinya selalu aktif untuk memasikan setiap note yang
                        //ditambahkan selalu update
                        if (snapshot.hasData) {
                          final allNotes = snapshot.data as List<DatabaseNote>;

                          return NoteListView(
                            notes: allNotes,
                            onDeleteNote: (note) async {
                              await _notesServices.deleteNote(id: note.id);
                            },
                            onTap: (DatabaseNote note) async {
                              Navigator.of(context).pushNamed(
                                createOrUpdateNoteRoute,
                                arguments: note,
                              );
                            },
                          );
                        } else {
                          return const CircularProgressIndicator();
                        }

                      default:
                        const CircularProgressIndicator();
                    }
                    return const CircularProgressIndicator();
                  },
                );

              default:
                return const CircularProgressIndicator();
            }
          },
        ));
  }
}
