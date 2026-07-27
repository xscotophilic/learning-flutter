import { OAuth2Client } from "google-auth-library";
import env from "../config/env.js";

function getAudience() {
  if (!env.googleClientId) {
    throw new Error("GOOGLE_CLIENT_ID is not defined in the environment");
  }
  return env.googleClientId.split(",").map((id) => id.trim());
}

const client = new OAuth2Client();

export async function verifyGoogleIdToken(idToken) {
  const ticket = await client.verifyIdToken({
    idToken,
    audience: getAudience(),
  });

  const payload = ticket.getPayload();

  return {
    googleSub: payload.sub,
    email: payload.email,
    name: payload.name,
    picture: payload.picture,
  };
}
