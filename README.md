# Advance Computer Engineering 

## Git Setup

Create a username

```
 $ git config --global user.name "YOURGITHUBUSERNAME"
```

Create an email

```
 $ git config --global user.email "YOURGITHUBEMAIL"
```

While we are at it lets change the defualt text editor for the config

```
 $ git config --global core.editor nano

```

### SSH-KEY

Now we need to generate and add a shh key 

```
 $ ssh-keygen -t ed25519 -C "YOURGITHUBEMAIL"
```

This creates a new ssh key, using the provided email as a label.

```
 > Generating public/private ed25519 key pair.
```

When you're prompted to "Enter a file in which to save the key," press Enter. This accepts the default file location.

```
 > Enter a file in which to save the key (/home/you/.ssh/id_ed25519): [Press enter]
```

At the prompt, type a secure passphrase. For more information, see "Working with SSH key passphrases."

```
 > Enter passphrase (empty for no passphrase): [Type a passphrase]
 > Enter same passphrase again: [Type passphrase again]
```
Now ```cat``` the key and enter it into the github.com settings ssh/gpg key  

```
 $ cat ~/.ssh/id_ed255519.pub
```

## Testing Connection

To test the ssh connection do the following.

```
 $ ssh -T git@github.com
 # Attempts to ssh to GitHub
```

You may see a warning like this:

```
 > The authenticity of host 'github.com (IP ADDRESS)' can't be established.
 > RSA key fingerprint is SHA256:nThbg6kXUpJWGl7E1IGOCspRomTxdCARLviKw6E5SY8.
 > Are you sure you want to continue connecting (yes/no)?
```

Verify that the fingerprint in the message you see matches GitHub's RSA public key fingerprint. If it does, then type yes:

```
 > Hi username! You've successfully authenticated, but GitHub does not
 > provide shell access.
```

## Get a repo

```
$ git clone git@github.com:USERNAME/REPO.git
```

### HTTPS to SSH
```
 > git remote set-url origin git@github.com:USERNAME/REPOSITORY.git
```


