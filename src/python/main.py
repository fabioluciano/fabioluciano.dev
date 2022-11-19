from os.path import dirname, abspath
from os import environ
from collections import Counter

from libs.github_client import GithubClient
from libs.template import Template

github_client = GithubClient(environ["GITHUB_TOKEN"])
section_dir = dirname(abspath(__file__)) + "/resources/data/"


repositories = github_client.get_repositories_by_users(
    users=["fabioluciano", "integr8", "utils-docker"],
)
repositories_with_description = [
    repository for repository in repositories if (repository["description"] is not None)
]

all_topics = [
    val
    for sublist in repositories_with_description
    if len(sublist["topics"])
    for val in sublist["topics"]
]
most_common_topic = Counter(all_topics).most_common(10)
most_common_topic_list = [topic[0] for topic in most_common_topic]
oxford_comma_separated_topics = ", ".join(
    most_common_topic_list[:-2] + [" e ".join(most_common_topic_list[-2:])]
)

for topic in ["docker", "ansible", "terraform", "packer"]:
    section = section_dir + topic + ".adoc"
    filtered_repos = [
        repository
        for repository in repositories_with_description
        if topic in repository["topics"]
    ][0:5]
    Template(template_file="repositories-list.adoc.jinja2", data=filtered_repos).write(
        section
    )
