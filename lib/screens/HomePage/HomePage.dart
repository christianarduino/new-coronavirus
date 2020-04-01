import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:new_coronavirus/components/RowText.dart';
import 'package:new_coronavirus/models/DataGroup.dart';
import 'package:new_coronavirus/models/National.dart';
import 'package:new_coronavirus/models/Regional.dart';
import 'package:new_coronavirus/models/ResponseStatus.dart';
import 'package:new_coronavirus/network/HomeNetwork/HomeNetwork.dart';
import 'package:new_coronavirus/redux/actions/DataActions.dart';
import 'package:new_coronavirus/redux/store/AppState.dart';
import 'package:http/http.dart' as http;
import 'package:new_coronavirus/screens/HomePage/components/HomeCard.dart';
import 'package:new_coronavirus/components/LabelWithData.dart';
import 'package:new_coronavirus/screens/NationalDataPage/NationalDataPage.dart';
import 'package:new_coronavirus/screens/ProvincialDataPage/ProvincialDataPage.dart';
import 'package:new_coronavirus/screens/RegionalDataPage/RegionalDataPage.dart';
import 'package:new_coronavirus/utils/Popup.dart';
import 'package:new_coronavirus/utils/functions.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:redux/redux.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<bool> futureSuccess;
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  Future<bool> getTotalData(Store<AppState> store) async {
    bool totalSuccess = true;
    int i = 0;
    http.Client client = http.Client();

    List<ResponseStatus> list = await Future.wait([
      HomeNetwork.getNationalData(client),
      HomeNetwork.getRegionalData(false, client),
      HomeNetwork.getRegionalData(true, client),
      HomeNetwork.getProvincialData(client),
    ]);

    client.close();

    while (i < list.length && totalSuccess) {
      if (!list[i].success) totalSuccess = false;
      i++;
    }

    if (totalSuccess) {
      DataGroup dataGroup = DataGroup(
        national: list[0].data,
        regional: list[1].data,
        regionalLatest: list[2].data,
        provincial: list[3].data,
      );
      store.dispatch(SaveData(dataGroup));
    }

    return totalSuccess;
  }

  void _onRefresh(Store<AppState> store) {
    setState(() {
      futureSuccess = getTotalData(store);
    });
    _refreshController.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    int count =
        MediaQuery.of(context).orientation == Orientation.landscape ? 4 : 2;
    const double sizeData = 30;
    const double sizeLabel = 20;
    return Scaffold(
      appBar: AppBar(
        title: Text("ITALIA 🇮🇹"),
      ),
      body: StoreConnector<AppState, Store<AppState>>(
        onInit: (store) => futureSuccess = getTotalData(store),
        converter: (store) => store,
        builder: (context, store) {
          AppState state = store.state;
          return FutureBuilder(
            future: futureSuccess,
            builder: (_, AsyncSnapshot<bool> snapshot) {
              if (snapshot.connectionState != ConnectionState.done)
                return Center(child: CircularProgressIndicator());

              if (!snapshot.data)
                return Center(
                  child: Text("Si è verificato un errore"),
                );

              List<National> nationals = state.nationals;
              List<Regional> regionalList = state.regionalLatest;
              National lastNational = nationals[0];
              return SmartRefresher(
                controller: _refreshController,
                onRefresh: () => _onRefresh(store),
                child: ListView(
                  padding: EdgeInsets.symmetric(
                    vertical: 20,
                    horizontal: 25,
                  ),
                  children: <Widget>[
                    RowText(
                      text1: "Andamento nazionale",
                      text2: "Di più",
                      onTextTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => NationalDataPage(),
                        ),
                      ),
                    ),
                    GridView(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: 10 / 8,
                        crossAxisCount: count,
                        crossAxisSpacing: 5.0,
                        mainAxisSpacing: 5.0,
                      ),
                      children: <Widget>[
                        LabelWithData(
                          label: "Casi totali",
                          data: lastNational.totalCases.toString(),
                          sizeData: sizeData,
                          sizeLabel: sizeLabel,
                        ),
                        LabelWithData(
                          label: "Nuovi infetti",
                          data: lastNational.newInfected.toString(),
                          sizeData: sizeData,
                          sizeLabel: sizeLabel,
                        ),
                        LabelWithData(
                          label: "Deceduti",
                          data: lastNational.dead.toString(),
                          sizeData: sizeData,
                          sizeLabel: sizeLabel,
                        ),
                        LabelWithData(
                          label: "Guariti",
                          data: lastNational.recovered.toString(),
                          sizeData: sizeData,
                          sizeLabel: sizeLabel,
                        ),
                      ],
                    ),
                    Tooltip(
                      message: "In ordine decrescente per numero di deceduti",
                      child: RowText(
                        text1: "Classifica regioni",
                        text2: "Di più",
                        onTextTap: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => RegionalDataPage(),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 25),
                    Builder(
                      builder: (context) {
                        List<Regional> regionalRange =
                            regionalList.getRange(0, 3).toList();

                        List<LinearGradient> gradients = [
                          LinearGradient(
                            colors: [
                              Theme.of(context).accentColor,
                              Color(0xFF599287),
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomRight,
                            stops: [0.4, 1],
                          ),
                          LinearGradient(
                            colors: [
                              Color(0xFFF0896F),
                              Color(0xFFF19A82),
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomRight,
                            stops: [0.7, 1],
                          ),
                          LinearGradient(
                            colors: [
                              Color(0xFFF7D374),
                              Color(0xFFEACF75),
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomRight,
                          ),
                        ];
                        return SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: regionalRange
                                .asMap()
                                .map(
                                  (int i, Regional regional) {
                                    return MapEntry(
                                      i,
                                      HomeCard(
                                        gradient: gradients[i],
                                        regional: regional,
                                        onTap: () => Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (_) => ProvincialDataPage(
                                              regional: regional,
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                )
                                .values
                                .toList(),
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 25),
                    Row(
                      children: <Widget>[
                        Expanded(
                          flex: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "Ultimo aggiornamento: ${dateWithSlash(nationals[0].date)}",
                              ),
                              Row(
                                children: <Widget>[
                                  Text("Fonte: "),
                                  GestureDetector(
                                    child: Text(
                                      "Protezione Civile",
                                      style: TextStyle(
                                        decoration: TextDecoration.underline,
                                        color: Theme.of(context).accentColor,
                                      ),
                                    ),
                                    onTap: () async {
                                      const url =
                                          'https://github.com/pcm-dpc/COVID-19';
                                      if (await canLaunch(url)) {
                                        await launch(url);
                                      } else {
                                        Popup.error(
                                          context,
                                          "Non è stato possibile aprire il sito",
                                        );
                                      }
                                    },
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Image.asset(
                            "assets/logo.png",
                            height: 60,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
