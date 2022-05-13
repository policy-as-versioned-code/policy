# Policy as \[versioned\] code

This repo contains the company policy that has been codified into [kyverno](https://kyverno.io/) and [checkov](https://www.checkov.io/) policies.

## Usage

See [app1](https://github.com/policy-as-versioned-code/app1),
[app2](https://github.com/policy-as-versioned-code/app2) and 
[app3](https://github.com/policy-as-versioned-code/app3) for Kubernetes implementations; and [infra1](https://github.com/policy-as-versioned-code/infra1),
[infra2](https://github.com/policy-as-versioned-code/infra2) and 
[infra3](https://github.com/policy-as-versioned-code/infra3) for terraform implementations.

## Development

### Kubernetes policies

These are kept in [kubernetes/kyverno](./kubernetes/kyverno) and can be added to by creating a new directory, and referencing this in the [kustomization.yaml](./kubernetes/kyverno/kustomization.yaml). It is important that test cases are created and a test.yaml accompanies the policy.yaml following the [documentation of developing kyverno policy](https://kyverno.io/docs/kyverno-cli/#test).

If you want to inherit an external policy for example from the kyverno policy library you can add the reference in the [kustomization.yaml](./kubernetes/kyverno/kustomization.yaml). If doing this, it is important for the stability of the policy to reference an immutable reference such as a git-sha to ensure that the implementations of policy checking based on this repo are deterministic and repeatable.

Testing can be accomplished with:
```bash
$ kyverno test .
```

### Terraform IaaC policies

Similar to the [Kubernetes policies](#kubernetes-policies) these are in [infra/checkov](./infra/checkov/) and can be added to by creating a new directory. [checkov](https://checkov.io) doesn't yet have a formalised testing pattern for policy. So a [BATS](https://github.com/bats-core/bats-core) testing framework has been implemented. Policy can be written either as [python](https://www.checkov.io/3.Custom%20Policies/Python%20Custom%20Policies.html) or [yaml](https://www.checkov.io/3.Custom%20Policies/YAML%20Custom%20Policies.html).

If you want to inherit an external policy for example one of the checks built in to checkov you can add to the checks in the [checkov config](./infra/checkov/config.yaml).

If doing this, it is important for the stability of the policy to reference specific checks and an immutable reference where available such as a git-sha to ensure that the implementations of policy checking based on this repo are deterministic and repeatable.

Testing can be accomplished with:
```bash
$ bats infra/checkov/test.bats
```


---

See the the GitHub [organization's .github repo](https://github.com/policy-as-versioned-code/.github) to better understand how the repositories connect together.

