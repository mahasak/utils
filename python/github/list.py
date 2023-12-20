import os
import requests
from dotenv import load_dotenv

# Load environment variables from .env file
load_dotenv()

def get_parent_repository(owner, repo_name):
    github_token = os.getenv('GITHUB_DELETE_TOKEN')

    if not github_token:
        print("GitHub token not found. Set GITHUB_TOKEN in .env file.")
        return None

    headers = {
        'Authorization': f'Bearer {github_token}',
        'Accept': 'application/vnd.github.v3+json'
    }

    # Fetching the repository information
    repo_url = f'https://api.github.com/repos/{owner}/{repo_name}'
    response = requests.get(repo_url, headers=headers)

    if response.status_code != 200:
        print(f"Error fetching repository information: {response.status_code}")
        return None

    repo_info = response.json()

    # Check if it's a forked repository
    if repo_info.get('fork', False):
        if 'parent' in repo_info:
            parent_repo_info = repo_info['parent']
            return parent_repo_info
        else:
            print(f"Error: Parent repository not found for {owner}/{repo_name}")
            return None
    else:
        print(f"Error: {owner}/{repo_name} is not a forked repository")
        return None

def list_forked_repositories(owner):
    github_token = os.getenv('GITHUB_DELETE_TOKEN')

    if not github_token:
        print("GitHub token not found. Set GITHUB_TOKEN in .env file.")
        return

    headers = {
        'Authorization': f'Bearer {github_token}',
        'Accept': 'application/vnd.github.v3+json'
    }

    # Fetching the owner's repositories
    owner_repos_url = f'https://api.github.com/users/{owner}/repos'
    response = requests.get(owner_repos_url, headers=headers)

    if response.status_code != 200:
        print(f"Error fetching repositories for {owner}: {response.status_code}")
        return

    repositories = response.json()

    # Filtering forked repositories
    forked_repositories = [repo for repo in repositories if repo.get('fork', False)]

    if not forked_repositories:
        print(f"No forked repositories found for {owner}.")
    else:
        
        print(f"Forked repositories for {owner}:")
        with open('fork.txt', 'w') as file:
            for repo in forked_repositories:
                parent = get_parent_repository(owner, repo['name'])
                file.write(f"{parent['full_name']}\n")
                
                print(f"- {repo['name']} (URL: {repo['html_url']})")
                print(f"  - Source Repository: {parent['full_name']}")

        print("Data written to fork.txt")

if __name__ == "__main__":
    owner = "mahasak"
    list_forked_repositories(owner)
