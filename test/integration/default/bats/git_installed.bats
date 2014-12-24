#!/usr/bin/env bats

@test "aide RPM installed" {
  run rpm -q aide
  [ "$status" -eq 0 ]
}
