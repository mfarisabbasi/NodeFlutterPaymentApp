import express from "express";

import {
  createUser,
  getUserData,
  isTokenValid,
  loginUser,
  searchUsersByPayID,
} from "../controllers/userController.js";
import { authMiddleware } from "../middlewares/authMiddleware.js";

const router = express.Router();

router.post("/create-account", createUser);
router.post("/login", loginUser);
router.get("/user", authMiddleware, getUserData);
router.get("/:payid", authMiddleware, searchUsersByPayID);
router.post("/is-token-valid", isTokenValid);

export default router;
