from github import Github
class GithubClient:

  def __init__(self, token):
    self.github_instance = Github(login_or_token=token)

  def get_repositories_by_users(self, users=[]):
    repository_list = []

    for user in users:
      github_user = self.github_instance.get_user(user)

      for repository in github_user.get_repos():
          temp_repository = {}
          temp_repository.update({ 'name': repository.name })
          temp_repository.update({ 'html_url': repository.html_url })
          temp_repository.update({ 'description': repository.description })
          temp_repository.update({ 'homepage': repository.homepage })
          temp_repository.update({ 'topics': repository.get_topics()})

          repository_list.append(temp_repository)

    return sorted(repository_list, key=lambda x: (x['description'] is None, x['description']))
