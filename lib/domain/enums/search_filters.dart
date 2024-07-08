enum SearchFilters{
  ah(name: 'A-H', regExp:  r'\b[a-hA-h]\w+',),
  ip(name: 'I-P', regExp: r'\b[i-pI-P]\w+',),
  qz(name: 'Q-Z', regExp: r'\b[q-zQ-Z]\w+',),
  empty(name: '', regExp: '',);

  const SearchFilters({
    required this.name,
    required this.regExp,
  });

  final String name;
  final String regExp;
}
