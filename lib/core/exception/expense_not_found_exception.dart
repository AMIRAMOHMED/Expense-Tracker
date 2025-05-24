class ExpenseNotFoundException implements Exception {
  final String message;
  ExpenseNotFoundException(this.message);
}