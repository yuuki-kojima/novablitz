class Card < ApplicationRecord
  self.inheritance_column = :_type_disabled # この行を追加

  def input_cards
    links = []
    agent = Mechanize.new

    page1 = agent.get("https://novablitz.gamepedia.com/Category:Cards")
    elements1 = page1.search('.mw-category a')

    page2 = agent.get("https://novablitz.gamepedia.com/index.php?title=Category:Cards&pagefrom=Nature+Boost")
    elements2 = page2.search('.mw-category a')

    elements1.each do |ele|
      links << ele.get_attribute('href')
    end

    elements2.each do |ele|
      links << ele.get_attribute('href')
    end

    links.each do |link|
      get_product(link)
    end
  end

  def get_product(link)
    check_name = link.delete("/").gsub(/_/, ' ')
    if Card.find_by(name: check_name).present?
      return
    end
    agent = Mechanize.new
    page = agent.get("https://novablitz.gamepedia.com" + link)
    ele = page.at('.stdinfobox')

    card_info = {}

    card_info[:name] = ele.at('.title').inner_text
    card_info[:set] = ele.search('a')[1].inner_text
    card_info[:type] = ele.search('a')[2].inner_text
    if ele.at('.image img').nil?
      # commit_params(card_info)
      return
    end
    card_info[:image] = ele.at('.image img').get_attribute('src')
    if ele.at('p').present?
      card_info[:content] = ele.at('p').inner_text
    end

    if card_info[:type] == "Unit"
      set_unit_params(ele, card_info)
      commit_unit(card_info)
    else
      set_power_params(ele, card_info)
      commit_power(card_info)
    end
    sleep(10)
  end

  private

  def set_unit_params(ele, card_info)
    card_info[:aspect] = ele.search('a')[4].inner_text
    card_info[:rarity] = ele.search('a')[5].inner_text
    card_info[:cost] = ele.search('td')[5].inner_text.to_i
    card_info[:sub_type] = ele.search('a')[3].inner_text
    card_info[:attack] = ele.search('td')[6].inner_text.to_i
    card_info[:health] = ele.search('td')[7].inner_text.to_i
  end

  def set_power_params(ele, card_info)
    card_info[:aspect] = ele.search('a')[3].inner_text
    card_info[:rarity] = ele.search('a')[4].inner_text
    card_info[:cost] = ele.search('td')[4].inner_text.to_i
  end

  def commit_unit(card_info)
    card = Card.where(name: card_info[:name]).first_or_initialize
    card.set = card_info[:set]
    card.type = card_info[:type]
    card.aspect = card_info[:aspect]
    card.rarity = card_info[:rarity]
    card.cost = card_info[:cost]
    card.sub_type = card_info[:sub_type]
    card.attack = card_info[:attack]
    card.health = card_info[:health]
    card.image = card_info[:image]
    if card_info[:content].present?
      card.content = card_info[:content]
    end
    card.save
  end

  def commit_power(card_info)
    card = Card.where(name: card_info[:name]).first_or_initialize
    card.set = card_info[:set]
    card.type = card_info[:type]
    card.aspect = card_info[:aspect]
    card.rarity = card_info[:rarity]
    card.cost = card_info[:cost]
    card.image = card_info[:image]
    card.content = card_info[:content]
    card.save
  end

  def commit_params(card_info)
    card = Card.where(name: card_info[:name]).first_or_initialize
    card.set = card_info[:set]
    card.type = card_info[:type]
    card.save
  end

end
