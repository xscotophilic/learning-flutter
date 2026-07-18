export default function auth(req, res, next) {
  const token = req.headers["authorization"];

  if (!token) {
    return res.status(401).json({ message: "Authorization token is required" });
  }

  req.user_id = token;
  next();
}
