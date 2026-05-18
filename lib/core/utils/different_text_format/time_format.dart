String timeFormat(String isoDate) {
  DateTime dateTime = DateTime.parse(isoDate).toLocal();
  Duration diff = DateTime.now().difference(dateTime);

  if (diff.inSeconds < 60) {
    return "${diff.inSeconds} sec ago";
  } else if (diff.inMinutes < 60) {
    return "${diff.inMinutes} min ago";
  } else if (diff.inHours < 24) {
    return "${diff.inHours} hr ago";
  } else if (diff.inDays < 30) {
    int days = diff.inDays;
    return "$days day${days > 1 ? 's' : ''} ago";
  } else if (diff.inDays < 365) {
    int months = (diff.inDays / 30).floor();
    return "$months mon ago";
  } else {
    int years = (diff.inDays / 365).floor();
    return "$years year${years > 1 ? 's' : ''} ago";
  }
}
