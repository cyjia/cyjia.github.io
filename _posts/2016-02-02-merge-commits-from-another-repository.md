---
layout: default
---
# Merge commits from another repository

We have worked on a repository __Addon__ for a while and made about 30 commits. Now we want to port these commits to another repostiroy __Table__, which has some connection with __Addon__ in file structure and contents but doesn't share any git history. We chose `rebase -i` after several other tries, such as `cherry-pick`, `rebase --onto`.

## Steps for our approach

### Prepare
1. clone __Table__ to table `table`.
2. `cd table`.
3. Add __Addon__ as a remote of __Table__ `git remote add addon https://github.com/xxxx/addon`.
4. Fetch __Addon__ `git fetch addon`.

### Copy 30 commits from addon to table
1. `cd addon`.
2. Create a new branch from addon/master  `git checkout -b switch-to-table addon/master`.
3. Start rebase with __Table__ `git rebase -i origin/master`.
4. Select commits you need and remove others.
5. Solve confilicts.
- Edit conflicts files.
- `git add . ; git rebase --continue`.
6. The job is done onece rebase finished. You can push switch-to-table to your fork of __Table__ and make a pull request.

### Things we observed

We found our __Merge__ commits are gone after these steps. We didn't do further study as those __Merge__ commits are empty commits that generated when merge pull requests, and we don't need them now. One guess for this result is `git rebase -i` will skip empty commits by default, maybe there are some switches to include the empty commits.

## Other steps we tried

### Use cherry-pick
Our first try is to use cherry-pick. As 30 commits seems too much for us to cherry-pick one by one, we decided to cherry-pick a range of commits. We figure out how to specify a range of revisions finally(just sha1..sha2, no need to specify branch). But the cherry-pick failed at merge commits, it asked for `-m` switch. We don't know how to give the value of __parent number__. We gave it `0`, but failed with non-merge commits.

### Use rebase with --onto
We google around and found some instructions to use `rebase --onto origin/master`. The whole process is similar to our approach, but after rebase, we didn't find our commits copied to any branch.


## Conclusion
Our approach works for copy many commits from one repository to another. If you have similar requirements, you can have a try.
