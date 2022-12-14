// ignore_for_file: use_build_context_synchronously

import 'package:banking_app/common/constants/global.dart';
import 'package:banking_app/common/constants/utils.dart';
import 'package:banking_app/common/widgets/bottom_nav.dart';
import 'package:banking_app/common/widgets/custom_button.dart';
import 'package:banking_app/common/widgets/row_data_display.dart';
import 'package:banking_app/models/transaction_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:ui' as ui;

import 'package:image_gallery_saver/image_gallery_saver.dart';

class TransactionSuccessfulScreen extends StatefulWidget {
  final Transaction transaction;
  static const String routeName = '/transaction-successful';
  const TransactionSuccessfulScreen({Key? key, required this.transaction})
      : super(key: key);

  @override
  State<TransactionSuccessfulScreen> createState() =>
      _TransactionSuccessfulScreenState();
}

class _TransactionSuccessfulScreenState
    extends State<TransactionSuccessfulScreen> {
  final GlobalKey _globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      key: _globalKey,
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const FaIcon(
                FontAwesomeIcons.check,
                size: 80,
                color: Colors.greenAccent,
              ),
              const Text(
                "Transaction successful",
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              RowDataDisplay(
                heading: "Transaction ID",
                value: widget.transaction.transactionID,
              ),
              RowDataDisplay(
                heading: "From",
                value: widget.transaction.sender,
              ),
              RowDataDisplay(
                heading: "To",
                value: widget.transaction.receiver,
              ),
              RowDataDisplay(
                heading: "Amount",
                value: "Rs ${widget.transaction.amount.toString()}",
              ),
              RowDataDisplay(
                heading: "Date",
                value: widget.transaction.dateAndTime,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 5,
                ),
                child: Container(
                  padding: const EdgeInsets.all(
                    10,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomButton(
                        text: "Save To Gallery",
                        onTap: () async {
                          RenderRepaintBoundary boundary =
                              _globalKey.currentContext!.findRenderObject()
                                  as RenderRepaintBoundary;
                          ui.Image image = await boundary.toImage();
                          ByteData? byteData = await (image.toByteData(
                              format: ui.ImageByteFormat.png));
                          if (byteData != null) {
                            await ImageGallerySaver.saveImage(
                                byteData.buffer.asUint8List());

                            showSnackBar(
                                context, "Transaction Saved To Gallery");
                            Navigator.of(context).pushNamedAndRemoveUntil(
                              BottomNav.routeName,
                              (_) => false,
                            );
                          }
                        },
                        width: 100,
                      ),
                      CustomButton(
                        text: "Continue",
                        onTap: () {
                          Navigator.of(context).pushNamedAndRemoveUntil(
                            BottomNav.routeName,
                            (_) => false,
                          );
                        },
                        width: 100,
                        color: GlobalVariables.secondaryColor,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
