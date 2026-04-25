from flask import Flask, render_template, jsonify
import json

app = Flask(__name__)

# IPL Teams Data
IPL_TEAMS = [
    {"id": 1, "name": "Mumbai Indians", "short": "MI", "color": "#004BA0", "titles": 5, "captain": "Hardik Pandya"},
    {"id": 2, "name": "Chennai Super Kings", "short": "CSK", "color": "#FCCA06", "titles": 5, "captain": "MS Dhoni"},
    {"id": 3, "name": "Royal Challengers Bangalore", "short": "RCB", "color": "#EC1C24", "titles": 0, "captain": "Faf du Plessis"},
    {"id": 4, "name": "Kolkata Knight Riders", "short": "KKR", "color": "#3A225D", "titles": 2, "captain": "Shreyas Iyer"},
    {"id": 5, "name": "Delhi Capitals", "short": "DC", "color": "#282968", "titles": 0, "captain": "David Warner"},
    {"id": 6, "name": "Rajasthan Royals", "short": "RR", "color": "#EA1A85", "titles": 1, "captain": "Sanju Samson"},
    {"id": 7, "name": "Punjab Kings", "short": "PBKS", "color": "#ED1B24", "titles": 0, "captain": "Shikhar Dhawan"},
    {"id": 8, "name": "Sunrisers Hyderabad", "short": "SRH", "color": "#F7A721", "titles": 1, "captain": "Pat Cummins"},
    {"id": 9, "name": "Gujarat Titans", "short": "GT", "color": "#1C1C1C", "titles": 1, "captain": "Shubman Gill"},
    {"id": 10, "name": "Lucknow Super Giants", "short": "LSG", "color": "#A72056", "titles": 0, "captain": "KL Rahul"}
]

# Sample IPL Matches
IPL_MATCHES = [
    {"id": 1, "team1": "MI", "team2": "CSK", "venue": "Wankhede Stadium", "winner": "CSK", "date": "2026-03-22"},
    {"id": 2, "team1": "RCB", "team2": "KKR", "venue": "M. Chinnaswamy Stadium", "winner": "KKR", "date": "2026-03-23"},
    {"id": 3, "team1": "DC", "team2": "RR", "venue": "Arun Jaitley Stadium", "winner": "RR", "date": "2026-03-24"},
    {"id": 4, "team1": "GT", "team2": "LSG", "venue": "Narendra Modi Stadium", "winner": "GT", "date": "2026-03-25"},
    {"id": 5, "team1": "SRH", "team2": "PBKS", "venue": "Rajiv Gandhi Stadium", "winner": "SRH", "date": "2026-03-26"}
]

# Top Players
TOP_PLAYERS = [
    {"name": "Sai Sudarshan", "team": "GT", "role": "Batsman", "runs": 8000, "wickets": 2},
    {"name": "Virat Kohli", "team": "RCB", "role": "Batsman", "runs": 7263, "wickets": 4},
    {"name": "MS Dhoni", "team": "CSK", "role": "Wicket-keeper", "runs": 5082, "wickets": 0},
    {"name": "Rohit Sharma", "team": "MI", "role": "Batsman", "runs": 6028, "wickets": 15},
    {"name": "Jasprit Bumrah", "team": "MI", "role": "Bowler", "runs": 56, "wickets": 145},
    {"name": "Ravindra Jadeja", "team": "CSK", "role": "All-rounder", "runs": 2692, "wickets": 152}
]

@app.route('/')
def home():
    return render_template('index.html', 
                         teams=IPL_TEAMS, 
                         matches=IPL_MATCHES, 
                         players=TOP_PLAYERS)

@app.route('/api/teams')
def get_teams():
    return jsonify(IPL_TEAMS)

@app.route('/api/matches')
def get_matches():
    return jsonify(IPL_MATCHES)

@app.route('/api/players')
def get_players():
    return jsonify(TOP_PLAYERS)

@app.route('/health')
def health():
    return jsonify({"status": "healthy", "app": "IPL Cricket App"})

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)
