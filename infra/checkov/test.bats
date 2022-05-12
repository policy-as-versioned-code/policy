#!/usr/bin/env bats

# Bats doesn't currently support dynamic test definitions
# so I've had to test all the policies within a single @test
# while test failures will show some output it would be
# much nicer to have a @test per test case
# https://github.com/bats-core/bats-core/issues/306

@test "checkov" {
for dir in infra/checkov/*/ ; do
  for passing in ${dir}pass*.tf ; do
    # @test "Passing: ${passing}" {
      echo "Passing: ${passing}"
      checkov --config-file infra/checkov/config.yaml -f ${passing} --external-checks-dir ${dir}
    # }
  done
  for failing in ${dir}fail*.tf ; do
    # @test "Failing: ${failing}" {
      echo "Failing: ${failing}"
      ! checkov --config-file infra/checkov/config.yaml -f ${failing} --external-checks-dir ${dir}
    # }
  done
done
}