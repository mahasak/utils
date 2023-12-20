import requests
import os
from dotenv import load_dotenv

load_dotenv()

def read_repository_list(file_path):
    with open(file_path, 'r') as file:
        repositories = [line.strip() for line in file.readlines() if line.strip()]
    return repositories

def transform():
    with open('fork.txt', 'r') as input_file:
      # Read lines from input file
      lines = input_file.readlines()

    # Extract repository names (assuming format is owner/repo)
    repos = [line.strip().split('/')[1] for line in lines]

    with open('delete.txt', 'w') as output_file:
        # Write repository names to output file
        for repo in repos:
            output_file.write(repo + '\n')

    print("Transformation complete. Check 'delete.txt' for the output.")

def fork_repository(repository, access_token):
    owner, repo = repository.split('/')
    headers = {
        'Authorization': f'Bearer {access_token}',
        'Accept': 'application/vnd.github.v3+json'
    }
    
    # Check if the repository exists
    response = requests.get(f'https://api.github.com/repos/{owner}/{repo}', headers=headers)
    if response.status_code != 200:
        print(f"Repository {owner}/{repo} not found. Skipping.")
        return
    
    # Fork the repository
    fork_url = f'https://api.github.com/repos/{owner}/{repo}/forks'
    response = requests.post(fork_url, headers=headers)
    
    if response.status_code == 202:
        print(f"Repository {owner}/{repo} forked successfully.")
    else:
        print(f"Failed to fork repository {owner}/{repo}. Status code: {response.status_code}")

def delete_github_repo(repo_owner, repo_name, token):
    headers = {
        'Authorization': f'token {token}',
        'Accept': 'application/vnd.github.v3+json',
    }
    url = f'https://api.github.com/repos/{repo_owner}/{repo_name}'
    
    response = requests.delete(url, headers=headers)
    
    if response.status_code == 204:
        print(f"Repository {repo_owner}/{repo_name} deleted successfully.")
    else:
        print(f"Failed to delete repository {repo_owner}/{repo_name}. Status code: {response.status_code}")
        print(response.json())

def delete_repositories_from_file(owner, token, file_path):
    with open(file_path, 'r') as file:
        repositories = [line.strip() for line in file]

    for repo_name in repositories:
        delete_github_repo(owner, repo_name, token)

if __name__ == '__main__':
    file_path = 'fork.txt'  # Change this to your file path
    access_token = os.getenv('GITHUB_FORK_TOKEN') # Replace with your GitHub access token

    repositories = read_repository_list(file_path)

    for repository in repositories:
        fork_repository(repository, access_token)

    transform()

    delete_token = os.getenv('GITHUB_DELETE_TOKEN')
    
    # GitHub repository owner
    # owner = input('Enter the GitHub repository owner: ')
    delete_owner = 'mahasak'

    # Text file containing repository names
    delete_file_path = 'delete.txt'

    delete_repositories_from_file(delete_owner, delete_token, delete_file_path)
