String capitalize(String s) => s[0].toUpperCase() + s.substring(1);

String dateWithSlash(DateTime date) {
  return date.day.toString() +
      "/" +
      date.month.toString() +
      "/" +
      date.year.toString();
}

List orderByDate(List list, bool ascending) {
  ascending
      ? list.sort((a, b) => a.date.compareTo(b.date))
      : list.sort((a, b) => b.date.compareTo(a.date));
  return list;
}

List orderByDead(List list) {
  list.sort((a, b) => b.dead.compareTo(a.dead));
  return list;
}
