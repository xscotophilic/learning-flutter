import jwt from "jsonwebtoken";
import env from "../config/env.js";

const DEFAULT_EXPIRY = "7d";

export function signAppToken(payload) {
  return jwt.sign(payload, env.jwtSecret, { expiresIn: DEFAULT_EXPIRY });
}

export function verifyAppToken(token) {
  return jwt.verify(token, env.jwtSecret);
}
