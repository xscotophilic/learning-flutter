import jwt from "jsonwebtoken";
import { verifyAppToken } from "../utils/jwt.js";

export default function jwtAuth(req, res, next) {
  const header = req.headers.authorization || "";
  const [scheme, token] = header.split(" ");

  if (scheme !== "Bearer" || !token) {
    return res.status(401).json({ message: "Authorization token is required" });
  }

  try {
    const payload = verifyAppToken(token);
    req.user_id = payload.user_id;
    return next();
  } catch (err) {
    if (err instanceof jwt.TokenExpiredError) {
      return res.status(401).json({ message: "Token has expired" });
    }
    return res.status(401).json({ message: "Invalid or expired token" });
  }
}
