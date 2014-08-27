class DiggApi
  def self.parse(response_body)
    result = {}
    items = []
    stripped_text = response_body.strip.gsub("\n", "")
    stripped_text.scan(/<item>.*?<\/item>/) do |item|
      items << item
    end

    count = 0
    items.each do |item|
      title_index = item.index("<title>")
      end_title_index = item.index("</title>")
      title = item[title_index+7...end_title_index]

      description_index = item.index("<description>")
      end_description_index = item.index("</description")
      description = item[description_index+13...end_description_index]

      link_index = item.index("<link>")
      end_link_index = item.index("</link>")
      link = item[link_index+6...end_link_index]

      guid_index = item.index("<guid>")
      end_guid_index = item.index("</guid>")
      guid = item[guid_index+6...end_guid_index]

      date_index = item.index("<pubDate>")
      end_date_index = item.index("</pubDate>")
      date = item[date_index+9...end_date_index]

      result[count] = {
        :title => title,
        :description => description,
        :link => link,
        :guid => guid,
        :date => date
      }
      count += 1
    end

    result
  end

  def self.get_response(url)
    Net::HTTP.get_response(URI(url))
  end
end