# frozen_string_literal: true

class WalmartParser
  attr_reader :url, :name, :price, :reviews

  def initialize(url)
    @url = url
  end

  def parse
    parse_name
    parse_price
    parse_review
  rescue
    # TODO: if can't parse the page, notify user
  end

  private

  def parse_name
    names = doc.css('h1.prod-ProductTitle div')
    @name = names.map(&:text).first
  end

  def parse_price
    @price = doc.css('.Price-group').attr('aria-label').value
  end

  # TODO: browser.link(text: 'Next Page').click
  def parse_review
    @reviews = doc.css('.review-body').map(&:text)
  end

  def page
    open(url).read
  end

  def doc
    @doc ||= Nokogiri.parse(page)
  end
end
