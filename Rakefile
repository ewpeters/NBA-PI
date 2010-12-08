# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require(File.join(File.dirname(__FILE__), 'config', 'boot'))

require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'

require 'tasks/rails'

namespace :user do 
  desc "Pick a random product as the prize"
  task :parse => :environment do
    file = File.new("players", "r")
    current_team = nil
    current_player = nil
    while (line = file.gets)
      team = team_name(line)
      if team
        current_team = Team.find_or_create_by_name(team)
        puts "Created team #{team}"
      elsif line.gsub(/\s+/, '').length != 0
        if !has_dash(line)
          current_player = Player.find_or_create_by_name(player_name(line))
          puts "Created player #{current_player.name} on #{current_team.name}"
          current_player.team = current_team
          current_player.save
        else
          twitter_name = line.gsub('@', '').gsub(/\s+/, '')
          twitter_name = remove_dash(twitter_name)
          current_player.twitter_name = twitter_name
          puts "with twitter_name #{twitter_name}"
          current_player.save
        end
      end
    end
    file.close
  end
  
  desc "Get the team name"
  task :all => [:parse]
  def team_name(line)
    stuff = line.gsub(/\s+/, '')
    array = stuff.split(//u)
    index = array.index("\226") || array.index('-')
    if index && index > 0
      team = array[0..(index-1)].join('')
      team_name = team.split(/(?=[A-Z])/).join('_').gsub('_', ' ')
    else
      nil
    end
  end
  
  desc "does the line have a dash"
  task :all => [:parse]
  def has_dash(line)
    stuff = line.gsub(/\s+/, '')
    array = stuff.split(//u)
    array.index("\226") || array.index('-')
  end
    
  desc "Get the team name"
  task :all => [:parse]
  def player_name(line)
    stuff = line.gsub(/\s+/, '')
    stuff.split(/(?=[A-Z])/).join('_').gsub('_', ' ')
  end
  
  desc "Get the team name"
  task :all => [:parse]
  def remove_dash(line)
    line.gsub!(/\s+/, '')
    array = line.split(//u)
    array.delete("\226")
    array.delete('-')
    array.join('')
  end

end