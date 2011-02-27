xml.instruct!
xml.offers do
  @offers.each do |offer|
    xml.offer do
      xml.title offer.title
      xml.final_price offer.final_price
      xml.original_price offer.original_price
      xml.discount_percentage offer.discount_percentage
      xml.expires_at offer.expires_at.strftime("%b. %d %Y - %A, %I:%M %p")
      xml.url offer.url
      xml.place "#{offer.place.name} - #{offer.place.address}"
      xml.site offer.site.name.nil? || offer.site.name.blank? ? offer.site.url : "#{offer.site.name} - #{offer.site.url}"
    end
  end
end