require 'rugged'

repo = Rugged::Repository.new('.')


# https://github.com/libgit2/rugged/issues/314#issuecomment-35207280
current_branch = repo.head.name.sub(/^refs\/heads\//, '')


local_branches = repo.branches.each_name(:local).to_a
remote_branches = repo.branches.each_name(:remote).map{|b| b.split('/', 2)[1] }
remote_branches.delete('HEAD')

branches_to_check_out = remote_branches - local_branches
# check out all branches locally
branches_to_check_out.each do |branch|
  `git checkout #{branch} && git pull`
end


# assume that the origin version is the merge-base
branches_to_update = `git branch --contains origin/#{current_branch} | cut -c 3-`.split("\n")
branches_to_update.delete(current_branch)

# order by those with the most child branches
# TODO depth-first search?
# https://github.com/libgit2/rugged#commit-walker
branches_to_update.sort_by! {|branch| `git branch --contains #{branch}`.split("\n").size }.reverse!

last = current_branch
branches_to_update.each do |branch|
  `git checkout #{branch}`
  `git rebase #{last} #{branch}`
  last = branch
end
