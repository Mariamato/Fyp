import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:municipal_cms/controllers/payment_controller.dart';
import 'package:municipal_cms/models/payment_model.dart';
import 'package:municipal_cms/screens/payments/payment_widget.dart';

import '../lipia_hapa.dart';

class PaymentsListPage extends StatefulWidget {
  const PaymentsListPage({super.key});

  @override
  State<PaymentsListPage> createState() => _PaymentsListPageState();
}

class _PaymentsListPageState extends State<PaymentsListPage> {
  List<Payment> payments = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchPaymentData();
  }

  void fetchPaymentData() async {
    try {
      List<Payment> fetchedPayments = await fetchPayments();
      setState(() {
        payments = fetchedPayments;
        isLoading = false;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(
              CupertinoIcons.chevron_back,
              size: 27,
              color: Colors.white,
            ),
          ),
          elevation: 0,
          centerTitle: true,
          title: const Text("Payments List"),
        ),
        body: SafeArea(
          minimum: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  border: const Border(
                      bottom: BorderSide(color: Colors.blue, width: 1)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Total payments",
                      style: TextStyle(
                        color: Colors.black87,
                      ),
                    ),
                    Text(payments.length.toString()),
                  ],
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Expanded(
                child: isLoading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : ListView.builder(
                        itemCount: payments.length,
                        itemBuilder: (context, index) {
                          var payment = payments[index];

                          var amountString = payment.amount.toString();

                          return PaymentWidget(
                            paymentId: payment.id!,
                            refNo: payment.refNo!,
                            controlNo: payment.controlNo!,
                            amount: amountString,
                            method: payment.method!,
                          );
                        },
                      ),
              )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => LipaHapaPage()),
            ),
          },
          backgroundColor: Colors.blue,
          child: Icon(
            CupertinoIcons.add,
            color: Colors.white,
          ),
        ));
  }
}
