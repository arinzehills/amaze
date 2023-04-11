class GetAudioName {
  static get(String filename) {
    return filename.split('.')[0];
  }

  static getAudioFromUrl(url) {
    Uri uri = Uri.parse(url);
    String lastSegment = uri.pathSegments.last;
    return lastSegment;
  }
}
