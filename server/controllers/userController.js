import asyncHandler from "express-async-handler";
import User from "../models/userModel.js";
import bcryptjs from "bcryptjs";
import jwt from "jsonwebtoken";
import OrderID from "ordersid-generator";

// @desc Create a new user account
// @route POST /api/users/create-account
// @access Public
const createUser = asyncHandler(async (req, res) => {
  try {
    const { name, email, password } = req.body;

    const userExists = await User.findOne({ email });

    if (userExists) {
      return res.status(400).json({ msg: "User already exists" });
    }

    var uniqueId = OrderID("short", "PAYREAL");

    const user = await User.create({
      name,
      email,
      password,
      payID: uniqueId,
    });

    if (user) {
      res.status(201).json({
        _id: user.id,
        name: user.name,
        email: user.email,
        isAdmin: user.isAdmin,
        type: user.type,
        payID: user.payID,
      });
    }
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// @desc Search Users By PayID
// @route GET /api/users/:payid
// Access Private
const searchUsersByPayID = asyncHandler(async (req, res) => {
  try {
    const user = await User.findOne({
      payID: { $regex: req.params.payid },
    }).select("-password");

    res.json(user);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

// @desc Log in a user
// @route POST /api/users/login
// @access Public
const loginUser = asyncHandler(async (req, res) => {
  try {
    const { email, password } = req.body;

    const user = await User.findOne({ email });
    if (!user) {
      return res
        .status(400)
        .json({ msg: "User with this email does not exist!" });
    }

    const isMatch = await bcryptjs.compare(password, user.password);
    if (!isMatch) {
      return res.status(400).json({ msg: "Incorrect password." });
    }

    const token = jwt.sign({ id: user._id }, process.env.JWT_SECRET);
    res.json({ token, ...user._doc });
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

// @desc Get User Data
// @route GET /api/users/user
// @access Private
const getUserData = asyncHandler(async (req, res) => {
  const user = await User.findById(req.user);
  res.json({ ...user._doc, token: req.token });
});

// @desc Check If The User Token Is Valid
// @route POST /api/users/is-token-valid
// @access Public
const isTokenValid = asyncHandler(async (req, res) => {
  try {
    const token = req.header("ax-auth-token");

    if (!token) return res.json(false);

    const verified = jwt.verify(token, process.env.JWT_SECRET);

    if (!verified) return res.json(false);
    console.log("Token Verification Successful, Now Getting User Data");
    res.json(true);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

export { createUser, loginUser, getUserData, isTokenValid, searchUsersByPayID };
