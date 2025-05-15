import 'dart:convert';
import 'dart:io';

import 'package:albassel_version_1/const/app.dart';
import 'package:albassel_version_1/const/global.dart';
import 'package:albassel_version_1/controler/cart_controller.dart';
import 'package:albassel_version_1/controler/checkout_controller.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:myfatoorah_flutter/myfatoorah_flutter.dart';


final String mAPIKey = "";
class MyFatoraahPage extends StatefulWidget {

  MyFatoraahPage(this.title,this.total);

  final String title;
  final String total;

  @override
  _MyHomePageState createState() => _MyHomePageState(total);
}

class _MyHomePageState extends State<MyFatoraahPage> {

  _MyHomePageState(this.amount);

  CheckoutController checkoutController = Get.find();
  CartController cartController = Get.find();

  String? _response = '';
  MFInitiateSessionResponse? session;

  List<MFPaymentMethod> paymentMethods = [];
  List<bool> isSelected = [];
  int selectedPaymentMethodIndex = -1;

  String cardNumber = "5453010000095489";
  String expiryMonth = "05";
  String expiryYear = "21";
  String securityCode = "100";
  String cardHolderName = "Test Account";

  String amount = "5.00";
  bool visibilityObs = false;
  late MFCardPaymentView mfCardView;
  late MFApplePayButton mfApplePayButton;
  late MFGooglePayButton mfGooglePayButton;

  @override
  void initState() {
    super.initState();
    initiate();
  }

  @override
  void dispose() {
    super.dispose();
  }

  initiate() async {
    // if (Config.testAPIKey.isEmpty) {
    //   setState(() {
    //     _response =
    //     "Missing API Token Key.. You can get it from here: https://myfatoorah.readme.io/docs/test-token";
    //   });
    //   return;
    // }

    // TODO, don't forget to init the MyFatoorah Plugin with the following line
    await MFSDK.init(mAPIKey, MFCountry.UAE, MFEnvironment.LIVE);
    // (Optional) un comment the following lines if you want to set up properties of AppBar.
    // MFSDK.setUpActionBar(
    //     toolBarTitle: 'Company Payment',
    //     toolBarTitleColor: '#FFEB3B',
    //     toolBarBackgroundColor: '#CA0404',
    //     isShowToolBar: true);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await initiateSessionForCardView();
      // await initiateSessionForGooglePay();
      await initiatePayment();
      // await initiateSession();
    });
  }

  log(Object object) {
    print('**** HERE ****');
    print(object);
    if(object is MFGetPaymentStatusResponse){
      print('*****');
      print(object.invoiceStatus!);
      if(object.invoiceStatus != null && object.invoiceStatus == 'Paid'){
        //todo successfully payment
        checkoutController.my_order.addAll(cartController.my_order);
        checkoutController.is_paid.value=true;
        checkoutController.add_order_payment(context);
        checkoutController.selected_operation++;
        // print(invoiceId);
        // print(result.response!.toJson());
        // _response = result.response!.toJson().toString();
      }else{
        checkoutController.selected.value=false;
      }
    }
    var json = const JsonEncoder.withIndent('  ').convert(object);
    setState(() {
      debugPrint(json);
      _response = json;

    });
  }

  // Send Payment
  sendPayment() async {
    var request = MFSendPaymentRequest(
        invoiceValue: double.parse(amount),
        customerName: "Customer name",
        notificationOption: MFNotificationOption.LINK);
    // var invoiceItem = MFInvoiceItem(itemName: "item1", quantity: 1, unitPrice: 1);
    // request.invoiceItems = [invoiceItem];

    await MFSDK
        .sendPayment(request, MFLanguage.ENGLISH)
        .then((value) => log(value))
        .catchError((error) => {log(error)});
  }

  // Initiate Payment
  initiatePayment() async {
    var request = MFInitiatePaymentRequest(
        invoiceAmount: double.parse(amount),
        currencyIso: MFCurrencyISO.UAE_AED);

    await MFSDK
        .initiatePayment(request, MFLanguage.ENGLISH)
        .then((value) => {
      log(value),
      paymentMethods.addAll(value.paymentMethods!),
      for (int i = 0; i < paymentMethods.length; i++)
        isSelected.add(false)
    })
        .catchError((error) => {log(error.message)});
  }

  // Execute Regular Payment
  executeRegularPayment(int paymentMethodId) async {
    var request = MFExecutePaymentRequest(
        paymentMethodId: paymentMethodId, invoiceValue: double.parse(amount));
    request.displayCurrencyIso = MFCurrencyISO.UAE_AED;

    // var recurring = MFRecurringModel();
    // recurring.intervalDays = 10;
    // recurring.recurringType = MFRecurringType.Custom;
    // recurring.iteration = 2;
    // request.recurringModel = recurring;

    await MFSDK
        .executePayment(request, MFLanguage.ENGLISH, (invoiceId) {
      log(invoiceId);
    })
        .then((value) => log(value))
        .catchError((error) => {log(error.message)});
  }

  //Execute Direct Payment
  executeDirectPayment(int paymentMethodId, bool isToken) async {
    var request = MFExecutePaymentRequest(
        paymentMethodId: paymentMethodId, invoiceValue: double.parse(amount));

    var token = isToken ? "TOKEN210282" : null;
    var mfCardRequest = isToken
        ? null
        : MFCard(
      cardHolderName: cardHolderName,
      number: cardNumber,
      expiryMonth: expiryMonth,
      expiryYear: expiryYear,
      securityCode: securityCode,
    );

    var directPaymentRequest = MFDirectPaymentRequest(
        executePaymentRequest: request, token: token, card: mfCardRequest);
    log(directPaymentRequest);
    await MFSDK
        .executeDirectPayment(directPaymentRequest, MFLanguage.ENGLISH,
            (invoiceId) {
          debugPrint("-----------$invoiceId------------");
          log(invoiceId);
        })
        .then((value) => log(value))
        .catchError((error) => {log(error.message)});
  }

  // Payment Enquiry
  getPaymentStatus() async {
    MFGetPaymentStatusRequest request =
    MFGetPaymentStatusRequest(key: '1515410', keyType: MFKeyType.INVOICEID);

    await MFSDK
        .getPaymentStatus(request, MFLanguage.ENGLISH)
        .then((value) => log(value))
        .catchError((error) => {log(error.message)});
  }

  // Cancel Token
  cancelToken() async {
    await MFSDK
        .cancelToken("Put your token here", MFLanguage.ENGLISH)
        .then((value) => log(value))
        .catchError((error) => {log(error.message)});
  }

  // Cancel Recurring Payment
  cancelRecurringPayment() async {
    await MFSDK
        .cancelRecurringPayment("Put RecurringId here", MFLanguage.ENGLISH)
        .then((value) => log(value))
        .catchError((error) => {log(error.message)});
  }

  setPaymentMethodSelected(int index, bool value) {
    for (int i = 0; i < isSelected.length; i++) {
      if (i == index) {
        isSelected[i] = value;
        if (value) {
          selectedPaymentMethodIndex = index;
          visibilityObs = paymentMethods[index].isDirectPayment!;
        } else {
          selectedPaymentMethodIndex = -1;
          visibilityObs = false;
        }
      } else {
        isSelected[i] = false;
      }
    }
  }

  executePayment() {
    if (selectedPaymentMethodIndex == -1) {
      setState(() {
        _response = "Please select payment method first";
      });
    } else {
      if (amount.isEmpty) {
        setState(() {
          _response = "Set the amount";
        });
      } else if (paymentMethods[selectedPaymentMethodIndex].isDirectPayment!) {
        if (cardNumber.isEmpty ||
            expiryMonth.isEmpty ||
            expiryYear.isEmpty ||
            securityCode.isEmpty) {
          setState(() {
            _response = "Fill all the card fields";
          });
        } else {
          executeDirectPayment(
              paymentMethods[selectedPaymentMethodIndex].paymentMethodId!,
              false);
        }
      } else {
        executeRegularPayment(
            paymentMethods[selectedPaymentMethodIndex].paymentMethodId!);
      }
    }
  }

  MFCardViewStyle cardViewStyle() {
    MFCardViewStyle cardViewStyle = MFCardViewStyle();
    cardViewStyle.cardHeight = 200;
    cardViewStyle.hideCardIcons = false;
    cardViewStyle.input?.inputMargin = 3;
    cardViewStyle.label?.display = true;
    cardViewStyle.input?.fontFamily = MFFontFamily.TimesNewRoman;
    cardViewStyle.label?.fontWeight = MFFontWeight.Light;
    return cardViewStyle;
  }

  // applePayPayment() async {
  //   MFExecutePaymentRequest executePaymentRequest =
  //       MFExecutePaymentRequest(invoiceValue: 10);
  //   executePaymentRequest.displayCurrencyIso = MFCurrencyISO.KUWAIT_KWD;

  //   await mfApplePayButton
  //       .applePayPayment(executePaymentRequest, MFLanguage.ENGLISH,
  //           (invoiceId) {
  //         log(invoiceId);
  //       })
  //       .then((value) => log(value))
  //       .catchError((error) => {log(error.message)});
  // }

  initiateSessionForCardView() async {
    /*
      If you want to use saved card option with embedded payment, send the parameter
      "customerIdentifier" with a unique value for each customer. This value cannot be used
      for more than one Customer.
     */
    // var request = MFInitiateSessionRequest("12332212");
    /*
      If not, then send null like this.
     */
    MFInitiateSessionRequest initiateSessionRequest =
    MFInitiateSessionRequest();

    await MFSDK
        .initSession(initiateSessionRequest, MFLanguage.ENGLISH)
        .then((value) => loadEmbeddedPayment(value))
        .catchError((error) => {log(error.message)});
  }

  loadCardView(MFInitiateSessionResponse session) {
    mfCardView.load(session, (bin) {
      log(bin);
    });
  }

  loadEmbeddedPayment(MFInitiateSessionResponse session) async {
    MFExecutePaymentRequest executePaymentRequest =
    MFExecutePaymentRequest(invoiceValue: 10);
    executePaymentRequest.displayCurrencyIso = MFCurrencyISO.UAE_AED;
    await loadCardView(session);
    if (Platform.isIOS) {
      applePayPayment(session);
      MFApplepay.setupApplePay(
          session, executePaymentRequest, MFLanguage.ENGLISH);
    }
  }

  openPaymentSheet() {
    if (Platform.isIOS) {
      MFApplepay.executeApplePayPayment()
          .then((value) => log(value))
          .catchError((error) => {log(error.message)});
    }
  }

  updateAmounnt() {
    if (Platform.isIOS) MFApplepay.updateAmount(double.parse(amount));
  }

  applePayPayment(MFInitiateSessionResponse session) async {
    MFExecutePaymentRequest executePaymentRequest =
    MFExecutePaymentRequest(invoiceValue: 10);
    executePaymentRequest.displayCurrencyIso = MFCurrencyISO.UAE_AED;

    await mfApplePayButton
        .displayApplePayButton(
        session, executePaymentRequest, MFLanguage.ENGLISH)
        .then((value) => {
      log(value),
      mfApplePayButton
          .executeApplePayButton(null, (invoiceId) => log(invoiceId))
          .then((value) => log(value))
          .catchError((error) => {log(error.message)})
    })
        .catchError((error) => {log(error.message)});
  }

  initiateSession() async {
    /*
      If you want to use saved card option with embedded payment, send the parameter
      "customerIdentifier" with a unique value for each customer. This value cannot be used
      for more than one Customer.
     */
    // var request = MFInitiateSessionRequest("12332212");
    /*
      If not, then send null like this.
     */
    MFInitiateSessionRequest initiateSessionRequest =
    MFInitiateSessionRequest();
    await MFSDK
        .initiateSession(initiateSessionRequest, (bin) {
      log(bin);
    })
        .then((value) => {log(value)})
        .catchError((error) => {log(error.message)});
  }

  pay() async {
    var executePaymentRequest = MFExecutePaymentRequest(invoiceValue: 10);

    await mfCardView
        .pay(executePaymentRequest, MFLanguage.ENGLISH, (invoiceId) {
      debugPrint("-----------$invoiceId------------");
      log(invoiceId);
    })
        .then((value) => log(value))
        .catchError((error) => {log(error.message)});
  }

  validate() async {
    await mfCardView
        .validate()
        .then((value) => log(value))
        .catchError((error) => {log(error.message)});
  }

  // GooglePay Section
  initiateSessionForGooglePay() async {
    MFInitiateSessionRequest initiateSessionRequest = MFInitiateSessionRequest(
      // A uniquue value for each customer must be added
        customerIdentifier: "12332212");

    await MFSDK
        .initSession(initiateSessionRequest, MFLanguage.ENGLISH)
        .then((value) => {setupGooglePayHelper(value.sessionId)})
        .catchError((error) => {log(error.message)});
  }

  setupGooglePayHelper(String sessionId) async {
    MFGooglePayRequest googlePayRequest = MFGooglePayRequest(
        totalPrice: amount,
        merchantId: "No googleMerchantId",
        merchantName: "Test Vendor",
        countryCode: MFCountry.UAE,
        currencyIso: MFCurrencyISO.UAE_AED);

    await mfGooglePayButton
        .setupGooglePayHelper(sessionId, googlePayRequest, (invoiceId) {
      log("-----------Invoice Id: $invoiceId------------");
    })
        .then((value) => log(value))
        .catchError((error) => {log(error.message)});
  }

//#region aaa

//endregion

  // UI Section
  @override
  Widget build(BuildContext context) {
    mfCardView = MFCardPaymentView(cardViewStyle: cardViewStyle());
    mfApplePayButton = MFApplePayButton(applePayStyle: MFApplePayStyle());
    mfGooglePayButton = MFGooglePayButton();

    return MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          toolbarHeight: 1,
          //   title: const Text('Plugin example app'),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: Flex(
              direction: Axis.vertical,
              children: [
                Text("Payment Amount", style: textStyle()),
                amountInput(),
                // if (Platform.isAndroid) googlePayButton(),
                // btn("Reload GooglePay", initiateSessionForGooglePay),
                // embeddedCardView(),
                // if (Platform.isIOS) applePayView(),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          paymentMethodsList(),
                          visibilityObs
                              ? directPaymentCardDetails()
                              : const Column(),
                          if (selectedPaymentMethodIndex != -1)
                            btn("Pay", executePayment),
                          // btn("Send Payment", sendPayment),
                          // btn("Get Payment Status", getPaymentStatus),
                          // if (Platform.isIOS)
                          //   btn("Update Amount", updateAmounnt),
                          // if (Platform.isIOS)
                          //   btn("Reload Apple Pay", applePayPayment),
                          // if (Platform.isIOS)
                          //   btn("New Apple Pay", openPaymentSheet),
                          // ColoredBox(
                          //   color: const Color(0xFFD8E5EB),
                          //   child: SelectableText.rich(
                          //     TextSpan(
                          //       text: _response!,
                          //       style: const TextStyle(),
                          //     ),
                          //   ),
                          // ),
                        ]),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget embeddedCardView() {
    return Column(
      children: [
        SizedBox(
          height: 180,
          child: mfCardView,
        ),
        Row(
          children: [
            Expanded(child: elevatedButton("Validate", validate)),
            const SizedBox(width: 2),
            Expanded(child: elevatedButton("Pay", pay)),
            const SizedBox(width: 2),
            elevatedButton("", initiateSessionForCardView),
          ],
        )
      ],
    );
  }

  Widget applePayView() {
    return Column(
      children: [
        SizedBox(
          height: 50,
          child: mfApplePayButton,
        )
      ],
    );
  }

  Widget googlePayButton() {
    return SizedBox(
      height: 70,
      child: mfGooglePayButton,
    );
  }

  Widget directPaymentCardDetails() {
    return Column(
      children: <Widget>[
        const Padding(
          padding: EdgeInsets.all(2.5),
        ),
        TextField(
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(labelText: "Card Number"),
          controller: TextEditingController(text: cardNumber),
          onChanged: (value) {
            cardNumber = value;
          },
        ),
        TextField(
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(labelText: "Expiry Month"),
          controller: TextEditingController(text: expiryMonth),
          onChanged: (value) {
            expiryMonth = value;
          },
        ),
        TextField(
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(labelText: "Expiry Year"),
          controller: TextEditingController(text: expiryYear),
          onChanged: (value) {
            expiryYear = value;
          },
        ),
        TextField(
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(labelText: "Security Code"),
          controller: TextEditingController(text: securityCode),
          onChanged: (value) {
            securityCode = value;
          },
        ),
        TextField(
          keyboardType: TextInputType.name,
          decoration: const InputDecoration(labelText: "Card Holder Name"),
          controller: TextEditingController(text: cardHolderName),
          onChanged: (value) {
            cardHolderName = value;
          },
        ),
      ],
    );
  }

  Widget paymentMethodsList() {
    return Column(
      children: [
        Text("Select payment method", style: textStyle()),
        SizedBox(
          height: 85,
          child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: paymentMethods.length,
              itemBuilder: (BuildContext ctxt, int index) {
                return paymentMethodsItem(ctxt, index);
              }),
        ),
      ],
    );
  }

  Widget paymentMethodsItem(BuildContext ctxt, int index) {
    return SizedBox(
      width: 70,
      height: 75,
      child: Container(
        decoration: isSelected[index]
            ? BoxDecoration(
            border: Border.all(color: Colors.blueAccent, width: 2))
            : const BoxDecoration(),
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Column(
            children: <Widget>[
              Image.network(
                paymentMethods[index].imageUrl!,
                height: 35.0,
              ),
              SizedBox(
                height: 24.0,
                width: 24.0,
                child: Checkbox(
                    checkColor: Colors.blueAccent,
                    activeColor: const Color(0xFFC9C5C5),
                    value: isSelected[index],
                    onChanged: (bool? value) {
                      setState(() {
                        setPaymentMethodSelected(index, value!);
                      });
                    }),
              ),
              Text(
                paymentMethods[index].paymentMethodEn ?? "",
                style: TextStyle(
                  fontSize: 8.0,
                  fontWeight:
                  isSelected[index] ? FontWeight.bold : FontWeight.normal,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget btn(String title, Function onPressed) {
    return SizedBox(
      width: double.infinity, // <-- match_parent
      child: elevatedButton(title, onPressed),
    );
  }

  Widget elevatedButton(String title, Function onPressed) {
    return ElevatedButton(
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
        backgroundColor:
        MaterialStateProperty.all<Color>(App.orange),
        shape: MaterialStateProperty.resolveWith<RoundedRectangleBorder>(
              (Set<MaterialState> states) {
            if (states.contains(MaterialState.pressed)) {
              return RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
                side: const BorderSide(color: Colors.red, width: 1.0),
              );
            } else {
              return RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
                side: const BorderSide(color: Colors.white, width: 1.0),
              );
            }
          },
        ),
      ),
      child: (title.isNotEmpty)
          ? Text(title, style: textStyle())
          : const Icon(Icons.refresh),
      onPressed: () async {
        await onPressed();
      },
    );
  }

  Widget amountInput() {
    return Text(amount+" AED");
  }

  TextStyle textStyle() {
    return const TextStyle(fontSize: 16.0, fontStyle: FontStyle.italic);
  }



}

//
//
//
// String _response = '';
// String _loading = "Loading...";
//
// List<PaymentMethods> paymentMethods = [];
// List<bool> isSelected = [];
// int selectedPaymentMethodIndex = -1;
//
// String amount = "0.100";
// String cardNumber = "5453010000095489";
// String expiryMonth = "5";
// String expiryYear = "21";
// String securityCode = "100";
// String cardHolderName = "Mahmoud Ibrahim";
// bool visibilityObs = false;
// MFPaymentCardView? mfPaymentCardView;
//
// @override
// void initState() {
//   super.initState();
//
//   if (mAPIKey.isEmpty) {
//     setState(() {
//       _response =
//       "Missing API Token Key.. You can get it from here: https://myfatoorah.readme.io/docs/test-token";
//     });
//     return;
//   }
//
//   // TODO, don't forget to init the MyFatoorah Plugin with the following line
//   MFSDK.init(mAPIKey, MFCountry.UNITED_ARAB_EMIRATES, MFEnvironment.LIVE);
//   // (Optional) un comment the following lines if you want to set up properties of AppBar.
//
// //    MFSDK.setUpAppBar(
// //      title: "MyFatoorah Payment",
// //      titleColor: Colors.white,  // Color(0xFFFFFFFF)
// //      backgroundColor: Colors.black, // Color(0xFF000000)
// //      isShowAppBar: true); // For Android platform only
//
//   // (Optional) un comment this line, if you want to hide the AppBar.
//   // Note, if the platform is iOS, this line will not affected
//
// //    MFSDK.setUpAppBar(isShowAppBar: false);
//
//   initiatePayment();
//   initiateSession();
// }
//
// /*
//     Send Payment
//
//    */
// void sendPayment() {
//   var request = MFSendPaymentRequest(
//       invoiceValue: double.parse(amount),
//       // customerName: "Customer name",
//
//       customerName: Global.customer!.firstname + " " + Global.customer!.lastname,
//       customerMobile: "-",
//       customerEmail: Global.customer!.email,
//       notificationOption: MFNotificationOption.LINK);
//
//   /*var invoiceItem =
//         new InvoiceItem(itemName: "item1", quantity: 1, unitPrice: 0.100);
//     var listItems = new List<InvoiceItem>();
//     listItems.add(invoiceItem);
//     request.invoiceItems = listItems;*/
//
//   MFSDK.sendPayment(
//       context,
//       MFAPILanguage.EN,
//       request,
//           (MFResult<MFSendPaymentResponse> result) => {
//         if (result.isSuccess())
//           {
//             setState(() {
//               print(result.response!.toJson());
//               _response = result.response!.toJson().toString();
//             })
//           }
//         else
//           {
//             setState(() {
//               print(result.error!.toJson());
//               _response = result.error!.message!;
//             })
//           }
//       });
//
//   setState(() {
//     _response = _loading;
//   });
// }
//
// /*
//     Initiate Payment
//    */
// void initiatePayment() {
//   var request = new MFInitiatePaymentRequest(
//       double.parse(amount), MFCurrencyISO.KUWAIT_KWD);
//
//   MFSDK.initiatePayment(
//       request,
//       MFAPILanguage.EN,
//           (MFResult<MFInitiatePaymentResponse> result) => {
//         if (result.isSuccess())
//           {
//             setState(() {
//               print(result.response!.toJson());
//               _response = ""; //result.response.toJson().toString();
//               paymentMethods.addAll(result.response!.paymentMethods!);
//               for (int i = 0; i < paymentMethods.length; i++)
//                 isSelected.add(false);
//             })
//           }
//         else
//           {
//             setState(() {
//               print(result.error!.toJson());
//               _response = result.error!.message!;
//             })
//           }
//       });
//
//   setState(() {
//     _response = _loading;
//   });
// }
//
// /*
//     Execute Regular Payment
//    */
// void executeRegularPayment(int paymentMethodId) {
//   var request =
//   new MFExecutePaymentRequest(paymentMethodId, double.parse(amount));
//
//   // For recurring
//   // request?.recurringModel = RecurringModel(MFRecurringType.monthly, iteration: 5);
//
//   MFSDK.executePayment(
//       context,
//       request,
//       MFAPILanguage.EN,
//
//       onPaymentResponse:  (String invoiceId, MFResult<MFPaymentStatusResponse> result) => {
//         if (result.isSuccess())
//           {
//             //todo sucss msg
//             setState(() {
//               checkoutController.my_order.addAll(cartController.my_order);
//               checkoutController.is_paid.value=true;
//               checkoutController.add_order_payment(context);
//               checkoutController.selected_operation++;
//               print(invoiceId);
//               print(result.response!.toJson());
//               _response = result.response!.toJson().toString();
//             })
//
//           }
//         else
//           {
//             setState(() {
//               checkoutController.selected.value=false;
//               print(invoiceId);
//               print(result.error!.toJson());
//               _response = result.error!.message!;
//             })
//           }
//       });
//
//   setState(() {
//     _response = _loading;
//   });
// }
//
// /*
//     Execute Direct Payment
//    */
// void executeDirectPayment(int paymentMethodId) {
//   var request =
//   new MFExecutePaymentRequest(paymentMethodId, double.parse(amount));
//
// //    var mfCardInfo = new MFCardInfo(cardToken: "Put your token here");
//
//   var mfCardInfo = new MFCardInfo(
//       cardNumber: cardNumber,
//       expiryMonth: expiryMonth,
//       expiryYear: expiryYear,
//       securityCode: securityCode,
//       cardHolderName: cardHolderName,
//       bypass3DS: false,
//       saveToken: false);
//
//   MFSDK.executeDirectPayment(
//       context,
//       request,
//       mfCardInfo,
//       MFAPILanguage.EN,
//           (String invoiceId, MFResult<MFDirectPaymentResponse> result) => {
//         if (result.isSuccess())
//           {
//             setState(() {
//               print(invoiceId);
//               print(result.response!.toJson());
//               _response = result.response!.toJson().toString();
//             })
//           }
//         else
//           {
//             setState(() {
//               print(invoiceId);
//               print(result.error!.toJson());
//               _response = result.error!.message!;
//             })
//           }
//       });
//
//   setState(() {
//     _response = _loading;
//   });
// }
//
// /*
//     Execute Direct Payment with Recurring
//    */
// void executeDirectPaymentWithRecurring() {
//   // The value 20 is the paymentMethodId of Visa/Master payment method.
//   // You should call the "initiatePayment" API to can get this id and the ids of all other payment methods
//   int paymentMethod = 20;
//
//   var request =
//   new MFExecutePaymentRequest(paymentMethod, double.parse(amount));
//
//   var mfCardInfo = new MFCardInfo(
//       cardNumber: cardNumber,
//       expiryMonth: expiryMonth,
//       expiryYear: expiryYear,
//       securityCode: securityCode,
//       bypass3DS: true,
//       saveToken: true);
//
//   MFSDK.executeRecurringDirectPayment(
//       context,
//       request,
//       mfCardInfo,
//       MFRecurringType.monthly,
//       MFAPILanguage.EN,
//           (String invoiceId, MFResult<MFDirectPaymentResponse> result) => {
//         if (result.isSuccess())
//           {
//             setState(() {
//               print(invoiceId);
//               print(result.response!.toJson());
//               _response = result.response!.toJson().toString();
//             })
//           }
//         else
//           {
//             setState(() {
//               print(invoiceId);
//               print(result.error!.toJson());
//               _response = result.error!.message!;
//             })
//           }
//       });
//
//   setState(() {
//     _response = _loading;
//   });
// }
//
// /*
//     Payment Enquiry
//    */
// void getPaymentStatus() {
//   var request = MFPaymentStatusRequest(invoiceId: "12345");
//
//   MFSDK.getPaymentStatus(
//       MFAPILanguage.EN,
//       request,
//           (MFResult<MFPaymentStatusResponse> result) => {
//         if (result.isSuccess())
//           {
//             setState(() {
//               print(result.response!.toJson());
//               _response = result.response!.toJson().toString();
//             })
//           }
//         else
//           {
//             setState(() {
//               print(result.error!.toJson());
//               _response = result.error!.message!;
//             })
//           }
//       });
//
//   setState(() {
//     _response = _loading;
//   });
// }
//
// /*
//     Cancel Token
//    */
// void cancelToken() {
//   MFSDK.cancelToken(
//       "Put your token here",
//       MFAPILanguage.EN,
//           (MFResult<bool> result) => {
//         if (result.isSuccess())
//           {
//             setState(() {
//               print(result.response.toString());
//               _response = result.response.toString();
//             })
//           }
//         else
//           {
//             setState(() {
//               print(result.error!.toJson());
//               _response = result.error!.message!;
//             })
//           }
//       });
//
//   setState(() {
//     _response = _loading;
//   });
// }
//
// /*
//     Cancel Recurring Payment
//    */
// void cancelRecurringPayment() {
//   MFSDK.cancelRecurringPayment(
//       "Put RecurringId here",
//       MFAPILanguage.EN,
//           (MFResult<bool> result) => {
//         if (result.isSuccess())
//           {
//             setState(() {
//               print(result.response.toString());
//               _response = result.response.toString();
//             })
//           }
//         else
//           {
//             setState(() {
//               print(result.error!.toJson());
//               _response = result.error!.message!;
//             })
//           }
//       });
//
//   setState(() {
//     _response = _loading;
//   });
// }
//
// void setPaymentMethodSelected(int index, bool value) {
//   for (int i = 0; i < isSelected.length; i++) {
//     if (i == index) {
//       isSelected[i] = value;
//       if (value) {
//         selectedPaymentMethodIndex = index;
//         visibilityObs = paymentMethods[index].isDirectPayment!;
//       } else {
//         selectedPaymentMethodIndex = -1;
//         visibilityObs = false;
//       }
//     } else
//       isSelected[i] = false;
//   }
// }
//
// void pay() {
//   if (selectedPaymentMethodIndex == -1) {
//     Fluttertoast.showToast(
//         msg: "Please select payment method first",
//         toastLength: Toast.LENGTH_SHORT,
//         gravity: ToastGravity.CENTER,
//         timeInSecForIosWeb: 1,
//         backgroundColor: Colors.red,
//         textColor: Colors.white,
//         fontSize: 16.0
//     );
//
//   } else {
//     if (amount.isEmpty) {
//       Fluttertoast.showToast(
//           msg: "Set the amount",
//           toastLength: Toast.LENGTH_SHORT,
//           gravity: ToastGravity.CENTER,
//           timeInSecForIosWeb: 1,
//           backgroundColor: Colors.red,
//           textColor: Colors.white,
//           fontSize: 16.0
//       );
//
//     } else if (paymentMethods[selectedPaymentMethodIndex].isDirectPayment!) {
//       if (cardNumber.isEmpty ||
//           expiryMonth.isEmpty ||
//           expiryYear.isEmpty ||
//           securityCode.isEmpty)
//         Fluttertoast.showToast(
//             msg: "Fill all the card fields",
//             toastLength: Toast.LENGTH_SHORT,
//             gravity: ToastGravity.CENTER,
//             timeInSecForIosWeb: 1,
//             backgroundColor: Colors.red,
//             textColor: Colors.white,
//             fontSize: 16.0
//         );
//
//       else
//         executeDirectPayment(
//             paymentMethods[selectedPaymentMethodIndex].paymentMethodId!);
//     } else
//       executeRegularPayment(
//           paymentMethods[selectedPaymentMethodIndex].paymentMethodId!);
//   }
// }
//
// fun(){
//       (MFResult<MFInitiateSessionResponse> result) => {
//     if (result.isSuccess())
//       {mfPaymentCardView!.load(result.response!)}
//     else
//       {
//         setState(() {
//           print(
//               "Response: " + result.error!.toJson().toString().toString());
//           _response = result.error!.message!;
//         })
//       }
//   };
// }
// void initiateSession() {
//   MFSDK.initiateSession(null,(MFResult<MFInitiateSessionResponse> result) => {
//     if (result.isSuccess())
//       {mfPaymentCardView!.load(result.response!)}
//     else
//       {
//         setState(() {
//           print(
//               "Response: " + result.error!.toJson().toString().toString());
//           _response = result.error!.message!;
//         })
//       }
//   });
// }
//
// void payWithEmbeddedPayment() {
//   var request = MFExecutePaymentRequest.constructor(0.100);
//   mfPaymentCardView!.pay(
//       request,
//       MFAPILanguage.EN,
//           (String invoiceId, MFResult<MFPaymentStatusResponse> result) => {
//         if (result.isSuccess())
//           {
//             setState(() {
//               print("invoiceId: " + invoiceId);
//               print("Response: " + result.response!.toJson().toString());
//               _response = result.response!.toJson().toString();
//             })
//           }
//         else
//           {
//             setState(() {
//               print("invoiceId: " + invoiceId);
//               print("Error: " + result.error!.toJson().toString());
//               _response = result.error!.message!;
//             })
//           }
//       });
//
//   setState(() {
//     _response = _loading;
//   });
// }
//
// @override
// Widget build(BuildContext context) {
//   return SafeArea(
//     child: Container(
//       height: MediaQuery.of(context).size.height*0.7-MediaQuery.of(context).padding.top,
//       width: MediaQuery.of(context).size.width,
//       margin: EdgeInsets.all(10.0),
//       child: SingleChildScrollView(
//         child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               // TextField(
//               //   keyboardType: TextInputType.number,
//               //   controller: TextEditingController(text: amount),
//               //   decoration: InputDecoration(labelText: "Payment Amount"),
//               //   onChanged: (value) {
//               //     amount = value;
//               //   },
//               // ),
//               Text(amount.toString()),
//               Padding(
//                 padding: EdgeInsets.all(5.0),
//               ),
//               Text("Select payment method"),
//               Padding(
//                 padding: EdgeInsets.all(5.0),
//               ),
//               SizedBox(
//                 height: 200,
//                 child: GridView.builder(
//                     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                         crossAxisCount: 3,
//                         crossAxisSpacing: 0.0,
//                         mainAxisSpacing: 0.0),
//                     itemCount: paymentMethods.length,
//                     itemBuilder: (BuildContext ctxt, int index) {
//                       print(paymentMethods.length);
//                       return Column(
//                         children: <Widget>[
//                           Image.network(paymentMethods[index].imageUrl!,
//                               width: 40.0, height: 40.0),
//                           Checkbox(
//                               value: isSelected[index],
//                               onChanged: (value) {
//                                 setState(() {
//                                   setPaymentMethodSelected(index, value!);
//                                 });
//                               })
//                         ],
//                       );
//                     }),
//               ),
//               visibilityObs
//                   ? Column(
//                 children: <Widget>[
//                   Padding(
//                     padding: EdgeInsets.all(5.0),
//                   ),
//                   TextField(
//                     keyboardType: TextInputType.number,
//                     decoration:
//                     InputDecoration(labelText: "Card Number"),
//                     controller:
//                     TextEditingController(text: cardNumber),
//                     onChanged: (value) {
//                       cardNumber = value;
//                     },
//                   ),
//                   TextField(
//                     keyboardType: TextInputType.number,
//                     decoration:
//                     InputDecoration(labelText: "Expiry Month"),
//                     controller:
//                     TextEditingController(text: expiryMonth),
//                     onChanged: (value) {
//                       expiryMonth = value;
//                     },
//                   ),
//                   TextField(
//                     keyboardType: TextInputType.number,
//                     decoration:
//                     InputDecoration(labelText: "Expiry Year"),
//                     controller:
//                     TextEditingController(text: expiryYear),
//                     onChanged: (value) {
//                       expiryYear = value;
//                     },
//                   ),
//                   TextField(
//                     keyboardType: TextInputType.number,
//                     decoration:
//                     InputDecoration(labelText: "Security Code"),
//                     controller:
//                     TextEditingController(text: securityCode),
//                     onChanged: (value) {
//                       securityCode = value;
//                     },
//                   ),
//                   TextField(
//                     keyboardType: TextInputType.name,
//                     decoration: InputDecoration(
//                         labelText: "Card Holder Name"),
//                     controller:
//                     TextEditingController(text: cardHolderName),
//                     onChanged: (value) {
//                       cardHolderName = value;
//                     },
//                   ),
//                 ],
//               )
//                   : Column(),
//               Padding(
//                 padding: EdgeInsets.all(5.0),
//               ),
//               // TextButton(
//               //   style: ,
//               //   child:
//               //   onPressed: ,
//               // ),
//               Center(
//                 child: GestureDetector(
//                   onTap: pay,
//                   child: Container(
//                     width: 150,
//                     height: 30,
//                     decoration: BoxDecoration(
//                         color: App.midOrange,
//                         borderRadius: BorderRadius.circular(15)
//                     ),
//                     child: Center(
//                       child: Text('Pay',style: TextStyle(color:  Colors.white,fontWeight: FontWeight.bold),),
//                     ),
//                   ),
//                 ),
//               )
//               // RaisedButton(
//               //   color: Colors.lightBlue,
//               //   textColor: Colors.white,
//               //   child: Text('Send Payment'),
//               //   onPressed: sendPayment,
//               // ),
//               // Padding(
//               //   padding: EdgeInsets.all(8.0),
//               // ),
//               // createPaymentCardView(),
//               // RaisedButton(
//               //   color: Colors.lightBlue,
//               //   textColor: Colors.white,
//               //   child: Text('Pay (Embedded Payment)'),
//               //   onPressed: payWithEmbeddedPayment,
//               // ),
//               // Text(_response),
//             ]),
//       ),
//     ),
//   );
// }
//
// createPaymentCardView() {
//   mfPaymentCardView = MFPaymentCardView(
//     inputColor: Colors.red,
//     labelColor: Colors.yellow,
//     errorColor: Colors.blue,
//     borderColor: Colors.green,
//     fontSize: 14,
//     borderWidth: 1,
//     borderRadius: 10,
//     cardHeight: 220,
//     cardHolderNameHint: "card holder name hint",
//     cardNumberHint: "card number hint",
//     expiryDateHint: "expiry date hint",
//     cvvHint: "cvv hint",
//     showLabels: true,
//     cardHolderNameLabel: "card holder name label",
//     cardNumberLabel: "card number label",
//     expiryDateLabel: "expiry date label",
//     cvvLabel: "cvv label",
//   );
//
//   return mfPaymentCardView;
// }
