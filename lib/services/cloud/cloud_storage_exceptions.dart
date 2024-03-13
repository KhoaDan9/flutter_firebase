class CloudStorageException implements Exception {
  const CloudStorageException();
}

//create
class CouldNotCreateNoteException implements CloudStorageException {}

//read
class CouldNotGetAllNotesException implements CloudStorageException {}

//update
class CouldNotUpdateNoteException implements CloudStorageException {}

//delete
class CouldNotDeleteNoteException implements CloudStorageException {}
