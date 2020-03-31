String capitalize(String s) => s[0].toUpperCase() + s.substring(1);

String dateWithSlash(DateTime date) {
  return date.day.toString() +
      "/" +
      date.month.toString() +
      "/" +
      date.year.toString();
}

List orderByDate(List list) {
  list.sort((a, b) => b.date.compareTo(a.date));
  return list;
}
