class QueryResult {
  final List<Map<String, dynamic>> data;
  final int totalItems;
  final int totalPages;

  QueryResult({
    required this.data,
    required this.totalItems,
    required this.totalPages,
  });
}
