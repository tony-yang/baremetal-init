FROM ubuntu-dev

RUN gem install \
    berkshelf:'~> 6.0' \
    chef-zero:'~> 13.0' \
    chefspec \
    foodcritic \
    rake \
    rspec \
    rubocop

ADD . /root/
