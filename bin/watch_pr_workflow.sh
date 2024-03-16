#!/bin/bash

# Get the current branch name
current_branch=$(git branch --show-current)

# Get the PR number for the current branch
pr_number=$(gh pr list --search "head:${current_branch}" --json number --jq '.[0].number')

if [ -z "$pr_number" ]; then
  echo "No open PR for the current branch: ${current_branch}"
  exit 1
fi

echo "Watching the latest workflow run for PR #$pr_number on branch $current_branch..."

# Watch the latest workflow run for the PR and wait for it to finish
gh run watch --repo $(gh repo view --json nameWithOwner --jq .nameWithOwner) --exit-status

# Check the exit status of the previous command
if [ $? -eq 0 ]; then
  # If gh run watch exits successfully, send a notification
  if is_mac_os; then
    sascript -e 'display notification "Workflow run for PR #$pr_number on branch '\''$current_branch'\'' has completed successfully." with title "GitHub Actions"'
  else
    notify-send "GitHub Actions" "Workflow run for PR #$pr_number on branch '$current_branch' has completed successfully."
  fi
else
  if is_mac_os; then
    sascript -e 'display notification "Workflow run for PR #$pr_number on branch '\''$current_branch'\'' has failed or encountered an issue." with title "GitHub Actions"'
  else
    notify-send "GitHub Actions" "Workflow run for PR #$pr_number on branch '$current_branch' has failed or encountered an issue."
  fi
fi
