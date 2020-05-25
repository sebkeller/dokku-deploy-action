# Deploy to Dokku Action

This action deploy your application to your Dokku server.

## Inputs

### ssh-private-key

**Required**

The ssh private key to the dokku instance. **Never use as plain text for security reasons!** Configure it as a secret in your repository by navigating to https://github.com/USERNAME/REPO/settings/secrets

### dokku-app-name

**Required**

The dokku app name.

### dokku-host

**Required**

The dokku host to ssh into.

### dokku-port

**Optional**

The dokku server port for ssh. Default to '22'.

### dokku-user

**Optional**

The user to use for ssh. Default to 'dokku'.

### git-branch

**Optional**

The branch to push on the remote repository. Default to 'master'.

### git-flags

**Optional**

You may set additional flags that will be passed to the `git push` command. You might want to set this parameter to `--force` if you're pushing to Dokku from other places and encounter the following error:
```bash
error: failed to push some refs to 'dokku@mydokkuhost.com:mydokkurepo'
hint: Updates were rejected because the remote contains work that you do
hint: not have locally. This is usually caused by another repository pushing
hint: to the same ref. You may want to first integrate the remote changes
hint: (e.g., 'git pull ...') before pushing again.
hint: See the 'Note about fast-forwards' in 'git push --help' for details.
```

## Example

Note: `actions/checkout` must preceed this action in order for the repository data to be exposed for the action.
It is recommended to pass `actions/checkout` the `fetch-depth: 0` parameter to avoid errors such as `shallow update not allowed`

```yml
steps:
  - uses: actions/checkout@v2
    with:
        fetch-depth: 0
  - id: deploy
    name: Deploy to dokku
    uses: sebkeller/dokku-deploy-action@v1
    with:
      # Required
      ssh-private-key: ${{ secrets.SSH_PRIVATE_KEY }}
      dokku-app-name: 'my-dokku-app-name'
      dokku-host: 'my-dokku-host.com or my-dokku-ip'

      # Optional
      dokku-port: '2222' # Default to 22
      dokku-user: 'deploy' # Default to dokku
      git-branch: 'develop' # Default to master
      git-flags: '--force' # Default to ''
```
