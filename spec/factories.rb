Factory.define :doc do |f|
  f.sequence(:id) do |n|
    letter = (n+96).chr
    letter + letter + letter + letter # aaaa, bbbb, cccc, etc
  end
end

Factory.define :kbuser do |f|
  f.sequence(:username){ |n| "user#{n}" }
end

Factory.define :listed_doc do |f|
  
end

Factory.define :boiler do |f|

end

Factory.define :list do |f|

end