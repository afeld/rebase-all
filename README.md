# Rebase All

Rebase all descendant branches. For example, you add commit `F` on `master`:

```
A-B-F (master)
   \   D (feature-a)
    \ /
     C (feature)
      \
       E (feature-b)
```

and want to rebase all the branches that were made off of `master`, so it looks like this:

```
A-B-F (master)
     \   D' (feature-a)
      \ /
       C' (feature)
        \
         E' (feature-b)
```

## Usage

Requires Ruby 1.9.3+. Download/clone this repository, then run:

```bash
# https://github.com/libgit2/rugged#install
brew install cmake

cd path/to/your/project/repo
gem install rugged
ruby path/to/rebase_all.rb
```