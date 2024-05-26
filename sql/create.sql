--
-- PostgreSQL database dump
--

-- Dumped from database version 12.17
-- Dumped by pg_dump version 12.17

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: ball_by_ball; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ball_by_ball (
    match_id integer NOT NULL,
    innings_id integer NOT NULL,
    over_id integer NOT NULL,
    ball_id integer NOT NULL,
    team_batting_id integer,
    team_bowling_id integer,
    striker_id integer,
    striker_batting_position integer,
    non_striker_id integer,
    bowler_id integer,
    batsman_scored integer,
    extra_type character varying(50),
    extra_runs integer,
    player_dissimal_id integer,
    dismissal_type character varying(150),
    fielder_id integer
);


ALTER TABLE public.ball_by_ball OWNER TO postgres;

--
-- Name: match; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.match (
    match_id integer NOT NULL,
    match_date date,
    team_name_id integer,
    opponent_team_id integer,
    season_id integer,
    venue_name character varying(255),
    toss_winner_id integer,
    toss_decision character varying(50),
    is_superover boolean,
    is_result boolean,
    is_duckworthlewis boolean,
    win_type character varying(50),
    won_by integer,
    match_winner_id integer,
    man_of_the_match_id integer,
    city_name character varying(255)
);


ALTER TABLE public.match OWNER TO postgres;

--
-- Name: player; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.player (
    player_id integer NOT NULL,
    player_name character varying(255),
    dob date,
    batting_hand character varying(50),
    bowling_skill character varying(50),
    country character varying(50),
    is_umpire boolean
);


ALTER TABLE public.player OWNER TO postgres;

--
-- Name: player_match; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.player_match (
    match_id integer NOT NULL,
    player_id integer NOT NULL,
    team_id integer,
    is_keeper integer,
    is_captain integer
);


ALTER TABLE public.player_match OWNER TO postgres;

--
-- Name: season; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.season (
    season_id integer NOT NULL,
    season_year integer,
    orange_cap_id integer,
    purple_cap_id integer,
    man_of_the_series_id integer
);


ALTER TABLE public.season OWNER TO postgres;

--
-- Name: team; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.team (
    team_id integer NOT NULL,
    team_name character varying(255)
);


ALTER TABLE public.team OWNER TO postgres;

--
-- Name: teamshortcode; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.teamshortcode (
    team_name character varying(255) NOT NULL,
    team_short_code character varying(10) NOT NULL
);


ALTER TABLE public.teamshortcode OWNER TO postgres;

--
-- Name: umpire_match; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.umpire_match (
    match_umpire_id integer NOT NULL,
    match_id integer,
    umpire_id integer,
    role character varying(50)
);


ALTER TABLE public.umpire_match OWNER TO postgres;

--
-- Name: umpires; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.umpires (
    umpire_id integer NOT NULL,
    umpire_name character varying(255),
    country character varying(50),
    age integer,
    experience_years integer
);


ALTER TABLE public.umpires OWNER TO postgres;

--
-- Name: venuecitycountry; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.venuecitycountry (
    venue_name character varying(255) NOT NULL,
    city_name character varying(255) NOT NULL,
    host_country character varying(255) NOT NULL
);


ALTER TABLE public.venuecitycountry OWNER TO postgres;

--
-- Name: ball_by_ball ball_by_ball_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ball_by_ball
    ADD CONSTRAINT ball_by_ball_pkey PRIMARY KEY (match_id, innings_id, over_id, ball_id);


--
-- Name: match matches_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.match
    ADD CONSTRAINT matches_pkey PRIMARY KEY (match_id);


--
-- Name: player_match player_match_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.player_match
    ADD CONSTRAINT player_match_pkey PRIMARY KEY (match_id, player_id);


--
-- Name: player player_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.player
    ADD CONSTRAINT player_pkey PRIMARY KEY (player_id);


--
-- Name: season season_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.season
    ADD CONSTRAINT season_pkey PRIMARY KEY (season_id);


--
-- Name: team team_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.team
    ADD CONSTRAINT team_pkey PRIMARY KEY (team_id);


--
-- Name: teamshortcode teamshortcode_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.teamshortcode
    ADD CONSTRAINT teamshortcode_pkey PRIMARY KEY (team_name);


--
-- Name: umpire_match umpire_match_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.umpire_match
    ADD CONSTRAINT umpire_match_pkey PRIMARY KEY (match_umpire_id);


--
-- Name: umpires umpires_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.umpires
    ADD CONSTRAINT umpires_pkey PRIMARY KEY (umpire_id);


--
-- Name: venuecitycountry venuecitycountry_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.venuecitycountry
    ADD CONSTRAINT venuecitycountry_pkey PRIMARY KEY (venue_name);


--
-- Name: idx_ball_by_ball_match_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_ball_by_ball_match_id ON public.ball_by_ball USING btree (match_id);


--
-- Name: idx_ball_by_ball_striker_score; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_ball_by_ball_striker_score ON public.ball_by_ball USING btree (striker_id, batsman_scored);


--
-- Name: idx_ball_by_ball_team_batting_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_ball_by_ball_team_batting_id ON public.ball_by_ball USING btree (team_batting_id);


--
-- Name: idx_match_date; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_match_date ON public.match USING btree (match_date);


--
-- Name: idx_match_man_of_the_match_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_match_man_of_the_match_id ON public.match USING btree (man_of_the_match_id);


--
-- Name: idx_match_match_id_season_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_match_match_id_season_id ON public.match USING btree (match_id, season_id);


--
-- Name: idx_match_season_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_match_season_id ON public.match USING btree (season_id);


--
-- Name: idx_player_match_match_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_player_match_match_id ON public.player_match USING btree (match_id);


--
-- Name: idx_player_match_player_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_player_match_player_id ON public.player_match USING btree (player_id);


--
-- Name: ball_by_ball ball_by_ball_bowler_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ball_by_ball
    ADD CONSTRAINT ball_by_ball_bowler_id_fkey FOREIGN KEY (bowler_id) REFERENCES public.player(player_id);


--
-- Name: ball_by_ball ball_by_ball_fielder_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ball_by_ball
    ADD CONSTRAINT ball_by_ball_fielder_id_fkey FOREIGN KEY (fielder_id) REFERENCES public.player(player_id);


--
-- Name: ball_by_ball ball_by_ball_non_striker_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ball_by_ball
    ADD CONSTRAINT ball_by_ball_non_striker_id_fkey FOREIGN KEY (non_striker_id) REFERENCES public.player(player_id);


--
-- Name: ball_by_ball ball_by_ball_player_dissimal_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ball_by_ball
    ADD CONSTRAINT ball_by_ball_player_dissimal_id_fkey FOREIGN KEY (player_dissimal_id) REFERENCES public.player(player_id);


--
-- Name: ball_by_ball ball_by_ball_striker_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ball_by_ball
    ADD CONSTRAINT ball_by_ball_striker_id_fkey FOREIGN KEY (striker_id) REFERENCES public.player(player_id);


--
-- Name: ball_by_ball ball_by_ball_team_batting_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ball_by_ball
    ADD CONSTRAINT ball_by_ball_team_batting_id_fkey FOREIGN KEY (team_batting_id) REFERENCES public.team(team_id);


--
-- Name: ball_by_ball ball_by_ball_team_bowling_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ball_by_ball
    ADD CONSTRAINT ball_by_ball_team_bowling_id_fkey FOREIGN KEY (team_bowling_id) REFERENCES public.team(team_id);


--
-- Name: match matches_man_of_the_match_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.match
    ADD CONSTRAINT matches_man_of_the_match_id_fkey FOREIGN KEY (man_of_the_match_id) REFERENCES public.player(player_id);


--
-- Name: match matches_match_winner_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.match
    ADD CONSTRAINT matches_match_winner_id_fkey FOREIGN KEY (match_winner_id) REFERENCES public.team(team_id);


--
-- Name: match matches_opponent_team_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.match
    ADD CONSTRAINT matches_opponent_team_id_fkey FOREIGN KEY (opponent_team_id) REFERENCES public.team(team_id);


--
-- Name: match matches_season_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.match
    ADD CONSTRAINT matches_season_id_fkey FOREIGN KEY (season_id) REFERENCES public.season(season_id);


--
-- Name: match matches_team_name_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.match
    ADD CONSTRAINT matches_team_name_id_fkey FOREIGN KEY (team_name_id) REFERENCES public.team(team_id);


--
-- Name: match matches_toss_winner_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.match
    ADD CONSTRAINT matches_toss_winner_id_fkey FOREIGN KEY (toss_winner_id) REFERENCES public.team(team_id);


--
-- Name: season season_man_of_the_series_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.season
    ADD CONSTRAINT season_man_of_the_series_id_fkey FOREIGN KEY (man_of_the_series_id) REFERENCES public.player(player_id);


--
-- Name: season season_orange_cap_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.season
    ADD CONSTRAINT season_orange_cap_id_fkey FOREIGN KEY (orange_cap_id) REFERENCES public.player(player_id);


--
-- Name: season season_purple_cap_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.season
    ADD CONSTRAINT season_purple_cap_id_fkey FOREIGN KEY (purple_cap_id) REFERENCES public.player(player_id);


--
-- Name: umpire_match umpire_match_match_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.umpire_match
    ADD CONSTRAINT umpire_match_match_id_fkey FOREIGN KEY (match_id) REFERENCES public.match(match_id);


--
-- Name: umpire_match umpire_match_umpire_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.umpire_match
    ADD CONSTRAINT umpire_match_umpire_id_fkey FOREIGN KEY (umpire_id) REFERENCES public.umpires(umpire_id);


--
-- PostgreSQL database dump complete
--

