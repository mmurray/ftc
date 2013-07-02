require 'hpricot'
require 'net/http'
require 'aws/s3'

class RobotController < ApplicationController
  
  def clear_nfl_cache
    Rails.cache.delete("league-NFL")
    Rails.cache.delete("allPlayers-NFL")
    expire_fragment(:controller=>"trades",:action=>"new", :action_suffix=>"tradeForm-NFL")
  end

  def absorb
    self.absorb_nfl
    self.absorb_mlb
  end

  def absorb_nfl
    self.absorb_nfl_teams
    self.absorb_nfl_players
  end
  
  def absorb_nfl_teams
    print "absorbing nfl teams...", "\n"
    @nfl = League.where("upper(abbreviation) = ?","NFL")[0]
    team_url = 'http://sports.yahoo.com/nfl/teams'
    team_html = Net::HTTP.get(URI.parse(team_url))
    team_doc = Hpricot(team_html)
    team_doc.search("//table[@class='yspcontent']/tr/td/table/tr/td/table/tr[@class != 'yspsctbg']/td/a").each do |a|
      abbr = a.attributes['href'].gsub("/nfl/teams/","").gsub("/","")
      full_name = a.inner_html
      names = full_name.split(' ')
      name = names[names.length-1]
      city = full_name.gsub(" "+name,"") 
      if(!Team.where("upper(abbreviation) = ?",abbr.upcase).exists?)
        @team = Team.new(:name=>name,:city=>city,:abbreviation=>abbr,:league_id=>@nfl.id)
        @team.save()
      end
    end
  end
  
  def absorb_nfl_players
    print "absorbing nfl players...", "\n"
    @nfl = League.where("upper(abbreviation) = ?","NFL")[0]
    @teams = Team.where("league_id = ?",@nfl.id)
    
    
    @teams.each do |team|
      player_url = "http://sports.yahoo.com/nfl/teams/"+team.abbreviation.downcase+"/roster"
      player_html = Net::HTTP.get(URI.parse(player_url))
      player_doc = Hpricot(player_html)
      player_doc.search("//div[@id='team-roster']/div/table/tbody/tr").each do |tr|
        tds = tr.search("//td")
        a = tr.search("//th[@scope='row']/a")[0]
        position = tds[1].inner_html
        college = tds[6].inner_html
        salary = tds[7].inner_html
        names = a.inner_html.split(', ')
        name = names[1] + ' ' + names[0]
        if(!Player.where("name = ? and team_id = ?",name,team.id).exists?)
          player = Player.new(:name=>name,:team_id=>team.id,:league_id=>@nfl.id,:position=>position,:salary=>salary,:college=>college,:photo=>a.attributes['href'])
          player.save
        end
      end  
    end
    
    # @player_url = 'http://sports.yahoo.com/nfl/teams'
    # team_html = Net::HTTP.get(URI.parse(@team_url))
    # team_doc = Hpricot(team_html)
    # print team_doc.search("//table[@class='yspcontent']/tr/td/table/tr/td/table/tr[@class != 'yspsctbg']/td/a").length
    # team_doc.search("//table[@class='yspcontent']/tr/td/table/tr/td/table/tr[@class != 'yspsctbg']/td/a").each do |a|
    #   abbr = a.attributes['href'].gsub("/nfl/teams/","").gsub("/","")
    #   full_name = a.inner_html
    #   names = full_name.split(' ')
    #   name = names[names.length-1]
    #   city = full_name.gsub(" "+name,"") 
    #   if(!Team.where("upper(abbreviation) = ?",abbr.upcase).exists?)
    #     @team = Team.new(:name=>name,:city=>city,:abbreviation=>abbr,:league_id=>@nfl.id)
    #     @team.save()
    #   end
    # end
  end
  
  def nfl_players_to_s3

    base_url = 'http://sports.yahoo.com'

    AWS::S3::Base.establish_connection!
    Player.all.each do |player|
      url = base_url + player.photo
      puts url
      player_html = Net::HTTP.get(URI.parse(url))
      puts 'okay!'
      player_doc = Hpricot(player_html)
      player_doc.search("//div[@id='ysp-player-nav']/img").each do |img|
      
      Net::HTTP.start("l.yimg.com") { |http|
        resp = http.get( img.attributes['src'].gsub("http://l.yimg.com","") )
        puts img.attributes['src'].gsub("http://l.yimg.com","")
        open(  'tmp/playerimgs/' + player.id.to_s + '.jpg', 'w+' ) { |file|
          file.write(resp.body.force_encoding("UTF-8"))
          #ftc_bucket = Bucket.find('ftc-static')
          AWS::S3::S3Object.store('/players/' + player.id.to_s + '.jpg',file,'ftc-static')
          
        }
      }

      end
    end       
  end
  
  def fix_missing_nfl_images
    
    AWS::S3::Base.establish_connection!(
      :access_key_id     => '', 
      :secret_access_key => ''
    )
    
    players = Player.all
    players.each do |player|
      Net::HTTP.start("cdn.fantasytradecritic.com") { |http|
        resp = http.get('/players/' + player.id.to_s + '.jpg')
        if(resp.body == "")
          open('public/missing-player.jpg', 'r') { |file|
            AWS::S3::S3Object.store('/players/' + player.id.to_s + '.jpg',file,'ftc-static')
          }
        end
      }
    end
    
  end
  
  def fix_nfl_salary
    
    players.each do |player|
      
    end
    
  end
  
  def absorb_mlb
    
  end
  
end
