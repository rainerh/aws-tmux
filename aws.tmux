#!/usr/bin/env bash
#
# AWS status line for tmux
#

AWS_TMUX_BINARY="${AWS_TMUX_BINARY:-aws}"
STATUS_DEFAULT_COLOR="${STATUS_DEFAULT_COLOR:-black}"
AWS_REGION="unknown"
AWS_PROFILE="unknown"

aws_get_region() {
  AWS_REGION="$(${AWS_TMUX_BINARY} configure get region 2>/dev/null)"
}

aws_get_profile() {
  AWS_PROFILE="$(/bin/cat ~/.aws/current-profile)"
}

aws_tmux() {
  local AWS_STATUS

  # query CLI version and add to status:
  aws_get_profile
  aws_get_region
  AWS_STATUS+="#[fg=$STATUS_DEFAULT_COLOR]#[fg=colour215] ${AWS_PROFILE}#[fg=black]@#[fg=$STATUS_DEFAULT_COLOR]#[fg=colour250]${AWS_REGION} "

  echo "${AWS_STATUS}"
}

aws_tmux "$@"
