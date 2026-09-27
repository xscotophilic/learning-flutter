// Placeholder auth - no real authentication.
// Always assigns a fixed demo user ID instead of reading it from
// a header, because accepting the user ID directly from the client
// would allow anyone to impersonate any user by simply changing the
// header value.
export default function dummyAuth(req, res, next) {
  req.user_id = "00000000-0000-0000-0000-000000000001";
  next();
}
