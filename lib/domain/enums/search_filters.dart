enum SearchFilters{
  ah(name: 'A-H', regExp:  r'\b[a-h]\w+',),
  ip(name: 'I-P', regExp: r'\b[i-p]\w+',),
  qz(name: 'Q-Z', regExp: r'\b[q-z]\w+',),
  empty(name: '', regExp: '',);

  const SearchFilters({
    required this.name,
    required this.regExp,
  });

  final String name;
  final String regExp;
}
