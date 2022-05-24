import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget implements PreferredSizeWidget {
  final Function onSearch;
  const SearchBar({
    required this.onSearch,
    Key? key,
  }) : super(key: key);

  void _search(BuildContext ctx, String term) {
    if (term.isNotEmpty && term.length > 3) {
      onSearch(term);
    } else {
      showDialog(
        context: ctx,
        builder: (_) => AlertDialog(
          backgroundColor: Colors.grey.shade100,
          title: const Text(
            'Warning!',
          ),
          content: const Text(
            'Please provide valid searh term of length at least 4 characters!',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: const Text(
                'OK',
              ),
            ),
          ],
        ),
      );
    }
    FocusScope.of(ctx).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    final searchCtl = TextEditingController();
    return Container(
      margin: const EdgeInsets.all(
        3,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 5,
      ),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: searchCtl,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.search,
              style: Theme.of(context).textTheme.headline4?.copyWith(
                    color: Colors.white,
                  ),
              decoration: InputDecoration(
                hintText: 'Search',
                hintStyle: Theme.of(context).textTheme.headline4?.copyWith(
                      fontWeight: FontWeight.w400,
                      letterSpacing: 1.2,
                    ),
              ),
              onEditingComplete: () {
                _search(context, searchCtl.text);
              },
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          OutlinedButton(
            onPressed: () {
              _search(context, searchCtl.text);
            },
            child: const Icon(
              Icons.search_rounded,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
