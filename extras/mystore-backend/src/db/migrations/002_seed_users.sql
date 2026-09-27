-- Seed system users with well-known fixed UUIDs so they are stable
-- across environments and can be referenced as constants in code.

INSERT INTO users (id, google_sub, email, name)
VALUES
  ('00000000-0000-0000-0000-000000000099', 'system:admin', 'admin@mystore.local',  'Admin'),
  ('00000000-0000-0000-0000-000000000001', 'system:demo',  'demo@mystore.local',   'Demo User')
ON CONFLICT (google_sub) DO NOTHING;
