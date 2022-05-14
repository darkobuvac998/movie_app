import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../models/show_full.dart';
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

class ShowDetailScreen extends StatelessWidget {
  static const routName = '/show-detail-screen';
  const ShowDetailScreen({Key? key}) : super(key: key);

  Future<void> _refreshMovieItem(BuildContext ctx, String imdbId) async {
    await Provider.of<Movie>(ctx, listen: false).getMovie(imdbId);
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
              IconButton(
                icon: const Icon(
                  Icons.favorite,
                ),
                onPressed: () {},
              )
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
                  child: Image.network(
                    args['poster'],
                    fit: BoxFit.contain,
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
                        Container(
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
                            null)
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
