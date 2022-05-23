import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NewComment extends StatefulWidget {
  final String movieId;
  const NewComment({
    required this.movieId,
    Key? key,
  }) : super(key: key);

  @override
  State<NewComment> createState() => _NewCommentState();
}

class _NewCommentState extends State<NewComment> {
  final _form = GlobalKey<FormState>();
  final TextEditingController _commentCtl = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _commentCtl.dispose();
  }

  void _saveForm() async {
    FocusScope.of(context).unfocus();
    var isValid = _form.currentState?.validate() ?? false;
    if (!isValid) {
      return;
    }
    var comment = _commentCtl.text.trim();

    try {
      final userData = await FirebaseFirestore.instance
          .collection('users')
          .doc(
            FirebaseAuth.instance.currentUser?.uid,
          )
          .get();

      await FirebaseFirestore.instance
          .collection('movie-comments/${widget.movieId}/comments')
          .add(
        {
          'comment': comment,
          'likes': 0,
          'dislikes': 0,
          'createdAt': Timestamp.now(),
          'userName': userData['username'],
        },
      );
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Something went wrong!'),
          duration: Duration(
            seconds: 1,
          ),
        ),
      );
    }

    _commentCtl.clear();
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(
          right: 20,
          left: 20,
          top: 10,
          bottom: mediaQuery.viewInsets.bottom + 10,
        ),
        child: Form(
          key: _form,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextFormField(
                controller: _commentCtl,
                decoration: const InputDecoration(
                  labelText: 'Comment',
                ),
                keyboardAppearance: Brightness.dark,
                maxLines: 2,
                style: Theme.of(context).textTheme.headline4?.copyWith(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                    ),
                keyboardType: TextInputType.multiline,
                validator: (value) {
                  var temp = value ?? '';
                  if (temp.isEmpty) {
                    return 'Please enter a comment';
                  }
                  if (temp.length < 10) {
                    return 'Comment should be at least 10 characters long';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: mediaQuery.size.height * 0.02,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _saveForm,
                  child: Text(
                    'ADD',
                    style: Theme.of(context).textTheme.headline4?.copyWith(
                          letterSpacing: 1,
                        ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
