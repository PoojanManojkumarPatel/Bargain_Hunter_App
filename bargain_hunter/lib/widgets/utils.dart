String getTimeRemaining(String? endDateStr) {
  if (endDateStr == null) return "No end date";

  final endDate = DateTime.tryParse(endDateStr);
  if (endDate == null) return "Invalid date";

  final now = DateTime.now();
  final difference = endDate.difference(now);

  if (difference.isNegative) return "Expired";

  if (difference.inDays > 0) {
    return "${difference.inDays} day(s) left";
  } else if (difference.inHours > 0) {
    return "${difference.inHours} hour(s) left";
  } else {
    return "${difference.inMinutes} min(s) left";
  }
}