import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/show_full.dart';
import '../widgets/categories/movie_categories_management.dart';
import '../widgets/comments/comment_titlle.dart';
import '../widgets/comments/comments.dart';
import '../widgets/texts/awards.dart';
import '../widgets/texts/countries.dart';
import '../providers/movie.dart';
import '../widgets/texts/actors.dart';
import '../widgets/texts/directors.dart';
import '../widgets/texts/genre.dart';
import '../widgets/texts/languages.dart';
import '../widgets/texts/plot.dart';
import '../widgets/texts/ratings.dart';
import '../widgets/texts/title.dart' as ttl;
import '../widgets/texts/year_runtime_released.dart';

class ShowDetailScreen extends StatefulWidget {
  static const routName = '/show-detail-screen';

  const ShowDetailScreen({Key? key}) : super(key: key);

  @override
  State<ShowDetailScreen> createState() => _ShowDetailScreenState();
}

class _ShowDetailScreenState extends State<ShowDetailScreen> {
  bool _isInit = true;
  bool _showComments = false;

  void _showCommentsToggle() {
    setState(() {
      _showComments = !_showComments;
    });
  }

  Future<void> _refreshMovieItem(BuildContext ctx, String imdbId) async {
    if (_isInit) {
      await Provider.of<Movie>(ctx, listen: false).getMovie(imdbId);
      _isInit = false;
    }
  }

  void _addMovieToCategory(BuildContext ctx, ShowFull? movie) {
    if (movie == null) {
      return;
    }
    showDialog(
      context: ctx,
      builder: (_) => Dialog(
        child: MovieCategoriesManagement(
          showAddBtn: true,
          addMovieToCategory: () {
            return movie;
          },
        ),
      ),
    );
  }

  List<Widget> _buildSliverListChildren(BuildContext ctx, ShowFull? data) {
    final List<Widget> result = [];
    result.add(
      const SizedBox(
        height: 10,
      ),
    );

    final title = ttl.Title(
      title: data!.title,
    );
    result.add(title);

    final imdbRating = [
      const SizedBox(
        height: 10,
      ),
      Row(
        children: [
          SizedBox(
            height: 30,
            width: 30,
            child: Image.asset(
              'assets/pics/imdb_icon.jpeg',
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${data.imdbrating} / 10.0',
                style: Theme.of(ctx).textTheme.headline4,
              ),
              Text(
                data.imdbvotes,
                style: Theme.of(ctx).textTheme.headline4?.copyWith(
                      color: Colors.grey.shade700,
                      fontSize: 12,
                    ),
              ),
            ],
          ),
          const SizedBox(
            width: 20,
          ),
          Expanded(
            child: Genre(
              genres: [
                ...data.genre.split(','),
              ],
            ),
          ),
        ],
      )
    ];
    result.addAll(imdbRating);

    final yearData = [
      const SizedBox(
        height: 10,
      ),
      YearRuntimeReleased(
        released: data.released,
        runtime: data.runtime,
        year: data.year,
      ),
      const Divider(
        height: 20,
        thickness: 1,
      ),
    ];
    result.addAll(yearData);

    final director = [
      Directors(
        director: data.director,
        writer: data.writer,
      ),
      const Divider(
        height: 20,
        thickness: 1,
      ),
    ];
    result.addAll(director);

    final actors = [
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Actors(
            actors: [
              ...data.actors.split(
                ',',
              ),
            ],
          ),
          Languages(
            languages: data.language.split(','),
          ),
          Countries(
            countries: data.country.split(','),
          ),
        ],
      ),
      const Divider(
        height: 20,
        thickness: 1,
      ),
    ];
    result.addAll(actors);

    final plot = [
      Plot(
        plot: data.plot,
      ),
      const Divider(
        height: 20,
        thickness: 1,
      ),
    ];
    result.addAll(plot);

    final awards = [
      Awards(
        awards: data.awards,
      ),
      const Divider(
        height: 20,
        thickness: 1,
      ),
    ];
    result.addAll(awards);

    final ratings = [
      Ratings(
        ratings: data.ratings,
      ),
      const Divider(
        height: 20,
        thickness: 1,
      ),
    ];
    result.addAll(ratings);

    return result;
  }

  Widget _buildSliverListChildrenComments(
      BuildContext ctx, String movieId, MediaQueryData mediaQuery) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: FirebaseFirestore.instance
          .collection('movie-comments/$movieId/comments')
          .snapshots(),
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SizedBox(
            height: (mediaQuery.size.height - mediaQuery.viewInsets.top) * 0.65,
            child: const Center(
              child: CircularProgressIndicator(
                strokeWidth: 4,
              ),
            ),
          );
        }
        final docs = snapshot.data?.docs;

        return Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
          ),
          height: (mediaQuery.size.height - mediaQuery.viewInsets.top) * 0.65,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommentsTitle(
                movieId: movieId,
                commentExists: docs?.isNotEmpty ?? false,
              ),
              if (docs!.isNotEmpty)
                Comments(
                  movieId: movieId,
                  docs: docs,
                )
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
      ),
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            actions: [
              Consumer<Movie>(
                builder: (ctx, movie, _) => IconButton(
                  onPressed: () => _addMovieToCategory(
                    context,
                    movie.movie,
                  ),
                  icon: const Icon(
                    Icons.category_rounded,
                  ),
                ),
              ),
              IconButton(
                icon: Consumer<Movie>(
                  builder: (ctx, movie, _) => Icon(
                    movie.isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: Colors.red.shade700,
                  ),
                ),
                onPressed: () =>
                    Provider.of<Movie>(context, listen: false).addToFavorites(),
              ),
              IconButton(
                onPressed: _showCommentsToggle,
                icon: const Icon(
                  Icons.insert_comment,
                ),
              ),
            ],
            expandedHeight:
                (mediaQuery.size.height - mediaQuery.viewInsets.top) * 0.3,
            flexibleSpace: FlexibleSpaceBar(
              stretchModes: const [
                StretchMode.zoomBackground,
              ],
              background: SizedBox(
                child: Hero(
                  tag: args['id'],
                  child: args['poster'] != 'N/A'
                      ? Image.network(
                          args['poster'],
                          fit: BoxFit.contain,
                        )
                      : Center(
                          child: Text(
                            'No movie poster',
                            style:
                                Theme.of(context).textTheme.headline4?.copyWith(
                                      color: Colors.white,
                                    ),
                          ),
                        ),
                ),
              ),
            ),
          ),
          FutureBuilder(
              future: _refreshMovieItem(
                context,
                args['id'],
              ),
              builder: (ctx, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return SliverList(
                    delegate: SliverChildListDelegate(
                      [
                        SizedBox(
                          height: (mediaQuery.size.height -
                                  mediaQuery.viewInsets.top) *
                              0.7,
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  return SliverList(
                    delegate: SliverChildListDelegate(
                      [
                        if (Provider.of<Movie>(context, listen: false).movie !=
                                null &&
                            !_showComments)
                          ..._buildSliverListChildren(
                            context,
                            Provider.of<Movie>(context, listen: false).movie,
                          ).map(
                            (e) {
                              return Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                ),
                                child: e,
                              );
                            },
                          ).toList(),
                        if (_showComments)
                          _buildSliverListChildrenComments(
                              context, args['id'], mediaQuery)
                      ],
                    ),
                  );
                }
              })
        ],
      ),
    );
  }
}
