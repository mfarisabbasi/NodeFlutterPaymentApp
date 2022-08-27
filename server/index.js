import express from "express";
import dotenv from "dotenv";
import connectDB from "./config/db.js";
import userRoutes from "./routes/userRoutes.js";
import transactionRoutes from "./routes/transactionRoutes.js";

// CONSTANTS START

const PORT = process.env.PORT || 3000;

// CONSTANTS END

// CONFIGS START

dotenv.config();
connectDB();

// CONFIGS END

// INITS START

const app = express();

// INITS END

// MIDDLEWARES START

app.use(express.json());

// MIDDLEWARES END

// ROUTES START

app.get("/", (req, res) => {
  res.send(process.env.JWT_SECRET);
});

app.use("/api/users", userRoutes);
app.use("/api/transaction", transactionRoutes);

// ROUTES END

app.listen(PORT, "0.0.0.0", () => {
  console.log(`Server is running on port ${PORT}`);
});
