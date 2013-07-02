# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

nfl = League.create({:name=>"National Football League",:abbreviation=>"NFL",:sport=>"Football"})
mlb = League.create({:name=>"Major League Baseball",:abbreviation=>"MLB",:sport=>"Baseball"})
nhl = League.create({:name=>"National Hockey League",:abbreviation=>"NHL",:sport=>"Hockey"})
nba = League.create({:name=>"National Basketball Association",:abbreviation=>"NBA",:sport=>"Basketball"})


User.create({:username=>"murz",:email=>"m@murz.net",:password=>"password",:is_admin=>"true",:confirmation_token=>'nilkj',:confirmed_at=>Date.new(2009,12,31)})

