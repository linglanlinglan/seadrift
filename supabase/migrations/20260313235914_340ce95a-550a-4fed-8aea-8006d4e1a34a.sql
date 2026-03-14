
-- Global leaderboard table
CREATE TABLE public.leaderboard (
  id UUID NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
  player_name TEXT NOT NULL,
  score INTEGER NOT NULL,
  distance INTEGER NOT NULL,
  created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now()
);

-- Enable RLS
ALTER TABLE public.leaderboard ENABLE ROW LEVEL SECURITY;

-- Anyone can read the leaderboard
CREATE POLICY "Anyone can view leaderboard" ON public.leaderboard FOR SELECT USING (true);

-- Anyone can submit scores (no auth required for a casual game)
CREATE POLICY "Anyone can submit scores" ON public.leaderboard FOR INSERT WITH CHECK (true);

-- Index for fast top-10 queries
CREATE INDEX idx_leaderboard_score ON public.leaderboard (score DESC);
