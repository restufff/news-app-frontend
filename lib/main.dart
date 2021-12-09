// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'api/services.dart';

void main() => runApp(UnasBerita());

class UnasBerita extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: " UNAS Berita",
      theme: ThemeData(
        primaryColor: Colors.green,
      ),
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<List<Category>> getCategoris() async {
    var url = "https://backendnewsta.herokuapp.com/categories";
    var response = await http.get(url);
    var jsonString = response.body;
    List<Category> categories = categoryFromJson(jsonString);

    return categories;
  }

  @override
  void initState() {
    super.initState();
    //getCategoris().then((value) => print(value));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Image.asset('images/unas.png'),
        title: Text("Portal Berita UNAS",
            style: TextStyle(color: Color(0xFF000000))),
        backgroundColor: Colors.white,
        elevation: 1,
        shadowColor: Colors.greenAccent[400],
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          FutureBuilder<List<Category>>(
              future: getCategoris(),
              builder: (context, snapshot) {
                return snapshot.data == null
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : Expanded(
                        child: GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2),
                            itemCount: snapshot.data == null
                                ? 0
                                : snapshot.data.length,
                            itemBuilder: (context, index) {
                              Category item = snapshot.data[index];
                              return InkWell(
                                child: GridTile(
                                  child: Container(
                                    child: Text(
                                      item.name,
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    padding: EdgeInsets.all(15),
                                    margin: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        image: DecorationImage(
                                            image: NetworkImage(item.image.url),
                                            fit: BoxFit.cover)),
                                  ),
                                ),
                                onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ArticlesScreen(
                                            articlesList: item.articles,
                                            categoryName: item.name))),
                              );
                            }),
                      );
              })
        ],
      ),
    );
  }
}

//Articles Screen
class ArticlesScreen extends StatelessWidget {
  final List<Article> articlesList;
  final String categoryName;

  const ArticlesScreen({Key key, this.articlesList, this.categoryName})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(categoryName, style: TextStyle(color: Color(0xFF000000))),
        backgroundColor: Colors.white,
        elevation: 1,
        shadowColor: Colors.greenAccent[400],
      ),
      body: ListView.builder(
          itemCount: articlesList.length,
          itemBuilder: (context, index) {
            return Container(
              padding: EdgeInsets.all(5),
              child: Card(
                child: ListTile(
                  contentPadding: EdgeInsets.all(10),
                  title: Text(
                    articlesList[index].title,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  leading: CircleAvatar(
                    radius: 30,
                    backgroundImage:
                        NetworkImage(articlesList[index].image.url),
                  ),
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DetailsScreen(
                              articlesDetails: articlesList[index]))),
                ),
              ),
            );
          }),
    );
  }
}

//Detail News
class DetailsScreen extends StatelessWidget {
  final articlesDetails;

  const DetailsScreen({Key key, this.articlesDetails}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("UNAS Berita"),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          Text(
            articlesDetails.title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
          ),
          Padding(
            padding: const EdgeInsets.all(5),
            child: Container(
              height: 200,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(articlesDetails.image.url),
                      fit: BoxFit.cover),
                  boxShadow: [BoxShadow(color: Colors.black, blurRadius: 3)],
                  border: Border.all(color: Colors.black, width: 1)),
            ),
          ),
          Text(articlesDetails.content)
        ],
      ),
    );
  }
}
