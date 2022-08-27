import jwt from "jsonwebtoken";
import User from "../models/userModel.js";

const authMiddleware = async (req, res, next) => {
  try {
    const token = req.header("ax-auth-token");

    if (!token)
      return res.status(401).json({ msg: "No Auth Token, Access Denied" });

    const verified = jwt.verify(token, process.env.JWT_SECRET);

    if (!verified)
      return res
        .status(401)
        .json({ msg: "Token Verification Failed, Authroziation Denied" });

    req.user = verified.id;
    req.token = token;
    next();
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

const adminMiddleware = async (req, res, next) => {
  try {
    const token = req.header("ax-auth-token");
    if (!token)
      return res.status(401).json({ msg: "No auth token, access denied" });

    const verified = jwt.verify(token, process.env.JWT_SECRET);
    if (!verified)
      return res
        .status(401)
        .json({ msg: "Token verification failed, authorization denied." });
    const user = await User.findById(verified.id);
    if (user.type == "buyer" || user.type == "seller") {
      return res.status(401).json({ msg: "You are not an admin!" });
    }
    req.user = verified.id;
    req.token = token;
    next();
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

export { authMiddleware, adminMiddleware };
