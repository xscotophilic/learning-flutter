import * as authService from "../services/auth.service.js";

export async function googleLogin(req, res) {
  const { id_token: idToken } = req.body;

  const { token, user } = await authService.loginWithGoogle(idToken);

  res.status(200).json({
    data: {
      token,
      user,
    },
  });
}
