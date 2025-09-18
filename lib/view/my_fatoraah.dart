import 'dart:convert';
import 'dart:io';

import 'package:albassel_version_1/const/app.dart';
import 'package:albassel_version_1/const/global.dart';
import 'package:albassel_version_1/controler/cart_controller.dart';
import 'package:albassel_version_1/controler/checkout_controller.dart';
import 'package:albassel_version_1/helper/api_v2.dart';
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
    // TODO, don't forget to init the MyFatoorah Plugin with the following line
    await MFSDK.init(mAPIKey, MFCountry.UAE, MFEnvironment.LIVE);

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await initiateSessionForCardView();
      // await initiateSessionForGooglePay();
      await initiatePayment();
      // await initiateSession();
    });
  }
  void showObjectDialog(dynamic obj) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Object Data"),
        content: SingleChildScrollView(
          child: Text(const JsonEncoder.withIndent("  ").convert(obj)),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("OK"),
          ),
        ],
      ),
    );
  }
  log(Object object) {
    print('**** HERE ****');
    print(object);
    showObjectDialog(object);
    // ApiV2.log(object);
    if(object is MFGetPaymentStatusResponse){
      print('*****');
      print(object.invoiceStatus!);
      if(object.invoiceStatus != null && object.invoiceStatus == 'Paid'){
        //todo successfully payment
        // checkoutController.my_order.addAll(cartController.cart!.cartList);
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
      showObjectDialog(_response);
    });
  }

  // // Send Payment
  // sendPayment() async {
  //   var request = MFSendPaymentRequest(
  //       invoiceValue: double.parse(amount),
  //       customerName: "Customer name",
  //       notificationOption: MFNotificationOption.LINK);
  //   // var invoiceItem = MFInvoiceItem(itemName: "item1", quantity: 1, unitPrice: 1);
  //   // request.invoiceItems = [invoiceItem];
  //
  //   await MFSDK
  //       .sendPayment(request, MFLanguage.ENGLISH)
  //       .then((value) => log(value))
  //       .catchError((error) => {log(error)});
  // }

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
        // .catchError((error) => {log(error.message)});
        .catchError((error) => {log(error)});
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
    MFInitiateSessionRequest initiateSessionRequest =
    MFInitiateSessionRequest();

    await MFSDK
        .initSession(initiateSessionRequest, MFLanguage.ENGLISH)
        .then((value) => loadEmbeddedPayment(value))
        .catchError((error) => {log(error)});
        // .catchError((error) => {log(error.message)});
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
  // initiateSessionForGooglePay() async {
  //   MFInitiateSessionRequest initiateSessionRequest = MFInitiateSessionRequest(
  //     // A uniquue value for each customer must be added
  //       customerIdentifier: "12332212");
  //
  //   await MFSDK
  //       .initSession(initiateSessionRequest, MFLanguage.ENGLISH)
  //       .then((value) => {setupGooglePayHelper(value.sessionId)})
  //       .catchError((error) => {log(error.message)});
  // }

  // setupGooglePayHelper(String sessionId) async {
  //   MFGooglePayRequest googlePayRequest = MFGooglePayRequest(
  //       totalPrice: amount,
  //       merchantId: "No googleMerchantId",
  //       merchantName: "Test Vendor",
  //       countryCode: MFCountry.UAE,
  //       currencyIso: MFCurrencyISO.UAE_AED);
  //
  //   await mfGooglePayButton
  //       .setupGooglePayHelper(sessionId, googlePayRequest, (invoiceId) {
  //     log("-----------Invoice Id: $invoiceId------------");
  //   })
  //       .then((value) => log(value))
  //       .catchError((error) => {log(error.message)});
  // }

//#region aaa

//endregion

  // UI Section
  @override
  Widget build(BuildContext context) {
    mfCardView = MFCardPaymentView(cardViewStyle: cardViewStyle());
    mfApplePayButton = MFApplePayButton(applePayStyle: MFApplePayStyle());
    // mfGooglePayButton = MFGooglePayButton();

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

  // Widget googlePayButton() {
  //   return SizedBox(
  //     height: 70,
  //     child: mfGooglePayButton,
  //   );
  // }

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
