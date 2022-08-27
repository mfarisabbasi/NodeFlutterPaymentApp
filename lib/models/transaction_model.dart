// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Transaction {
  final String id;
  final String transactionID;
  final String sender;
  final String senderName;
  final String receiver;
  final String receiverName;
  final double amount;
  final dynamic dateAndTime;

  Transaction({
    required this.id,
    required this.transactionID,
    required this.sender,
    required this.senderName,
    required this.receiver,
    required this.receiverName,
    required this.amount,
    this.dateAndTime,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'transactionID': transactionID,
      'sender': sender,
      'senderName': senderName,
      'receiver': receiver,
      'receiverName': receiverName,
      'amount': amount,
      'dateAndTime': dateAndTime,
    };
  }

  factory Transaction.fromMap(Map<String, dynamic> map) {
    return Transaction(
      id: map['_id'] ?? '',
      transactionID: map['transactionID'] ?? '',
      sender: map['sender'] ?? '',
      senderName: map['senderName'] ?? '',
      receiver: map['receiver'] ?? '',
      receiverName: map['receiverName'] ?? '',
      amount: map['amount']?.toDouble() ?? 0.0,
      dateAndTime: map['dateAndTime'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Transaction.fromJson(String source) =>
      Transaction.fromMap(json.decode(source) as Map<String, dynamic>);
}
