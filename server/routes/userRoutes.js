import express from "express";

import {
  createUser,
  getUserData,
  getCurrentUserSavedContacts,
  isTokenValid,
  loginUser,
  saveContact,
  searchUsersByPayID,
  deleteUserSavedContact,
} from "../controllers/userController.js";
import { authMiddleware } from "../middlewares/authMiddleware.js";

const router = express.Router();

router.post("/create-account", createUser);
router.post("/login", loginUser);
router.get("/user", authMiddleware, getUserData);
router.get("/saved-contacts", authMiddleware, getCurrentUserSavedContacts);
router.get("/:payid", authMiddleware, searchUsersByPayID);
router.post("/is-token-valid", isTokenValid);
router.patch("/save-contact", authMiddleware, saveContact);
router.put("/saved-contacts/:id", authMiddleware, deleteUserSavedContact);

export default router;
