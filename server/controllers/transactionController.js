import asyncHandler from "express-async-handler";
import User from "../models/userModel.js";
import Transaction from "../models/transactionModel.js";
import OrderID from "ordersid-generator";

// @desc Send Money To Other User
// @route POST /api/transaction/newTransaction
// @access Private
const createTransaction = asyncHandler(async (req, res) => {
  try {
    const { sender, receiver, amount } = req.body;

    const sendBy = await User.findOne({ payID: sender });

    const receivedBy = await User.findOne({ payID: receiver });

    if (!sendBy) {
      return res.status(400).json({ msg: "Sender Not Found" });
    }

    if (!receivedBy) {
      return res.status(400).json({ msg: "Receiver Not Found" });
    }

    var uniqueId = OrderID("long");

    const transaction = await new Transaction({
      transactionID: uniqueId,
      sender: sendBy.payID,
      senderName: sendBy.name,
      receiver: receivedBy.payID,
      receiverName: receivedBy.name,
      amount,
      dateAndTime: new Date().toLocaleString(),
    });

    const newTransaction = await transaction.save();

    if (newTransaction && sendBy) {
      await sendBy.updateOne({ $inc: { user_balance: -amount } });
      await sendBy.save();
    }

    if (newTransaction && receivedBy) {
      await receivedBy.updateOne({ $inc: { user_balance: +amount } });
      await receivedBy.save();
    }

    res.status(201).json(newTransaction);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// @desc Account Summary
// @route GET /api/transaction/summary
// @access Public
const accountSummary = asyncHandler(async (req, res) => {
  try {
    const loggedInUser = await User.findById(req.user);

    const myTransactions = await Transaction.find({
      $or: [{ sender: loggedInUser.payID }, { receiver: loggedInUser.payID }],
    }).sort({ dateAndTime: -1 });

    if (!myTransactions)
      return res.status(200).json({ msg: "No Transactions" });

    res.status(201).json(myTransactions);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

export { createTransaction, accountSummary };
