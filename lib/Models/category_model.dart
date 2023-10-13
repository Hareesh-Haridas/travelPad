import 'package:equatable/equatable.dart';

class Category extends Equatable {
  final String name;
  final String imageUrl;
  const Category({
    required this.name,
    required this.imageUrl,
  });

  @override
  List<Object?> get props => [name, imageUrl];
  static List<Category> categories = [
    const Category(name: 'Goa', imageUrl: 'lib/assets/goa.jpg'),
    const Category(name: 'Manali', imageUrl: 'lib/assets/manali.jpg'),
    const Category(name: 'Nandi Hills', imageUrl: 'lib/assets/nandi hills.jpg'),
    const Category(name: 'Jog Falls', imageUrl: 'lib/assets/jog-falls.jpg'),
    const Category(name: 'Shimla', imageUrl: 'lib/assets/Shimla.jpg')
  ];
}
