// Placeholder auth - no real authentication.
// Always assigns a fixed demo user ID instead of reading it from
// a header, because accepting the user ID directly from the client
// would allow anyone to impersonate any user by simply changing the
// header value. This will be replaced with proper JWT verification
// once authentication is introduced.
export default function auth(req, res, next) {
  req.user_id = "demo-user";
  next();
}
