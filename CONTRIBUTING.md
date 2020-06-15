# Contributing Guidelines

The Jenkins Infratructure Charts project accepts contributions via GitHub pull requests. This document outlines the process to help get your contribution accepted.

## Sign Your Work

The sign-off is a simple line at the end of the explanation for a commit. All commits needs to be signed. Your signature certifies that you wrote the patch or otherwise have the right to contribute the material.

Then you just add a line to every git commit message:

Signed-off-by: Joe Smith <joe.smith@example.com>

If you set your user.name and user.email git configs, you can sign your commit automatically with git commit -s.

Note: If your git config information is set properly then viewing the git log information for your commit will look something like this:

Author: Joe Smith <joe.smith@example.com>
Date:   Thu Feb 2 11:41:15 2018 -0800

    Update README

    Signed-off-by: Joe Smith <joe.smith@example.com>

## How to Contribute to an Existing Chart

1. Fork this repository, develop and test your Chart changes.
2. Remember to sign off your commits as described in the "Sign Your Work" chapter.
3. Ensure your Chart changes follow the technical and documentation guidelines, described below.
4. Submit a pull request.

NOTE: In order to make testing and merging of PRs easier, please submit changes to multiple charts in separate PRs.

### Technical Requirements

* All Chart dependencies should also be submitted independently
* Must pass the linter (helm lint)
* Must successfully launch with default values (helm install .)
    * All pods go to the running state (or NOTES.txt provides further instructions if a required value is missing e.g. minecraft)
    * All services have at least one endpoint
* Must include source GitHub repositories for images used in the Chart
* Images should not have any major security vulnerabilities
* Must be up-to-date with the latest stable Helm/Kubernetes features
    * Use Deployments in favor of ReplicationControllers
* Should follow Kubernetes best practices
    * Include Health Checks wherever practical
    * Allow configurable resource requests and limits
* Provide a method for data persistence (if applicable)
* Support application upgrades
* Allow customization of the application configuration
* Provide a secure default configuration
* Do not leverage alpha features of Kubernetes
* Includes a NOTES.txt explaining how to use the application after install
* Follows best practices (especially for labels and values)

### Documentation Requirements

* Must include an in-depth README.md, including:
    * Short description of the Chart
    * Any prerequisites or requirements
    * Customization: explaining options in values.yaml and their defaults
* Must include a short NOTES.txt, including:
    * Any relevant post-installation information for the Chart
    * Instructions on how to access the application or service provided by the Chart

### Merge Approval and Release Process

A Jenkins infrastructure Charts maintainer will review the Chart change submission.  No pull requests can be merged until at least one maintainer approve the pull request.

Once the pull request has been merged, changes will automatically be applied.

## Support Channels

Whether you are a user or contributor, official support channels is IRC, [freenode#jenkins-infra](https://www.jenkins.io/chat/#jenkins-infra)

Before opening a new issue or submitting a new pull request, it's helpful to search the project - it's likely that another user has already reported the issue you're facing, or it's a known issue that we're already aware of.
