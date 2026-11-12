class CruiseDestination {
  final String name;
  final String location;
  final String description;
  final String imagePath;
  final int initialRating;

  const CruiseDestination({
    required this.name,
    required this.location,
    required this.description,
    required this.imagePath,
    required this.initialRating,
  });

  static const CruiseDestination rajangRiver = CruiseDestination(
    name: 'Rajang River Express Cruise',
    location: 'Sibu Waterfront, Sarawak',
    description:
    'Experience the beauty of Sibu along Malaysia\'s longest river, '
        'the Rajang. Cruise past historic temples, riverside settlements, '
        'and scenic waterfront views while discovering the culture, '
        'heritage, and peaceful atmosphere of Sarawak. This journey offers '
        'a relaxing and memorable river cruise experience for visitors.',
    imagePath: 'assets/images/rajang_river.jpg',
    initialRating: 43,
  );

  static const List<String> cruisePackages = [
    'Private River Cruise',
    'Sunset Cruise',
    'Sunrise Cruise',
    'Rural Cruise',
    'SMI Park Cruise',
  ];
}