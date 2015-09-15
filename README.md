# install bundle
```
cat << GEMFILE > ./Gemfile
source "https://rubygems.org"

gem "chef"
gem "chef-dk"
GEMFILE
bundle install
```

# create chef cookbooks
```
bundle exec chef generate cookbook test
```
