import express from "express";
import {
  accountSummary,
  createTransaction,
} from "../controllers/transactionController.js";
import { authMiddleware } from "../middlewares/authMiddleware.js";

const router = express.Router();

router.post("/newTransaction", authMiddleware, createTransaction);
router.get("/summary", authMiddleware, accountSummary);

export default router;
