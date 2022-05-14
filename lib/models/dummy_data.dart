class MovieItem {
  final String coverUrl;
  final String title;
  int? id;

  MovieItem({
    required this.coverUrl,
    required this.title,
  });
}

final List<MovieItem> MOVIE_DATA = [
  MovieItem(
    coverUrl:
        'https://images.unsplash.com/photo-1620510625142-b45cbb784397?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8am9rZXJ8ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60',
    title: 'The Joker',
  ),
  MovieItem(
    coverUrl:
        'https://images.unsplash.com/photo-1531259683007-016a7b628fc3?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8YmF0bWFufGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60',
    title: 'Batmana',
  ),
  MovieItem(
    coverUrl:
        'https://images.unsplash.com/photo-1538051046377-5ad74dc62f95?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8c3VwZXJtYW58ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60',
    title: 'Supermane',
  ),
  MovieItem(
    coverUrl:
        'https://images.unsplash.com/photo-1500099817043-86d46000d58f?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8bW92aWUlMjBjb3ZlcnxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60',
    title: 'Help',
  ),
  MovieItem(
    coverUrl:
        'https://images.unsplash.com/photo-1618945524163-32451704cbb8?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8dHJhbnNmb3JtZXJzfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60',
    title: 'Transformers',
  ),
];

final List<MovieItem> MOVIE_DATA_10 = [...MOVIE_DATA, ...MOVIE_DATA];
