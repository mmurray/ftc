module ApplicationHelper
  
  FLASH_NOTICE_KEYS = [:error, :notice, :warning, :alert]

  def flash_messages
    return unless messages = flash.keys.select{|k| FLASH_NOTICE_KEYS.include?(k)}
    formatted_messages = messages.map do |type|      
      content_tag :div, :id => 'system-message', :class => type.to_s do
        message_for_item('<p>'+flash[type]+'</p>', flash["#{type}_item".to_sym])
      end
    end
    
    formatted_messages.join
  end

  def message_for_item(message, item = nil)
    if item.is_a?(Array)
      message % link_to(*item)
    else
      message % item
    end
  end
  
  def get_vote_cookie(trade_id)
    if(cookies[:snbatv] != nil)
      pairs = cookies[:snbatv].split(',')
      pairs.each do |pair|
        pieces = pair.split('=')
        if(pieces[0].to_s == trade_id.to_s)
          return pieces[1]
        end
      end
    end
    return false
  end
  
  def amazon_ad
    ads = [
      '<iframe src="http://rcm.amazon.com/e/cm?lt1=_blank&bc1=000000&IS2=1&bg1=000000&fc1=999999&lc1=14B8C7&t=fantasycom08-20&o=1&p=8&l=as1&m=amazon&f=ifr&asins=1416909966" style="width:120px;height:240px;" scrolling="no" marginwidth="0" marginheight="0" frameborder="0"></iframe>',
      '<iframe src="http://rcm.amazon.com/e/cm?lt1=_blank&bc1=000000&IS2=1&bg1=000000&fc1=999999&lc1=14B8C7&t=fantasycom08-20&o=1&p=8&l=as1&m=amazon&f=ifr&asins=B0002CU290" style="width:120px;height:240px;" scrolling="no" marginwidth="0" marginheight="0" frameborder="0"></iframe>',
      '<iframe src="http://rcm.amazon.com/e/cm?lt1=_blank&bc1=000000&IS2=1&bg1=000000&fc1=999999&lc1=14B8C7&t=fantasycom08-20&o=1&p=8&l=as1&m=amazon&f=ifr&asins=044669925X" style="width:120px;height:240px;" scrolling="no" marginwidth="0" marginheight="0" frameborder="0"></iframe>'
    ]
    ads[Random.new.rand(0..2)]
  end
  
  def cj180_ad2
    # fansedge
    ads = [
      '<a href="http://www.tkqlhce.com/click-4185076-10772076" target="_top"><img src="http://cdn.fantasytradecritic.com/images/ads/fansedge1.jpg" alt="Everything for the Fan" border="0"/></a>',
      '<a href="http://www.dpbolvw.net/click-4185076-10828834" target="_top"><img src="http://cdn.fantasytradecritic.com/images/ads/fansedge2.jpg" alt="Buy 2010-2011 NBA Gear at FansEdge.com" border="0"/></a>',
      '<a href="http://www.dpbolvw.net/click-4185076-10828845" target="_top"><img src="http://www.tqlkg.com/image-4185076-10828845" width="180" height="150" alt="New Apparel for the 2010-2011 NHL Season " border="0"/></a>',
      '<a href="http://www.dpbolvw.net/click-4185076-10828870" target="_top"><img src="http://www.tqlkg.com/image-4185076-10828870" width="180" height="150" alt="Buy Team Comforters at FansEdge.com" border="0"/></a>',
      '<a href="http://www.tkqlhce.com/click-4185076-10829628" target="_top"><img src="http://cdn.fantasytradecritic.com/images/ads/fansedge3.jpg" alt="2010 MLB World Series Gear at FansEdge   " border="0"/></a>'
    ]
    ads[Random.new.rand(0..4)]
  end
  
  def cj180_ad
    ads = [
      '<a href="http://www.kqzyfj.com/click-4185076-10699649" target="_top"><img src="http://cdn.fantasytradecritic.com/images/ads/footballfanatics1.jpg" alt="" border="0"/></a>',
      '<a href="http://www.tkqlhce.com/click-4185076-10800590" target="_top"><img src="http://cdn.fantasytradecritic.com/images/ads/footballfanatics2.jpg" alt="" border="0"/></a>',
      '<a href="http://www.kqzyfj.com/click-4185076-10810865" target="_top"><img src="http://cdn.fantasytradecritic.com/images/ads/alliancetickets1.jpg" alt="" border="0"/></a>'
    ]
    ads[Random.new.rand(0..2)]
  end
  
  def skyscraper_ad
    ads = [
      '<a href="http://www.jdoqocy.com/click-4185076-10754785" target="_top"><img src="http://www.awltovhc.com/image-4185076-10754785" width="160" height="600" alt="" border="0"/></a>',
      '<a href="http://www.jdoqocy.com/click-4185076-10699659" target="_top"><img src="http://www.tqlkg.com/image-4185076-10699659" width="160" height="600" alt="" border="0"/></a>',
      '<a href="http://www.jdoqocy.com/click-4185076-10828795" target="_top"><img src="http://www.lduhtrp.net/image-4185076-10828795" width="160" height="600" alt="Buy 2010-2011 NBA Gear at FansEdge.com" border="0"/></a>',
      '<a href="http://www.tkqlhce.com/click-4185076-10829624" target="_top"><img src="http://www.lduhtrp.net/image-4185076-10829624" width="160" height="600" alt="2010 MLB World Series Gear at FansEdge" border="0"/></a>',
      '<a href="http://www.kqzyfj.com/click-4185076-10815934" target="_top"><img src="http://www.tqlkg.com/image-4185076-10815934" width="160" height="600" alt="Official 2010 NFL Sideline Gear" border="0"/></a>',
      '<a href="http://www.jdoqocy.com/click-4185076-10605638" target="_top"><img src="http://www.ftjcfx.com/image-4185076-10605638" width="160" height="600" alt="Monster Jam tickets at TicketsNow.com" border="0"/></a>',
      '<a href="http://www.dpbolvw.net/click-4185076-10757429" target="_top"><img src="http://www.lduhtrp.net/image-4185076-10757429" width="160" height="600" alt="NFL Ticket Exchange" border="0"/></a>',
      '<a href="http://www.dpbolvw.net/click-4185076-10757429" target="_top"><img src="http://www.lduhtrp.net/image-4185076-10757429" width="160" height="600" alt="NFL Ticket Exchange" border="0"/></a>',
      '<a href="http://www.anrdoezrs.net/click-4185076-10755497" target="_top"><img src="http://www.awltovhc.com/image-4185076-10755497" width="160" height="600" alt="Buy WWE tickets at TicketsNow" border="0"/></a>',
      '<a href="http://www.anrdoezrs.net/click-4185076-10606599" target="_top"><img src="http://www.ftjcfx.com/image-4185076-10606599" width="160" height="600" alt="Baseball Tickets from TicketsNow.com" border="0"/></a>',
      '<a href="http://www.jdoqocy.com/click-4185076-10831594" target="_top"><img src="http://www.ftjcfx.com/image-4185076-10831594" width="160" height="600" alt="" border="0"/></a>',
      '<a href="http://www.jdoqocy.com/click-4185076-10827921" target="_top"><img src="http://www.lduhtrp.net/image-4185076-10827921" width="160" height="600" alt="" border="0"/></a>',
      '<a href="http://www.kqzyfj.com/click-4185076-10783817" target="_top"><img src="http://www.ftjcfx.com/image-4185076-10783817" width="160" height="600" alt="" border="0"/></a>',
      '<a href="http://www.tkqlhce.com/click-4185076-10812037" target="_top"><img src="http://www.lduhtrp.net/image-4185076-10812037" width="160" height="600" alt="" border="0"/></a>',
      '<a href="http://www.anrdoezrs.net/click-4185076-10821532" target="_top"><img src="http://www.tqlkg.com/image-4185076-10821532" width="160" height="600" alt="" border="0"/></a>',
      '<a href="http://www.anrdoezrs.net/click-4185076-10800607" target="_top"><img src="http://www.awltovhc.com/image-4185076-10800607" width="160" height="600" alt="" border="0"/></a>',
      '<a href="http://www.jdoqocy.com/click-4185076-10793209" target="_top"><img src="http://www.tqlkg.com/image-4185076-10793209" width="160" height="600" alt="" border="0"/></a>'
    ]
    ads[Random.new.rand(0..16)]
  end
  
end
