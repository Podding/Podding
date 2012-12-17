# Podding

A lightweight podcast CMS written in Ruby. It is using flat files as data storage and is based on the [Sinatra Web framework](http://www.sinatrarb.com/).

## Installing Podding for local development

We are using [bundler](http://gembundler.com/) to manage our dependencies and rely on Ruby 1.9. To install bundler and all the dependencies run:

```bash
# Install bundler
gem install bundler
# switch to the Podding directory
cd Podding
# Install deps
bundle install
```

To run a local development server, you just need to run `shotgun`:

```bash
cd Podding
shotgun
```

The shell output should look like this:

```
== Shotgun/Thin on http://127.0.0.1:9393/
>> Thin web server (v1.5.0 codename Knife)
>> Maximum connections set to 1024
>> Listening on 127.0.0.1:9393, CTRL+C to stop
```

## Using git submodules to check out /source

The `/source` directory was moved to a git submodule to allow separate versioning of application and content/template code.

### Submodule init

To initialize the submodules, you need to pull the latest revision of Podding and initialize the submodules:

```bash
git pull --rebase origin master
git submodule update --init
```
### Submodule update

To update changed content in the /source dir, you need to run a git pull. To automate the process, you can use:

```bash
# pull all submodules
git submodule foreach git pull origin master
```

### Change Submodule remote
First update .gitmodules with new remote, then use the following command:
```bash
git submodule sync
git submodule foreach git pull origin master