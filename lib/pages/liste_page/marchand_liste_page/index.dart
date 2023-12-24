import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:otrip/api/marchands/controllers/api_marchand_client.dart';
import 'package:otrip/api/marchands/models/marchand_model.dart';

class MarchandListPage extends StatefulWidget {
  @override
  _MarchandListPageState createState() => _MarchandListPageState();
}

class _MarchandListPageState extends State<MarchandListPage> {
  MarchandService marchandService = MarchandService();
  List<Marchand> marchands = [];
  List<Marchand> filteredMarchands = [];
  Map<String, dynamic> driverData = {};
  Map<String, dynamic> userData = {};

  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchMarchands();
    fetchDriverData();
  }

 Future<void> fetchDriverData() async {
    try {
      Map<String, dynamic> userData = await marchandService.getUserData();
      setState(() {
        driverData = userData;
      });
    } catch (error) {
      print('Error fetching driver data: $error');
    }
  }

  Future<void> fetchMarchands() async {
    try {
      List<Marchand> fetchedMarchands = await marchandService.getAllMarchand();
      setState(() {
        marchands = fetchedMarchands;
        filteredMarchands = marchands;
      });
    } catch (error) {
      print('Error fetching marchands: $error');
    }
  }

  void filterMarchands(String query) {
    setState(() {
      filteredMarchands = marchands
          .where((marchand) =>
              marchand.firstname!.toLowerCase().contains(query.toLowerCase()) ||
              marchand.lastname!.toLowerCase().contains(query.toLowerCase()) ||
              marchand.phoneNumber!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  Future<void> fetchUserData() async {
    try {
      userData = await marchandService.getUserData();
      if (userData.containsKey('phoneNumber')) {
        Map<String, dynamic>? userInfo = await marchandService.getUserInfoByPhone(userData['phoneNumber']);
        print('User Info: $userInfo'); 
        if (userInfo != null) {
          setState(() {
            driverData = userInfo;
          });
        }
      }
    } catch (error) {
      print('Error fetching user data: $error');
      // Gérer les erreurs ici
    }
  }




  void showMarchandDialog(Marchand marchand) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Informations sur le marchand'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Nom complet: ${marchand.firstname} ${marchand.lastname}'),
              Text('Numéro de téléphone: ${marchand.phoneNumber}'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () async {
              await fetchUserData();
                try {
                  print(userData['phoneNumber']);
                  print(driverData['id']);
                  print(marchand.id);
                   print(driverData['id'].toString());
                  print(marchand.id.toString());
                  if (driverData['id'] != null) {
                    await marchandService.makeParrainage(
                      marchand.id.toString(),
                      driverData['id'].toString(),
                    );
                    Navigator.of(context).pop();
                  } else {
                    print('Driver ID is null');
                  }
                } catch (error) {
                  print('Error making parrainage: $error');
                }
              },
              child: Text('Valider le parrainage'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Annuler'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Liste des marchands'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: TextField(
                  controller: searchController,
                  onChanged: filterMarchands,
                  decoration: InputDecoration(
                    labelText: 'Rechercher un marchand',
                    prefixIcon: Icon(Icons.search),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: filteredMarchands.isNotEmpty
                ? ListView.builder(
                    itemCount: filteredMarchands.length,
                    itemBuilder: (context, index) {
                      Marchand marchand = filteredMarchands[index];
                      return Card(
                        elevation: 5,
                        margin: EdgeInsets.all(8.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: ListTile(
                          title: Text('${marchand.firstname} ${marchand.lastname}'),
                          subtitle: Text('${marchand.phoneNumber}'),
                          onTap: () {
                            showMarchandDialog(marchand);
                          },
                        ),
                      );
                    },
                  )
                : Center(
                    child: Text('Aucun marchand trouvé'),
                  ),
          ),
        ],
      ),
    );
  }
}
