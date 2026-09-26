import ApiError from "../utils/ApiError.js";
import User from "../models/User.js";
import { verifyGoogleIdToken } from "../utils/googleAuth.js";
import { signAppToken } from "../utils/jwt.js";

export async function loginWithGoogle(idToken) {
  if (!idToken) {
    throw new ApiError(400, "id_token is required");
  }

  let profile;
  try {
    profile = await verifyGoogleIdToken(idToken);
  } catch {
    throw new ApiError(401, "Invalid Google ID token");
  }

  const user = await User.findOrCreateByGoogleProfile(profile);

  const token = signAppToken({ user_id: user.id });

  return { token, user };
}
