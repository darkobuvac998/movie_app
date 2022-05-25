import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NewMovieCategory extends StatelessWidget {
  const NewMovieCategory({
    Key? key,
  }) : super(key: key);

  Future<void> _addNewMovieCategory(BuildContext ctx, String name) async {
    if (name.length <= 4) {
      ScaffoldMessenger.of(ctx).showSnackBar(
        SnackBar(
          content: const Text(
            'Category name should have more than 4 characters!',
          ),
          backgroundColor: Theme.of(ctx).errorColor,
        ),
      );
      return;
    } else if (name.isEmpty) {
      ScaffoldMessenger.of(ctx).showSnackBar(
        SnackBar(
          content: const Text(
            'Please provide a category name!',
          ),
          backgroundColor: Theme.of(ctx).errorColor,
        ),
      );
      return;
    }
    try {
      final user = FirebaseAuth.instance.currentUser;
      final path = 'user-categories/${user?.uid}/categories';
      await FirebaseFirestore.instance.collection(path).doc().set({
        'name': name,
        'show': true,
      });
    } catch (error) {
      ScaffoldMessenger.of(ctx).showSnackBar(
        SnackBar(
          content: const Text(
            'Something went wrong!',
          ),
          backgroundColor: Theme.of(ctx).errorColor,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    final categoryCtl = TextEditingController();
    return SizedBox(
      height: deviceSize.height * 0.245,
      width: 200,
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(
              top: 5,
            ),
            child: Text(
              'New category',
              style: Theme.of(context).textTheme.headline4?.copyWith(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w300,
                  ),
            ),
          ),
          const Divider(
            height: 10,
            thickness: 2,
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 10,
            ),
            child: TextFormField(
              style: Theme.of(context).textTheme.headline4?.copyWith(
                    color: Colors.white,
                  ),
              controller: categoryCtl,
              decoration: const InputDecoration(
                labelText: 'Category name',
              ),
              textInputAction: TextInputAction.done,
            ),
          ),
          const Divider(
            height: 10,
            thickness: 2,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {
                  _addNewMovieCategory(context, categoryCtl.text);
                  Navigator.of(context).pop();
                },
                child: Text(
                  'Save',
                  style: Theme.of(context).textTheme.headline4?.copyWith(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                ),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(
                  'Cancel',
                  style: Theme.of(context).textTheme.headline4?.copyWith(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
