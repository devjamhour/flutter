class APIPath {
  static String job(String uid, String jobId) => 'usuarios/$uid/jobs/$jobId';
  static String jobs(String uid) => 'usuarios/$uid/jobs';
  static String entry(String uid, String entryId) =>
      'usuarios/$uid/entries/$entryId';
  static String entries(String uid) => 'usuarios/$uid/entries';
}
