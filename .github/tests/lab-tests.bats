setup() {
  DIR="$(cd "$(dirname "$BATS_TEST_FILENAME")" >/dev/null 2>&1 && pwd)"
  PATH="$DIR/../scripts:$PATH"

  load "$DIR/test_helper/bats-support/load"
  load "$DIR/test_helper/bats-assert/load"
}


@test "addition.sh: 5 + 5 equals 10" {
  run addition.sh 5 5
  assert_success
  assert_output "10"
}

@test "addition.sh: missing arguments throws error message" {
  run addition.sh
  assert_failure
  assert_output "command line arguments are missing"
}

@test "addition.sh: missing arguments returns exit code 3" {
  run addition.sh
  assert_failure 3
}
