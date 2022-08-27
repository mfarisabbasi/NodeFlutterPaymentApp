import mongoose from "mongoose";

const transactionSchema = mongoose.Schema({
  transactionID: {
    type: String,
    required: true,
  },
  sender: {
    type: String,
    required: true,
  },
  senderName: {
    type: String,
    required: true,
  },
  receiver: {
    type: String,
    required: true,
  },
  receiverName: {
    type: String,
    required: true,
  },
  amount: {
    type: Number,
    required: true,
  },
  dateAndTime: {
    type: String,
    required: true,
  },
});

const Transaction = mongoose.model("Transaction", transactionSchema);

export default Transaction;
