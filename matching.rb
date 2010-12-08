count = 0
cursor = -1
names = []
keywords = ["babe", "sex" "candy", "goddess", "actress", "hostess", "woman", "princess", "model", "chick", "girl", "lady", "booking", "vixen", "bikini", "porn", "dancer", "massage"]
while cursor != 0
f = Twitter.friends("jermaineoneal", :cursor => cursor)
f.users.each do |u|
  if !u.verified
    if u.name && u.description
      name = u.name.downcase
      desc = u.description.downcase
      if keywords.any? {|str| desc.include?(str) || name.include?(str)}
        count += 1
        names << u.name
      end
    end
  end
end
cursor = f.next_cursor
end