import os
import requests
from dotenv import load_dotenv

def get_github_rate_limit(username, token):
    """
    Get GitHub API rate limit information.

    Parameters:
    - username: Your GitHub username
    - token: Your personal access token

    Returns:
    A dictionary containing rate limit information
    """
    
    url = "https://api.github.com/rate_limit"
    headers = {
        "Accept": "application/vnd.github.v3+json",
        "Authorization": f"token {token}"
    }

    try:
        response = requests.get(url, headers=headers)
        response.raise_for_status()  # Raise an exception for bad responses
        rate_limit_info = response.json()["resources"]["core"]
        return rate_limit_info
    except requests.exceptions.RequestException as e:
        print(f"Error: {e}")
        return None

# Replace 'your_username' and 'your_token' with your GitHub username and personal access token
username = 'mahasak'
token = os.getenv('GITHUB_DELETE_TOKEN')

rate_limit_info = get_github_rate_limit(username, token)

if rate_limit_info:
    print("GitHub API Rate Limit:")
    print(f"Limit: {rate_limit_info['limit']}")
    print(f"Remaining: {rate_limit_info['remaining']}")
    print(f"Reset Time: {rate_limit_info['reset']}")
