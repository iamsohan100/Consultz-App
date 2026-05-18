class MediaHelper {
  static bool isVideo(String url) {
    final path = url.toLowerCase().split('?').first; // strip S3 query params
    return path.endsWith('.mp4') ||
        path.endsWith('.mov') ||
        path.endsWith('.avi') ||
        path.endsWith('.mkv') ||
        path.endsWith('.webm');
  }

  static bool isImage(String url) => !isVideo(url);
}