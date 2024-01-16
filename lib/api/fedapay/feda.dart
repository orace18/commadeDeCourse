import 'package:feda/feda.dart';

class FedaApi {

  getAllData() async {
    var data = await Feda.all_transactions();
    print(data);
  }

  createRedirectTransaction(String email, String country, String network, String phoneNumber, double amount) async {
    // Récupération du lien de paiement pour lantransaction afin de faire une redirection
    var transaction_link = await Feda.create_transaction(
      FedaTransactionRequest(
        amount: amount,
          clienMail: email,
          description: "Ma premiere trx feda",
          phone_number: {
            'number': phoneNumber,
            'country': country,
          }),
      reseau: network,
    );
    print(transaction_link);

    // --- ou ---

    // Feda.create_transaction(
    //   FedaTransactionRequest(
    //       amount: 500,
    //       clienMail: "tbaissou@gmail.com",
    //       description: "Ma premiere trx feda",
    //       phone_number: {
    //         'number': "65924088",
    //         'country': 'bj',
    //       }),
    // ).then((transaction_lien) {

    //    // code de redirection

    // });
  }

  createTransaction(String email, String country, String network, String phoneNumber, double amount) async {
    Feda.create_transaction(
      // Transaction sans redirection
      // Pour les réseaux, je ne connais que les valeurs ci apreès : 'mtn', 'moov', 'mtn_ci', 'moov_tg', 'mtn_open', 'airtel_ne', 'free_sn','togocel', 'mtn_ecw'
      // Vous allez devoir vous débrouillez pour le reste 😅😅
        FedaTransactionRequest(
            amount: 500,
            clienMail: "tbaissou@gmail.com",
            description: "Ma premiere trx feda",
            phone_number: {
              'number': "65924088",
              'country': 'bj',
            }),
        redirect: false,
        reseau: network);
  }

}