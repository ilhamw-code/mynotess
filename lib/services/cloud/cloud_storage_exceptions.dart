class CloudStorangeException implements Exception {
  const CloudStorangeException();
}

// C in CRUD
class CouldNotCreateNoteException extends CloudStorangeException {}

// R In CRUD
class CouldNotGetAllNoteException extends CloudStorangeException {}

//U In CRUD
class CouldNotUpdateNoteException extends CloudStorangeException {}

//D In CRUD
class CouldNoteDeleteNoteException extends CloudStorangeException {}
