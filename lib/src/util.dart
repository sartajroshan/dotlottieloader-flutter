extension StringParsing on String {
  String lastSegmentName() {
    return split("/").last;
  }

  String withoutExt() {
    return split(".").first;
  }
}
