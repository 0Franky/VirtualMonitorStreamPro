class NoServerCommandFound implements Exception {
  final String msg = "No command to start server found for this platform!";

  const NoServerCommandFound({message});

  @override
  String toString() => 'Details: $msg';
}
