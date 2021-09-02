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
cat ~/.ssh/id_ed255519.pub
```

## Using SSH connection

```
 > git remote set-url origin git@github.com:USERNAME/REPOSITORY.git
```


