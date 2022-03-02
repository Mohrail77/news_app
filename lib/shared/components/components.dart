import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/modules/web_view/web_view_screen.dart';

Widget buildArticleItem(article, context) => InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => WebViewScreen(article['url']),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Container(
              width: 120.0,
              height: 120.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                image: DecorationImage(
                  image: NetworkImage('${article['urlToImage']}'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(
              width: 20.0,
            ),
            Expanded(
              // ignore: sized_box_for_whitespace

              child: Container(
                height: 120.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        '${article['title']}',
                        style: Theme.of(context).textTheme.bodyText1,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      '${article['publishedAt']}',
                      style: const TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );

// ignore: non_constant_identifier_names
Widget MyDivider() => Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        width: double.infinity,
        height: 1.0,
        color: Colors.grey[300],
      ),
    );

Widget articleBuilder(list, context, bool bool, {isSearch = false}) =>
    ConditionalBuilder(
      condition: list.length > 0,
      builder: (context) => ListView.separated(
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) => buildArticleItem(list[index], context),
        separatorBuilder: (context, index) => MyDivider(),
        itemCount: 10,
      ),
      fallback: (context) => isSearch
          ? Container()
          : const Center(child: CircularProgressIndicator()),
    );

Widget defaultTextform({
  @required TextEditingController controller,
  @required TextInputType textInputType,
  @required Function validate,
  Function onSubmitted,
  Function onchanged,
  Function onTap,
  @required String labeltext,
  @required IconData prefix,
  IconData suffix,
  bool observedtext = false,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: textInputType,
      obscureText: observedtext,
      onFieldSubmitted: onSubmitted,
      onChanged: onchanged,
      validator: validate,
      decoration: InputDecoration(
        labelText: labeltext,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
        prefixIcon: Icon(prefix),
        suffix: Icon(suffix),
      ),
    );
