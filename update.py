import fnmatch
import os
import subprocess
from typing import List


class Updater:
    """Update files in the repository from the main branch."""

    def __init__(
        self,
        branch: str = "main",
        exclude_file: str = "exclude",
        save_dir: str = "docs/",
    ):
        self.branch = branch
        self.save_dir = save_dir
        self.experiments = [1, 2, 3, 4, 5, 6, 7, 9]

        os.makedirs(save_dir, exist_ok=True)
        self.exclude = self.get_exclude(exclude_file)
        self.files = self.list_files()

    def get_exclude(self, file) -> List[str]:
        """Read patterns from file and return a list of patterns"""
        exclude: List[str] = []
        with open(file, "r") as file_handle:
            for line in file_handle.readlines():
                pattern = line.strip()
                if pattern and not pattern.startswith("#"):
                    exclude.append(pattern)
        return exclude

    def _exclude(self, file: str) -> bool:
        """Check if a file should be excluded"""
        for pattern in self.exclude:
            if fnmatch.fnmatch(file, pattern):
                return True
        return False

    def list_files(self) -> List[str]:
        """List all files in the repository, excluding patterns in self.exclude"""

        command = ["git", "ls-tree", "-r", self.branch, "--name-only"]
        result = subprocess.run(command, capture_output=True, text=True)

        if not result.returncode == 0:
            raise Exception("Failed to list files in the repository")

        all_files = result.stdout.splitlines()
        return [file for file in all_files if not self._exclude(file)]

    def _get_commit_hash(self) -> str:
        """Get the commit hash of the latest commit on the main branch"""
        command = f"git rev-parse {self.branch}"
        result = subprocess.run(command.split(), capture_output=True, text=True)

        if not result.returncode == 0:
            raise Exception(f"Failed to get commit hash on {self.branch} branch")

        return result.stdout.strip()

    def save_commit_hash(self):
        """Save the commit hash to a file"""
        commit_hash = self._get_commit_hash()
        with open("commit_hash", "w") as file_handle:
            file_handle.write(commit_hash)

    def fetch(self):
        """Fetch the files in the repository"""
        self.content: dict[str, str] = {}
        for file in self.files:
            command = f"git show {self.branch}:{file}"
            result = subprocess.run(command.split(), capture_output=True, text=True)

            if not result.returncode == 0:
                raise Exception(f"Failed to update {file}")

            self.content[file] = result.stdout

    def _update_home(self):
        file = os.path.join(self.save_dir, "README.md")
        with open(file, "w") as file_handle:
            file_handle.write(self.content["README.md"])

    def _create_experiments(self):
        """Create experiments in self.save_dir"""
        for i in self.experiments:
            file = os.path.join(self.save_dir, f"Experiment-{i:02}.md")
            if os.path.exists(file):
                continue
            with open(file, "w") as file_handle:
                file_handle.write(f"# Experiment {i}\n\n")

    def _update_experiment(self, number: int):
        def segregate():
            experiment: dict[str, str] = {}
            for file, content in self.content.items():
                if file.startswith(f"Experiment-{number}/E{number}_"):
                    file = file.replace(f"Experiment-{number}/E{number}_", "")
                    experiment[file] = content

            examples: dict[str, str] = {}
            exercises: dict[str, str] = {}
            problems: dict[str, str] = {}
            for file, content in experiment.items():
                start, index = file[0], file[1:]
                index = index.replace(".ASM", "")
                if start == "E":
                    examples[index] = content
                elif start == "X":
                    exercises[index] = content
                elif start == "P":
                    problems[index] = content
            return examples, exercises, problems

        def write(contents: dict[str, str], file_handle, prefix=""):
            def priority(key):
                parts = key.split("_")
                if len(parts) == 1:
                    parts = key.split("-")
                primary = int(parts[0])
                if len(parts) > 1:
                    secondary = int(parts[1])
                else:
                    secondary = 0
                return (primary, secondary)

            keys = sorted(contents, key=priority)
            for key in keys:
                file_handle.write(f"### {prefix}-{key}\n\n")
                file_handle.write("```assembly\n")
                file_handle.write(contents[key])
                file_handle.write("```\n\n")

        examples, exercises, problems = segregate()
        file = os.path.join(self.save_dir, f"Experiment-{number:02}.md")
        with open(file, "w") as file_handle:
            file_handle.write(f"# Experiment-{number}\n\n")
            if examples:
                file_handle.write("## Examples\n\n")
                write(examples, file_handle, prefix="Example")
            if exercises:
                file_handle.write("## Exercises\n\n")
                write(exercises, file_handle, prefix="Exercise")
            if problems:
                file_handle.write("## Problems\n\n")
                write(problems, file_handle, prefix="Problem")

    def update(self):
        # self._update_home()
        self._create_experiments()
        for number in self.experiments:
            self._update_experiment(number)


if __name__ == "__main__":
    pages = Updater()
    pages.fetch()
    pages.update()
    pages.save_commit_hash()
