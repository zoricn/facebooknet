module KoalaService
  def self.graph_from(token)
    Koala::Facebook::API.new(@access_token)
  end

  def self.get_twenty_friends(graph)
    friends = graph.get_connections("me", "friends", :fields => "birthday,name")
    return friends.sort! { |a,b| a["name"].downcase <=> b["name"].downcase }.first 20 || []
  end

end
