import 'package:flutter/material.dart';
import 'package:news/article.dart';
import 'package:news/detail_page.dart';
import 'article.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: NewsListPage.routeName,
      routes: {
        NewsListPage.routeName: (context) => NewsListPage(),
        ArticleDetailPage.routeName: (context) => ArticleDetailPage(
          article: ModalRoute.of(context).settings.arguments,
        ),
        ArticleWebView.routeName: (context) => ArticleWebView(
          url: ModalRoute.of(context).settings.arguments,
        ),
      },
    );
  }
}

class NewsListPage extends StatelessWidget {
  static const routeName = 'article_list';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News App'),
      ),
      body: FutureBuilder<String>(
        future:
        DefaultAssetBundle.of(context).loadString('assests/articles.json'),
        builder: (context,snapshot){
          final List<Article> articles = parseArticles(snapshot.data);
          return ListView.builder(
              itemCount: articles.length,
            itemBuilder: (context,index){
                return _buildArticleItem(context,articles[index]);
            },
          );
        },
      ),
    );
  }
}

Widget _buildArticleItem (BuildContext context, Article article){
  return ListTile(
    contentPadding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 8.0),
    leading: Image.network(
      article.urlToImage,
      width: 100,
    ),
    title: Text(article.title),
    subtitle: Text(article.author),
    onTap: (){
      Navigator.pushNamed(context, ArticleDetailPage.routeName, arguments: article);
    },
  );
}

