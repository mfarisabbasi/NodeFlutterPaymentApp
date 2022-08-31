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

// @desc Save a contact for later use
// @route PATCH /api/users/save-contact
// @access Private
const saveContact = asyncHandler(async (req, res) => {
  try {
    const { contactToSave, name } = req.body;

    const contactToSaveExists = await User.find({ payID: contactToSave });

    if (!contactToSave || !contactToSaveExists)
      return res.status(400).json({ msg: "Error Contact Not Found" });

    if (!name) return res.status(400).json({ msg: "Name is required" });

    const currentUser = await User.findById(req.user);

    let getCurrentUserSavedContacts = currentUser.saved;

    if (getCurrentUserSavedContacts) {
      for (let a = 0; a < getCurrentUserSavedContacts.length; a++) {
        if (getCurrentUserSavedContacts[a].savedPayId === contactToSave) {
          return res.status(400).json({ msg: "Contact Already Saved" });
        }
      }

      currentUser.saved.push({
        savedName: name,
        savedPayId: contactToSave,
      });
      await currentUser.save();
    }

    return res.status(200).json(currentUser);
  } catch (error) {
    return res.status(500).json({ error: error.message });
  }
});

// @desc Get Logged In User Saved Contacts
// @route GET /api/users/saved-contacts
// @access Private
const getCurrentUserSavedContacts = asyncHandler(async (req, res) => {
  const user = await User.findById(req.user);
  res.json(user.saved);
});

// @desc Remove Contact From User Saved Contacts
// @route PUT /api/users/saved-contacts/:id
// @access Private
const deleteUserSavedContact = asyncHandler(async (req, res) => {
  const currentUser = await User.findById(req.user);

  if (currentUser.saved) {
    for (let a = 0; a < currentUser.saved.length; a++) {
      if (currentUser.saved[a]._id == req.params.id) {
        let removedItem = currentUser.saved.splice(a, 1);
        if (removedItem) {
          await currentUser.save();
        }
      } else {
        return res.status(200).json({ msg: "Contact Not Found" });
      }
    }
  }
  return res.status(200).json({ msg: "Contact Removed" });
});

export {
  createUser,
  loginUser,
  getUserData,
  isTokenValid,
  searchUsersByPayID,
  saveContact,
  getCurrentUserSavedContacts,
  deleteUserSavedContact,
};
